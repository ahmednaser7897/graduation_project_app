import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../home.dart';
part 'send_images_state.dart';

class SendImagesCubit extends Cubit<SendImagesState> {
  SendImagesCubit() : super(SendImagesInitial());
  static SendImagesCubit get(context) => BlocProvider.of(context);
  String? result;
  File? prediction;
  var url = "http://127.0.0.1:5000//predictApi";
  Future<void> upload({
    required File image1,
    required File image2,
    required BuildContext context,
  }) async {
    emit(LoadinSendImages());
    try {
      prediction = null;
      final request = http.MultipartRequest("POST", Uri.parse(url));
      //final header = {"Content_type": "multipart/form-data"};
      request.files.add(http.MultipartFile(
          'image1', image1.readAsBytes().asStream(), image1.lengthSync(),
          filename: image1.path.split('/').last));
      request.files.add(http.MultipartFile(
          'image2', image2.readAsBytes().asStream(), image2.lengthSync(),
          filename: image2.path.split('/').last));
      request.files.forEach((element) {
        print("element.filename");
        print(element.field);
        print(element.filename);
      });
      //request.headers.addAll(header);
      final myRequest = await request.send();
      http.Response res = await http.Response.fromStream(myRequest);
      if (myRequest.statusCode == 200) {
        final resJson = jsonDecode(res.body);
        print("response here: $resJson");
        result = resJson['prediction'];
        if (result != null) {
          prediction = await createFileFromString(result.toString());
          print(prediction!.path);
        } else if (resJson['Error'] != null) {
          buildToast(context, resJson['Error']);
        }
      } else {
        print("Error ${myRequest.statusCode}");
        buildToast(context, "Error ${myRequest.reasonPhrase ?? ""}");
      }
      emit(SCSendImages());
    } catch (e) {
      print("Error ${e.toString()}");
      buildToast(context, "Something went wrong, please try again");
      emit(ErorrSendImages());
    }
  }

  Future<File> createFileFromString(String encodedStr) async {
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
    await file.writeAsBytes(bytes);
    return File(file.path);
  }

  // Future<void> uploadDio({
  //   required File image1,
  //   required File image2,
  // }) async {
  //   emit(LoadinSendImages());
  //   try {
  //     final header = {"Content_type": "multipart/form-data"};
  //     Dio dio = Dio(BaseOptions(
  //         baseUrl: url, receiveDataWhenStatusError: false, headers: header));
  //     final data = FormData();
  //     data.files.add(MapEntry(
  //       'image1',
  //       MultipartFile.fromFileSync(
  //         image1.path,
  //         filename: image1.path.split(Platform.pathSeparator).last,
  //       ),
  //     ));
  //     data.files.add(MapEntry(
  //       'image2',
  //       MultipartFile.fromFileSync(
  //         image2.path,
  //         filename: image2.path.split(Platform.pathSeparator).last,
  //       ),
  //     ));

  //     Response myRequest = await dio.post("", data: data);
  //     if (myRequest.statusCode == 200) {
  //       print("response here: $myRequest.data");
  //       result = myRequest.data['prediction'];
  //     } else {
  //       print("Error ${myRequest.statusCode}");
  //     }
  //     emit(SCSendImages());
  //   } catch (e) {
  //     print("Error ${e.toString()}");
  //     emit(ErorrSendImages());
  //   }
  // }
}

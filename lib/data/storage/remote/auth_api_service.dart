import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../app/api_urls.dart';
import '../../model/auth/login_response.dart';
import '../../model/base_response.dart';
import '../../request/auth/login_request.dart';
import '../../request/base_request.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiUrls.baseUrl)
abstract class AuthServiceClient {
  factory AuthServiceClient(Dio dio, {String baseUrl}) = _AuthServiceClient;

  @POST(ApiUrls.login)
  Future<BaseResponse<LoginResponse>> login(
      {@Body() required BaseRequest<LoginRequestData> body});
/*
  @GET('${ApiUrls.getUserAddressByAddressId}{Id}')
  Future<BaseResponse<AddressModel>> getUserAddressByAddressId(
      @Path("Id") String id);

  @DELETE(ApiUrls.deleteProductImage)
  Future<BaseResponse<bool>> deleteProductImage({
    @Query("ImageId") required String imageId,
  });

  @MultiPart()
  @POST(ApiUrls.register)
  Future<BaseResponse<RegisterResponse>> userRegister(
      {@Part(name: "Data.FirstName") required String firstName,
      @Part(name: "Data.LastName") required String lastName,
      @Part(name: "Data.UserName") required String userName,
      @Part(name: "Data.Email") required String email,
      @Part(name: "Data.PhoneNumber") required String phone,
      @Part(name: "Data.Password") required String password,
      @Part(name: "Data.Type") required int type,
      @Part(name: "Data.Latitude") required double lat,
      @Part(name: "Data.Longitude") required double lon,
      @Part(name: "Data.Photo") File? photo});
  */
}

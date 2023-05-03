import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:graduation_project/app/di/module/dio_module.dart';

import '../../app/di/di.dart';
import '../../app/network/error_handler.dart';
import '../../app/network/save_api.dart';
import '../model/auth/login_response.dart';
import '../model/base_response.dart';
import '../request/auth/login_request.dart';
import '../request/base_request.dart';
import '../storage/local/app_prefs.dart';
import '../storage/remote/auth_api_service.dart';

@injectable
class AuthRepository {
  final AuthServiceClient _appServiceClient;
  final SafeApi safeApi;
  final AppPreferences appPreferences;

  AuthRepository(
    this._appServiceClient,
    this.safeApi,
    this.appPreferences,
  );

  Future<Either<Failure, BaseResponse<LoginResponse>>> login(
      LoginRequestData loginRequest) async {
    Future<Either<Failure, BaseResponse<LoginResponse>>> data = safeApi.call(
        apiCall: _appServiceClient.login(body: BaseRequest(loginRequest)));
    data.then((value) =>
        value.fold((l) => {}, (r) => {saveAsAuthenticatedUser(r.result!)}));
    return data;
  }

  void saveAsAuthenticatedUser(LoginResponse data) {
    appPreferences.userToken = data.token!.accessToken.toString();
    appPreferences.userData = data.user!;
    getIt<Dio>().updateHeader(appPreferences);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestData _$LoginRequestDataFromJson(Map<String, dynamic> json) =>
    LoginRequestData(
      email: json['email'] as String?,
      password: json['password'] as String?,
      userDevicesInfo: json['userDevicesInfo'] == null
          ? null
          : UserDevicesInfo.fromJson(
              json['userDevicesInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginRequestDataToJson(LoginRequestData instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'userDevicesInfo': instance.userDevicesInfo,
    };

import 'package:json_annotation/json_annotation.dart';
part 'login_request.g.dart';


@JsonSerializable()
class LoginRequestData {
  String? email;
  String? password;
  UserDevicesInfo? userDevicesInfo;

  LoginRequestData({this.email, this.password, this.userDevicesInfo});

  factory LoginRequestData.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestDataToJson(this);
}

class UserDevicesInfo {
  String? userId;
  String? deviceId;
  String? deviceInfo;
  String? tokenUid;
  @JsonKey(name: "osversion")
  String? osVersion;
  String? manufacture;
  String? network;
  @JsonKey(name: "sdkversion")
  String? sdkVersion;
  String? deviceName;
  String? appVersion;
  int? tokenType;
  String? userIp;

  UserDevicesInfo(
      {this.userId ,
      this.deviceId ,
      this.deviceInfo ,
      this.tokenUid ,
      this.osVersion ,
      this.manufacture ,
      this.network ,
      this.sdkVersion ,
      this.deviceName ,
      this.appVersion ,
      this.tokenType ,
      this.userIp });

  factory UserDevicesInfo.fromJson(Map<String, dynamic> json) =>
      UserDevicesInfo(
        userId:
            json['userId'] as String? ,
        deviceId: json['deviceId'] as String? ,
        deviceInfo: json['deviceInfo'] as String? ,
        tokenUid: json['tokenUid'] as String? ,
        osVersion: json['osversion'] as String? ,
        manufacture: json['manufacture'] as String? ,
        network: json['network'] as String? ,
        sdkVersion: json['sdkversion'] as String? ,
        deviceName: json['deviceName'] as String? ,
        appVersion: json['appVersion'] as String? ,
        tokenType: json['tokenType'] as int? ,
        userIp: json['userIp'] as String? ,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        if (userId != null) 'userId': userId,
        if (deviceId != null) 'deviceId': deviceId,
        if (deviceInfo != null) 'deviceInfo': deviceInfo,
        if (tokenUid != null) 'tokenUid': tokenUid,
        if (osVersion != null) 'osversion': osVersion,
        if (manufacture != null) 'manufacture': manufacture,
        if (network != null) 'network': network,
        if (sdkVersion != null) 'sdkversion': sdkVersion,
        if (deviceName != null) 'deviceName': deviceName,
        if (appVersion != null) 'appVersion': appVersion,
        if (tokenType != null) 'tokenType': tokenType,
        if (userIp != null) 'userIp': userIp,
      };
}

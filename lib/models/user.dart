class User {
  Data? data;

  User({this.data});

  User.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  late int status;
  late String message;
  late String accessToken;
  UserInfo? userInfo;

  Data({
    required this.status,
    required this.message,
    required this.accessToken,
    this.userInfo,
  });

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    accessToken = json['access_token'];
    userInfo = json['PatientInformation'] != null ? UserInfo.fromJson(json['PatientInformation']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['access_token'] = accessToken;
    if (userInfo != null) {
      data['PatientInformation'] = userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? id;
  String? name;
  String? email;
  String? mobileNo;

  UserInfo({
    this.id,
    this.name,
    this.email,
    this.mobileNo,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['TableID'];
    name = json['NameA'];
    email = json['Email'];
    mobileNo = json['MobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['NameA'] = name;
    data['Email'] = email;
    data['MobileNo'] = mobileNo;
    return data;
  }
}

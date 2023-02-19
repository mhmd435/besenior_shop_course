/// message : "کد با موفقیت ارسال شد"
/// status : "success"
/// data : {"code":963036,"hash":""}

class LoginWithSmsModel {
  LoginWithSmsModel({
      this.message, 
      this.status, 
      this.data,});

  LoginWithSmsModel.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  String? status;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// code : 963036
/// hash : ""

class Data {
  Data({
      this.code, 
      this.hash,});

  Data.fromJson(dynamic json) {
    code = json['code'];
    hash = json['hash'];
  }
  int? code;
  String? hash;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['hash'] = hash;
    return map;
  }

}
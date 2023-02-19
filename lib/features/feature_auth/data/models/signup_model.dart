/// message : "ثبت نام شما با موفقیت انجام شد"
/// status : "success"
/// data : {"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbml5YXouc2hvcFwvYXBpXC92MVwvcmVnaXN0ZXIiLCJpYXQiOjE2NjUzMDM0NTksImV4cCI6MTY2NTMwNzA1OSwibmJmIjoxNjY1MzAzNDU5LCJqdGkiOiJ3SGpaOXk1SGdTaU5hSHJqIiwic3ViIjoxMCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.dRWrY2LQ5JppeGcKWoyAx--QUORBkNuz2JcGjPO84oU"}

class SignupModel {
  SignupModel({
      this.message, 
      this.status, 
      this.data,});

  SignupModel.fromJson(dynamic json) {
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

/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbml5YXouc2hvcFwvYXBpXC92MVwvcmVnaXN0ZXIiLCJpYXQiOjE2NjUzMDM0NTksImV4cCI6MTY2NTMwNzA1OSwibmJmIjoxNjY1MzAzNDU5LCJqdGkiOiJ3SGpaOXk1SGdTaU5hSHJqIiwic3ViIjoxMCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.dRWrY2LQ5JppeGcKWoyAx--QUORBkNuz2JcGjPO84oU"

class Data {
  Data({
      this.token,
      this.name,
      this.mobile,});

  Data.fromJson(dynamic json) {
    token = json['token'];
    name = json['name'];
    mobile = json['mobile'];
  }
  String? token;
  String? name;
  String? mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['name'] = name;
    map['mobile'] = mobile;
    return map;
  }

}
/// access_token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbml5YXouc2hvcFwvYXBpXC92MVwvYXV0aFwvbG9naW5XaXRoU21zXC9jaGVjayIsImlhdCI6MTY2NTMxMjA3NywiZXhwIjoxNjY1MzE1Njc3LCJuYmYiOjE2NjUzMTIwNzcsImp0aSI6IlFJZWgxOXMzWXh0Q3lLN3ciLCJzdWIiOjksInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.dY6P6LFVtw6XwB50nG_pcnruUkPo9ddvCdbaLpnkBvc"
/// token_type : "bearer"
/// expires_in : 3600

class CodeModel {
  CodeModel({
      this.accessToken, 
      this.name,
      this.mobile,
      this.tokenType,
      this.expiresIn,});

  CodeModel.fromJson(dynamic json) {
    accessToken = json['access_token'];
    name = json['name'];
    mobile = json['mobile'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }
  String? accessToken;
  String? name;
  String? mobile;
  String? tokenType;
  int? expiresIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['name'] = name;
    map['mobile'] = mobile;
    map['token_type'] = tokenType;
    map['expires_in'] = expiresIn;
    return map;
  }

}
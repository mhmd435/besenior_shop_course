/// message : "با موفقیت دریافت شد"
/// status : "success"
/// data : [{"id":1,"title":"محصولات ارگانیک","img":"https://niyaz.shop/images/image-not-found.png","childs":[{"id":2,"title":"میوه ارگانیک","img":"https://niyaz.shop/images/image-not-found.png","childs":null},{"id":3,"title":"سبزیجات ارگانیک","img":"https://niyaz.shop/images/image-not-found.png","childs":null}]},{"id":4,"title":"میوه خشک","img":"https://niyaz.shop/images/image-not-found.png","childs":null}]

class CategoriesModel {
  CategoriesModel({
      this.message, 
      this.status, 
      this.data,});

  CategoriesModel.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  String? message;
  String? status;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// title : "محصولات ارگانیک"
/// img : "https://niyaz.shop/images/image-not-found.png"
/// childs : [{"id":2,"title":"میوه ارگانیک","img":"https://niyaz.shop/images/image-not-found.png","childs":null},{"id":3,"title":"سبزیجات ارگانیک","img":"https://niyaz.shop/images/image-not-found.png","childs":null}]

class Data {
  Data({
      this.id, 
      this.title, 
      this.img, 
      this.icon,
      this.childs,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    icon = json['icon'];
    if (json['childs'] != null) {
      childs = [];
      json['childs'].forEach((v) {
        childs?.add(Childs.fromJson(v));
      });
    }
  }
  int? id;
  String? title;
  String? img;
  String? icon;
  List<Childs>? childs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['img'] = img;
    map['icon'] = icon;
    if (childs != null) {
      map['childs'] = childs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// title : "میوه ارگانیک"
/// img : "https://niyaz.shop/images/image-not-found.png"
/// childs : null

class Childs {
  Childs({
      this.id, 
      this.title, 
      this.img, 
      this.childs,});

  Childs.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    childs = json['childs'];
  }
  int? id;
  String? title;
  String? img;
  dynamic childs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['img'] = img;
    map['childs'] = childs;
    return map;
  }

}
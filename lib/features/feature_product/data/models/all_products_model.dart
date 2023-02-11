/// message : "با موفقیت دریافت شد"
/// status : "success"
/// data : [{"products":[{"id":120,"image":"https://niyaz.shop/uploads/products/ازگیل-16633545536048089.png","name":"ازگیل","price":"42,000","priceBeforDiscount":"0","discount":0,"callStatus":0,"specialDiscount":0,"star":3,"category":"محصولات ارگانیک"}],"count":81,"nextStart":15,"more":true}]

class AllProductsModel {
  AllProductsModel({
      this.message, 
      this.status, 
      this.data,});

  AllProductsModel.fromJson(dynamic json) {
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

/// products : [{"id":120,"image":"https://niyaz.shop/uploads/products/ازگیل-16633545536048089.png","name":"ازگیل","price":"42,000","priceBeforDiscount":"0","discount":0,"callStatus":0,"specialDiscount":0,"star":3,"category":"محصولات ارگانیک"}]
/// count : 81
/// nextStart : 15
/// more : true

class Data {
  Data({
      this.products, 
      this.count, 
      this.nextStart, 
      this.more,});

  Data.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    count = json['count'];
    nextStart = json['nextStart'];
    more = json['more'];
  }
  List<Products>? products;
  int? count;
  int? nextStart;
  bool? more;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    map['nextStart'] = nextStart;
    map['more'] = more;
    return map;
  }

}

/// id : 120
/// image : "https://niyaz.shop/uploads/products/ازگیل-16633545536048089.png"
/// name : "ازگیل"
/// price : "42,000"
/// priceBeforDiscount : "0"
/// discount : 0
/// callStatus : 0
/// specialDiscount : 0
/// star : 3
/// category : "محصولات ارگانیک"

class Products {
  Products({
      this.id, 
      this.image, 
      this.name, 
      this.price, 
      this.priceBeforDiscount, 
      this.discount, 
      this.callStatus, 
      this.specialDiscount, 
      this.star, 
      this.category,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    priceBeforDiscount = json['priceBeforDiscount'];
    discount = json['discount'];
    callStatus = json['callStatus'];
    specialDiscount = json['specialDiscount'];
    star = json['star'];
    category = json['category'];
  }
  int? id;
  String? image;
  String? name;
  String? price;
  String? priceBeforDiscount;
  int? discount;
  int? callStatus;
  int? specialDiscount;
  int? star;
  String? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name'] = name;
    map['price'] = price;
    map['priceBeforDiscount'] = priceBeforDiscount;
    map['discount'] = discount;
    map['callStatus'] = callStatus;
    map['specialDiscount'] = specialDiscount;
    map['star'] = star;
    map['category'] = category;
    return map;
  }

}
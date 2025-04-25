import '../data/bonus_shop.dart';
import '../data/product_data.dart';

class CartCalculateResponse {
  CartCalculateResponse({
    String? timestamp,
    bool? status,
    String? message,
    CartCalculateData? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  CartCalculateResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _data =
        json['data'] != null ? CartCalculateData.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  CartCalculateData? _data;

  CartCalculateResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    CartCalculateData? data,
  }) =>
      CartCalculateResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  CartCalculateData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class CartCalculateData {
  CartCalculateData({
    List<ProductData>? products,
    num? productTax,
    num? productTotal,
    num? orderTax,
    num? orderTotal,
    num? totalDiscount,
    BonusShop? bonusShop,
  }) {
    _products = products;
    _productTax = productTax;
    _productTotal = productTotal;
    _orderTax = orderTax;
    _orderTotal = orderTotal;
    _totalDiscount = totalDiscount;
    _bonusShop = bonusShop;
  }

  CartCalculateData.fromJson(dynamic json) {
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(ProductData.fromJson(v));
      });
    }
    _productTax = json['product_tax'];
    _productTotal = json['product_total'];
    _orderTax = json['order_tax'];
    _orderTotal = json['order_total'];
    _totalDiscount = json['total_discount'];
    _bonusShop = json['bonus_shop'] != null
        ? BonusShop.fromJson(json['bonus_shop'])
        : null;
  }

  List<ProductData>? _products;
  num? _productTax;
  num? _productTotal;
  num? _orderTax;
  num? _orderTotal;
  num? _totalDiscount;
  BonusShop? _bonusShop;

  CartCalculateData copyWith({
    List<ProductData>? products,
    num? productTax,
    num? productTotal,
    num? orderTax,
    num? orderTotal,
    num? totalDiscount,
    BonusShop? bonusShop,
  }) =>
      CartCalculateData(
        products: products ?? _products,
        productTax: productTax ?? _productTax,
        productTotal: productTotal ?? _productTotal,
        orderTax: orderTax ?? _orderTax,
        orderTotal: orderTotal ?? _orderTotal,
        totalDiscount: totalDiscount ?? _totalDiscount,
        bonusShop: bonusShop ?? _bonusShop,
      );

  List<ProductData>? get products => _products;

  num? get productTax => _productTax;

  num? get productTotal => _productTotal;

  num? get orderTax => _orderTax;

  num? get orderTotal => _orderTotal;

  num? get totalDiscount => _totalDiscount;

  BonusShop? get bonusShop => _bonusShop;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    map['product_tax'] = _productTax;
    map['product_total'] = _productTotal;
    map['order_tax'] = _orderTax;
    map['order_total'] = _orderTotal;
    map['total_discount'] = _totalDiscount;
    if (_bonusShop != null) {
      map['bonus_shop'] = _bonusShop?.toJson();
    }
    return map;
  }
}

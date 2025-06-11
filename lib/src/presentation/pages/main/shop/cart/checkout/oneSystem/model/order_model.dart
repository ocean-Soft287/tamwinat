class OrderModel {
  final List<Map<String, dynamic>> images;
  final String orderDate;
  final String customerPhone;
  final String customerName;
  final String? districtName;
  final String? regionName;
  final String? block;
  final String? street;
  final String? house;
  final String? gada;
  final String? floor;
  final String? apartment;
  final String? discountCode;
  final String email;
  final String deliveryDate;
  final String deliveryDay;
  final String orderTime;
  final num additions;
  final num totalValue;
  final num discount;
  final num finalValue;
  final num payID;
  final num onlineStoreId;
  final int deliveryID;
  final String details;
  final dynamic discountCardValue;
  final List<Map<String, dynamic>> orderList;
  final String? customerAddress;
  final String? customerMapAddress;
  final String? placeId;
  final dynamic paymentMethodWallet;
  final dynamic discountPointsValue;

  OrderModel({
    required this.images,
    required this.orderDate,
    required this.customerPhone,
    required this.customerName,
    this.districtName,
    this.regionName,
    this.block,
    this.street,
    this.house,
    this.gada,
    this.floor,
    this.apartment,
    this.discountCode,
    required this.email,
    required this.deliveryDate,
    required this.deliveryDay,
    required this.orderTime,
    required this.additions,
    required this.totalValue,
    required this.discount,
    required this.finalValue,
    required this.payID,
    required this.onlineStoreId,
    required this.deliveryID,
    required this.details,
    required this.discountCardValue,
    required this.orderList,
    this.customerAddress,
    this.customerMapAddress,
    this.placeId,
    this.paymentMethodWallet,
    this.discountPointsValue,
  });

  // Optional: Factory constructor to create from JSON or map
  factory OrderModel.fromJson(Map<String, dynamic> json, ) {
    List<dynamic> rawOrderList = json['OrderItems'] ?? [];
    List<Map<String, dynamic>> orderList = rawOrderList.map((item) => item as Map<String, dynamic>).toList();

    return OrderModel(
      images: [],
      orderDate: json['OrderDate'] ?? '',
      customerPhone: json['CustomerPhone'] ?? '',
      customerName: json['CustomerName'] ?? '',
      districtName: json['DistrictName'],
      regionName: json['RegionName'],
      block: json['Block'],
      street: json['Street'],
      house: json['House'],
      gada: json['Gada'],
      floor: json['Floor'],
      apartment: json['Apartment'],
      discountCode: json['DiscountCode'],
      email: json['Email'] ?? '',
      deliveryDate: json['DeliveryDate'] ?? '',
      deliveryDay: json['DeliveryDay'] ?? '',
      orderTime: json['OrderTime'] ?? '',
      additions: json['Additions'] ?? 0,
      totalValue: json['TotalValue'] ?? 0,
      discount: json['Discount'] ?? 0,
      finalValue: json['FinalValue'] ?? 0,
      payID: json['PayID'] ?? 0,
      onlineStoreId: json['OnlineStoreId'] ?? 0,
      deliveryID: json['DeliveryID'] ?? 0,
      details: json['Details'] ?? '',
      discountCardValue: json['DiscountCardValue'],
      orderList: orderList,
      customerAddress: json['CustomerAddress'],
      customerMapAddress: json['MapCustomerAddress'],
      placeId: json['MapPlaceID'],
      paymentMethodWallet: json['PaymentMethodeWalet'],
      discountPointsValue: json['DiscountPointsValue'],
    );
  }

  // Optional: Convert to Map
  Map<String, dynamic> toJson() {
    return {
      'orderDate': orderDate,
      'customerPhone': customerPhone,
      'customerName': customerName,
      'districtName': districtName,
      'regionName': regionName,
      'block': block,
      'street': street,
      'house': house,
      'gada': gada,
      'floor': floor,
      'apartment': apartment,
      'discountCode': discountCode,
      'email': email,
      'deliveryDate': deliveryDate,
      'deliveryDay': deliveryDay,
      'orderTime': orderTime,
      'additions': additions,
      'totalValue': totalValue,
      'discount': discount,
      'finalValue': finalValue,
      'payID': payID,
      'onlineStoreId': onlineStoreId,
      'deliveryID': deliveryID,
      'details': details,
      'discountCardValue': discountCardValue,
      'orderList': orderList,
      'customerAddress': customerAddress,
      'customerMapAddress': customerMapAddress,
      'placeId': placeId,
      'paymentMethodWallet': paymentMethodWallet,
      'discountPointsValue': discountPointsValue,
    };
  }
}
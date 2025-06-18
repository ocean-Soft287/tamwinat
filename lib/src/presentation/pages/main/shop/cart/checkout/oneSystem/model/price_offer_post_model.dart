import 'dart:developer';

import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/model/sales_invoice_item.dart';

class PriceOfferPostModel {
  final String invoiceDate;
  final int payingType;
  final int currencyID;
  final double rate;
  final double totalValue;
  final double totalAddition;
  final double totalDiscount;
  final double finalValue;
  final String customerPhone;
  final String regionName;
  final String customerName;
  final String districtName;
  final String block;
  final String street;
  final String house;
  final String gada;
  final String floor;
  final String apartment;
  final String address;
  final List<SalesInvoiceItem> salesInvoiceItems;

  PriceOfferPostModel({
    required this.invoiceDate,
    required this.payingType,
    required this.currencyID,
    required this.rate,
    required this.totalValue,
    required this.totalAddition,
    required this.totalDiscount,
    required this.finalValue,
    required this.customerPhone,
    required this.regionName,
    required this.customerName,
    required this.districtName,
    required this.block,
    required this.street,
    required this.house,
    required this.gada,
    required this.floor,
    required this.apartment,
    required this.address,
    required this.salesInvoiceItems,
  });

  factory PriceOfferPostModel.fromJson(Map<String, dynamic> json) {
    return PriceOfferPostModel(
      invoiceDate: json['InvoiceDate'],
      payingType: json['PayingType'],
      currencyID: json['CurrencyID'],
      rate: json['Rate'].toDouble(),
      totalValue: json['TotalValue'].toDouble(),
      totalAddition: json['TotalAddition'].toDouble(),
      totalDiscount: json['TotalDiscount'].toDouble(),
      finalValue: json['FinalValue'].toDouble(),
      customerPhone: json['CustomerPhone'],
      regionName: json['RegionName'],
      customerName: json['CustomerName'],
      districtName: json['DistrictName'],
      block: json['Block'],
      street: json['Street'],
      house: json['House'],
      gada: json['Gada'],
      floor: json['Floor'],
      apartment: json['Apartment'],
      address: json['Address'],
      salesInvoiceItems: (json['SalesInvoiceItems'] as List)
          .map((e) => SalesInvoiceItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    log(customerPhone);

    return {

//"InvoiceDate":"2024-06-15",
//"PayingType":0,"CurrencyID":1,"Rate":1,
//"TotalValue":30,"TotalAddition":0,"TotalDiscount":0,
// "SalesInvoiceItems":
// [{"ProductID":2105,"RowNumber":1,"Quantity":3,"Price":10,
// "BarCode":"6281065015602"}]
//"FinalValue":30,
//"CustomerPhone":"9012365906",
//"RegionName":"العاصمة",
//"CustomerName":"Mahmoud2 Ali2235",
//"DistrictName":"الشرق",
//"Block":"12",
//"Street":"7",
//"House":"20"
//,"Gada":"22"
//,"Floor":"23",
//"Apartment":"10",
//"Address":"25st",


        "InvoiceDate": invoiceDate,
        "PayingType": payingType,
        "CurrencyID": currencyID,
        "Rate": rate,
         "TotalValue": totalValue,
         "TotalAddition": totalAddition,
        "TotalDiscount": totalDiscount,
        "FinalValue": finalValue,
      "CustomerPhone": customerPhone, //"9444059611",
        "RegionName": regionName,
       "CustomerName": customerName,
        "DistrictName": districtName,
        "Block": block,
        "Street": street,
        "House": house,
        "Gada": gada,
        "Floor": floor,
        "Apartment": apartment,
        "Address": address,
         "SalesInvoiceItems": salesInvoiceItems.map((e) => e.toJson()).toList(),
     
      };}
}

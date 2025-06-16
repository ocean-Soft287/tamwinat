class SalesInvoiceItem {
  final String productID;
  final String rowNumber;
  final String quantity;
  final String price;
  final String barCode;

  SalesInvoiceItem({
    required this.productID,
    required this.rowNumber,
    required this.quantity,
    required this.price,
    required this.barCode,
  });

  factory SalesInvoiceItem.fromJson(Map<String, dynamic> json) {
    return SalesInvoiceItem(
      productID: json['ProductID'].toString(),
      rowNumber: json['RowNumber'].toString(),
      quantity: json['Quantity'].toString(),
      price: json['Price'].toString(),
      barCode: json['BarCode'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductID': int.parse(productID),
      'RowNumber': int.parse(rowNumber),
      'Quantity': double.parse(quantity),
      'Price': double.parse(price),
      'BarCode': barCode,
    };
  }
}

class AddressModel {
  final int? customerID;
  final String? arabicName;
  final String? englishName;
  final String? customerPhone;
  final String? lastName;
  final String? passWord;
  final String? email;
  final int? regionId;
  final String? regionName;
  final String? placeId;
  final String? districtName;
  final String? streetName;
  final String? gada;
  final String? houseNo;
  final String? block;
  final String? floor;
  final String? apartment;
  final String? addressNotes;
  final String? customerAddress;
  final double? billValue;
  final String? paymentMethod;
  final double? deliveryValue;
  final String? districtName2;
  final String? districtEName2;
  final String? token;
  final String? mapCustomerAddress;
  final String? mapPlaceID;
  final int? addressID;
  final String? customerLastName;
  final int? regionID3;
  final String? regionname3;
  final String? regionEname3;
  final String? addressNotes3;
  final String? address;
  final int? mainAddress;
  final String? customerWork;

  AddressModel({
    this.customerID,
    this.arabicName,
    this.englishName,
    this.customerPhone,
    this.lastName,
    this.passWord,
    this.email,
    this.regionId,
    this.regionName,
    this.placeId,
    this.districtName,
    this.streetName,
    this.gada,
    this.houseNo,
    this.block,
    this.floor,
    this.apartment,
    this.addressNotes,
    this.customerAddress,
    this.billValue,
    this.paymentMethod,
    this.deliveryValue,
    this.districtName2,
    this.districtEName2,
    this.token,
    this.mapCustomerAddress,
    this.mapPlaceID,
    this.addressID,
    this.customerLastName,
    this.regionID3,
    this.regionname3,
    this.regionEname3,
    this.addressNotes3,
    this.address,
    this.mainAddress,
    this.customerWork,
  });

  // Factory method to create a model from a Map (JSON)
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      customerID: map['CustomerID'] is int ? map['CustomerID'] : int.tryParse(map['CustomerID'].toString()) ?? null,
      arabicName: map['ArabicName']?.toString(),
      englishName: map['EnglishName']?.toString(),
      customerPhone: map['CustomerPhone']?.toString(),
      lastName: map['LastName']?.toString(),
      passWord: map['PassWord']?.toString(),
      email: map['Email']?.toString(),
      regionId: map['region_id'] is int ? map['region_id'] : int.tryParse(map['region_id'].toString()) ?? null,
      regionName: map['RegionName']?.toString(),
      placeId: map['place_id']?.toString() ?? map['place_id']?.toString(),
      districtName: map['DistrictName']?.toString(),
      streetName: map['StreetName']?.toString(),
      gada: map['Gada']?.toString(),
      houseNo: map['HouseNo']?.toString(),
      block: map['Block']?.toString(),
      floor: map['Floor']?.toString(),
      apartment: map['Apartment']?.toString(),
      addressNotes: map['AddressNotes']?.toString(),
      customerAddress: map['CustomerAddress']?.toString(),
      billValue: map['BillValue'] is double ? map['BillValue'] : double.tryParse(map['BillValue'].toString()) ?? null,
      paymentMethod: map['PaymentMethod']?.toString(),
      deliveryValue: map['DeliveryValue'] is double ? map['DeliveryValue'] : double.tryParse(map['DeliveryValue'].toString()) ?? null,
      districtName2: map['DistrictName2']?.toString(),
      districtEName2: map['DistrictEName2']?.toString(),
      token: map['Token']?.toString(),
      mapCustomerAddress: map['MapCustomerAddress']?.toString(),
      mapPlaceID: map['MapPlaceID']?.toString(),
      addressID: map['AddressID'] is int ? map['AddressID'] : int.tryParse(map['AddressID'].toString()) ?? null,
      customerLastName: map['CustomerLastName']?.toString(),
      regionID3: map['RegionID3'] is int ? map['RegionID3'] : int.tryParse(map['RegionID3'].toString()) ?? null,
      regionname3: map['Regionname3']?.toString(),
      regionEname3: map['RegionEname3']?.toString(),
      addressNotes3: map['AddressNotes3']?.toString(),
      address: map['Address']?.toString(),
      mainAddress: map['MainAddress'] is int ? map['MainAddress'] : int.tryParse(map['MainAddress'].toString()) ?? null,
      customerWork: map['CustomerWork']?.toString(),
    );
  }

  // Convert the model back to a Map (for serialization if needed)
  Map<String, dynamic> toMap() {
    return {
      'CustomerID': customerID,
      'ArabicName': arabicName,
      'EnglishName': englishName,
      'CustomerPhone': customerPhone,
      'LastName': lastName,
      'PassWord': passWord,
      'Email': email,
      'region_id': regionId,
      'RegionName': regionName,
      'place_id': placeId,
      'DistrictName': districtName,
      'StreetName': streetName,
      'Gada': gada,
      'HouseNo': houseNo,
      'Block': block,
      'Floor': floor,
      'Apartment': apartment,
      'AddressNotes': addressNotes,
      'CustomerAddress': customerAddress,
      'BillValue': billValue,
      'PaymentMethod': paymentMethod,
      'DeliveryValue': deliveryValue,
      'DistrictName2': districtName2,
      'DistrictEName2': districtEName2,
      'Token': token,
      'MapCustomerAddress': mapCustomerAddress,
      'MapPlaceID': mapPlaceID,
      'AddressID': addressID,
      'CustomerLastName': customerLastName,
      'RegionID3': regionID3,
      'Regionname3': regionname3,
      'RegionEname3': regionEname3,
      'AddressNotes3': addressNotes3,
      'Address': address,
      'MainAddress': mainAddress,
      'CustomerWork': customerWork,
    };
  }
}
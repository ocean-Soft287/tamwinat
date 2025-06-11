

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';

import '../../../../../../../../core/constants/app_assets.dart';
import '../../../../../../../../riverpod/gh.dart';

import '../../../../../../../theme/app_colors.dart';
import '../../../../../../pages.dart';
import '../../../../../drawer/MyPreviousRequests/view/my_previous_requets_screen.dart';
import '../../../../../pickup/One System/DioOneSystem.dart';

final orderItemProvider = ChangeNotifierProvider<OrderItemFun>((ref) {
  return OrderItemFun();
});

class OrderItemFun extends ChangeNotifier {
  void showSnackBar(
      {required BuildContext context,
      required String message,
      required Color backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  String encryptData(
      Map<String, dynamic> data, String privateKey, String publicKey) {
    final key = encrypt.Key.fromUtf8(privateKey); // 32 chars
    final iv = encrypt.IV.fromUtf8(publicKey); // 16 chars
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    try {
      String jsonString = json.encode(data);
      final encrypted = encrypter.encrypt(jsonString, iv: iv);
      final encryptedText = encrypted.base64;
      return encryptedText;
    } catch (e) {
      print("Error encryptData : $e");
      return 'Error....................';
    }
  }

  String? Succes = '';

  void orderItemFu(
      {required BuildContext context,
      required List<Map<String, dynamic>> Image,
      required String OrderDate,
      required String CustomerPhone,
      required String CustomerName,
      String? DistriictName,
      String? regionName,
      String? Block,
      String? Street,
      String? House,
      String? Gada,
      String? Floor,
      String? Apartment,
      String? DiscountCode,
      required String Email,
      required String DeliveryDate,
      required String DeliveryDay,
      required String OrderTime,
      required num Additions,
      required num TotalValue,
      required num Discount,
      required num FinalValue,
      required num PayID,
      required num OnlineStoreId,
      required int DeliveryID,
      required String Details,
      required dynamic DiscountCardValue,
      required List<Map<String, dynamic>> orderList,
      String? CustomerAddress,
      String? customerMapAdress,
      String? placeId,
      dynamic paymentMethodeWalet,
      dynamic discountPointsValue}) {
    const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
    const publicKey = 'e0c9de1b2de26fe2';
    String encryptedData = encryptData(
      {
      "OrderDate": OrderDate,
      "CustomerPhone": CustomerPhone,
      "CustomerName": CustomerName,
      "DistrictName": DistriictName,
      if (UserPhone == null) "RegionName": regionName,
      "Block": Block,
      "Street": Street,
      "House": House,
      "Gada": Gada,
      "Floor": Floor,
      "Apartment": Apartment,
      "Email": Email,
      "TotalValue": TotalValue,
      "Discount": Discount,
      "FinalValue": FinalValue,
      "PayID": PayID,
      "OnlineStoreId": OnlineStoreId,
      "DeliveryDate": DeliveryDate,
      "DeliveryDay": DeliveryDay,
      "OrderTime": OrderTime,
      "Additions": Additions,
      "DeliveryID": DeliveryID,
      "Details": Details,
      "CustomerAddress": CustomerAddress,
      "DiscountCode": DiscountCode,
      "DiscountCardValue": DiscountCardValue,
      "MapCustomerAddress": customerMapAdress, // UPDATEADRESS HERE
      "MapPlaceID": placeId,
      "DiscountPointsValue": discountPointsValue ?? 0,
      "OrderItems": orderList,
    }, privateKey, publicKey);
  //  debugPrint("Encrypted Data: $encryptedData");
  //  final decryptedText1 = decrypt(encryptedData, privateKey, publicKey);
   log( encryptedData); //g8Etyx8TU579vDxJzaN1lo3r46+WJLvqb/IMYdIURHM=

    String jsonData = jsonEncode(encryptedData);
    debugPrint('5555555555');
    final decryptedText = decrypt(encryptedData, privateKey, publicKey);
    debugPrint('222222');

    log('------------------------------------------');
   // log(jsonData);
    log('********************************************');
    log(decryptedText);
    log('********************************************');
    // updated Here
    DioHelperOneSystem.postData(url: 'api/Order', data: jsonData).then((value) {
      final decryptedText2 = decrypt(value.data, privateKey, publicKey);
      debugPrint(decryptedText2);
    //  debugPrint(value.data);
      debugPrint('Success post Order');
      // Succes=value.data;
      final decryptedText = decrypt(value.data, privateKey, publicKey);
      Succes = decryptedText;
      showSnackBar(
          backgroundColor: Colors.black,
          context: context,
          message: 'تم تسجيل الطلبيه بنجاح');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Fatora(
                discountPointsValue: discountPointsValue ?? 0,
                addressCustoomer: CustomerAddress,
                address: 'sssssss',
                gada: Gada ?? '',
                delivery: Additions,
                payId: PayID,
                listIteamFatora: orderList,
                data: OrderDate,
                time: OrderDate,
                regionName: regionName ?? '',
                totalValue: TotalValue,
                discount: Discount,
                finalValue: FinalValue,
                listImageFatora: Image,
                DeliveryDay: DeliveryDay,
                DeliveryData: DeliveryDate,
                ordeTime: OrderTime,
                numberFaota: Succes!,
                phone: CustomerPhone,
                block: Block ?? '',
                distrubit: DistriictName ?? '',
                name: CustomerName,
                Strate: Street ?? '',
                House: House ?? '',
                Details: Details ?? '',
                ValueFi: FinalValue,
                Floor: Floor ?? '',
                Apartment: Apartment ?? '',
                paymentMethodeWalet: paymentMethodeWalet)),
      );

      notifyListeners();
    }).catchError((error) {
      debugPrint("Generated Error ${error.toString()}");
      showSnackBar(
          backgroundColor: Colors.red,
          context: context,
          message: 'خطاء فى تسجيل الطلبيه حاول مره اخرى');
      print('Error post Order');
      print(error.toString());
    });
  }
}

//-----------------------------------------------------------------------------------

class NewListItem extends ChangeNotifier {
  List<Map<String, dynamic>> _newList = [];

  List<Map<String, dynamic>> get newList => List.unmodifiable(_newList);

  void addItem(Map<String, dynamic> newItem) {
    _newList.add(newItem);
    notifyListeners();
  }
}

final newOrderProviderList = ChangeNotifierProvider<NewListItem>((ref) {
  return NewListItem();
});

dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
  final keyObj = encrypt.Key.fromUtf8(privateKey); // 32 chars
  final ivObj = encrypt.IV.fromUtf8(publicKey); // 16 chars
  final encrypter =
      encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

  try {
    final decrypted = encrypter
        .decrypt(encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
    return decrypted;
  } catch (e) {
    print("Error decrypting data: $e");
    return 'Error....................';
  }
}

//---------------------------------------------------Screen Fatora------------------

class Fatora extends ConsumerStatefulWidget {
  List<Map<String, dynamic>> listIteamFatora;
  List<Map<String, dynamic>> listImageFatora;
  dynamic totalValue;
  String data;
  String time;
  dynamic discount;
  dynamic finalValue;
  dynamic payId;
  String ordeTime;
  String DeliveryDay;
  String DeliveryData;
  String numberFaota;
  String address;
  String block;
  String distrubit;
  String name;
  String phone;
  String Strate;
  String House;
  num ValueFi;
  num delivery;
  String gada;
  String? addressCustoomer;
  String? Details;
  String? Floor;
  String? Apartment;
  String? regionName;
  dynamic paymentMethodeWalet;
  dynamic discountPointsValue;

  Map<String, String> Day = {
    "Saturday": "السبت",
    "Sunday": "الأحد",
    "Friday": "الجمعة",
    "Monday": "الإثنين",
    "Tuesday": "الثلاثاء",
    "Wednesday": "الأربعاء",
    "Thursday": "الخميس",
  };

  Fatora(
      {super.key,
      required this.numberFaota,
      required this.DeliveryData,
      required this.address,
      required this.ordeTime,
      required this.DeliveryDay,
      required this.listIteamFatora,
      required this.data,
      required this.time,
      required this.totalValue,
      required this.discount,
      required this.finalValue,
      required this.payId,
      required this.listImageFatora,
      required this.phone,
      required this.name,
      required this.gada,
      required this.block,
      required this.distrubit,
      required this.Strate,
      required this.House,
      required this.ValueFi,
      required this.delivery,
      this.addressCustoomer,
      this.Details,
      this.Floor,
      this.regionName,
      this.Apartment,
      this.discountPointsValue,
      this.paymentMethodeWalet});

  @override
  _FatoraState createState() => _FatoraState();
}

class _FatoraState extends ConsumerState<Fatora> {
  int totalQuantity = 0;

  void initState() {
    super.initState();
    totalQuantity = calculateTotalQuantity(widget.listIteamFatora);
  }

  int calculateTotalQuantity(List<Map<String, dynamic>> items) {
    return items.fold(
        0,
        (total, item) =>
            total + (int.tryParse(item['Quantity'].toString()) ?? 10));
  }

  @override
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: Text(''),
          elevation: 0.0,
          title: Text(
            (appModel.activeLanguage.languageCode == 'ar')
                ? 'تم  الطلب بنجاح'
                : 'The order has been registered successfully',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontFamily: 'Monadi',
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    AppAssets.pngOneSystemTomnaLogo,
                    height: 100,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'تفاصيل الفاتورة'
                        : 'INVOCE DETAILS',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                    ),
                  ),
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'رقم الفاتوره:'
                              : 'Invoice Number:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'وقت التوصيل:'
                              : 'Delivery Time:',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.numberFaota,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          '${widget.ordeTime}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      (appModel.activeLanguage.languageCode == 'ar')
                          ? 'تاريخ التوصيل:'
                          : 'Delivery Date:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.indigo,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Monadi',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.DeliveryData}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Monadi',
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (appModel.activeLanguage.languageCode == 'ar')
                          ? 'يوم التوصيل:'
                          : 'Delivery Day:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.indigo,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Monadi',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      (appModel.activeLanguage.languageCode == 'ar')
                          ? ' ${widget.Day[widget.DeliveryDay]}'
                          : '  ${widget.DeliveryDay}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Monadi',
                      ),
                    ),
                  ],
                ),

                Center(
                  child: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'تفاصيل العميل'
                        : 'CUSTOMER DETAILS',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'الاسم '
                              : 'Name',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'الموبيل'
                              : 'Phone',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          '${widget.phone}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'تفاصيل العنوان'
                        : 'ِADDRESS DETAILS',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                if (UserPhone == null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? 'المحافظه '
                                      : 'Governorate',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? 'المنطقه  '
                                      : 'Address',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? 'الجاده  '
                                      : 'Gada',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "المنزل  "
                                      : 'House',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.regionName ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  widget.distrubit ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  widget.gada ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  widget.House ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "الدور"
                                      : 'Floor',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? 'البلوك  '
                                      : 'Block',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "الشارع"
                                      : 'Street',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "الشقه"
                                      : 'Apartment',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.Floor ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  widget.block ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  widget.Strate ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  widget.Apartment ?? '',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (UserPhone != null)
                  Text(
                    '${widget.addressCustoomer}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.indigo,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Monadi',
                    ),
                  ),
                Center(
                  child: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'تفاصيل الطلب'
                        : 'ِORDER DETAILS',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'اسم الصنف'
                              : 'Product Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            (appModel.activeLanguage.languageCode == 'ar')
                                ? 'الكميه'
                                : 'Quantity',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Monadi',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            (appModel.activeLanguage.languageCode == 'ar')
                                ? 'السعر'
                                : 'price',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Monadi',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            (appModel.activeLanguage.languageCode == 'ar')
                                ? 'الاجمالى '
                                : 'Total',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Monadi',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.listIteamFatora.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                (appModel.activeLanguage.languageCode == 'ar')
                                    ? '${widget.listImageFatora[index]["ProductArName"]}'
                                    : '${widget.listImageFatora[index]["ProductEnName"]}',
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  '${widget.listIteamFatora[index]['Quantity']}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Monadi',
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  '${widget.listIteamFatora[index]['Price'].toStringAsFixed(3)}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  '${(widget.listIteamFatora[index]['Price'] * widget.listIteamFatora[index]['Quantity']).toStringAsFixed(3)} ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Center(
                  child: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? "تفاصيل الدفع"
                        : 'ِPAYMENT DETAILS',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                    ),
                  ),
                ),

                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? "المجموع الفرعي"
                              : 'SUB TOTAL',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? ' الخصم : '
                              : ' Discount : ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? ' رسوم التوصيل : '
                              : ' Delivery : ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        // Text((appModel.activeLanguage.languageCode == 'ar')
                        //                         ? ' الخصم من النقاط : '
                        //                         : ' Discount : ',
                        //                       style: TextStyle(
                        //                         fontSize: 16.sp,
                        //                         color: Colors.indigo,
                        //                         fontWeight: FontWeight.normal,
                        //                         fontFamily: 'Monadi',
                        //                       ),),
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'طريقه الدفع '
                              : 'Payment Method',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),

                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? ' السعر النهائى : '
                              : ' final price : ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.totalValue.toStringAsFixed(3)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          '${widget.discount ?? ''}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          '${widget.delivery ?? ''}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),

                        // Text('${widget.discountPointsValue??''}',
                        //                       style: TextStyle(
                        //                         fontSize: 16.sp,
                        //                         color: Colors.black,
                        //                         fontWeight: FontWeight.w300,
                        //                         fontFamily: 'Monadi',
                        //                       ),),
                        Text.rich(
                          (widget.paymentMethodeWalet != null)
                              ? TextSpan(
                                  text: 'الدفع عن طريق المحفظه',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                )
                              : TextSpan(
                                  text: (widget.payId == 0)
                                      ? 'الدفع عند الاستلام'
                                      : 'الدفع كى نت',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                        ),

                        Text(
                          '${widget.ValueFi.toStringAsFixed(3)}' ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                10.verticalSpace,

                // Text('${widget.totalValue.toStringAsFixed(3)}',
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 16.sp,
                //     fontWeight: FontWeight.w300,
                //     fontFamily: 'Monadi',
                //     letterSpacing: 1.1,
                //   ),),

                10.verticalSpace,

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     RichText(
                //       text: TextSpan(
                //         children: [
                //           TextSpan(
                //             text: (appModel.activeLanguage.languageCode == 'ar')
                //                 ? ' اجمالى الكميه : '
                //                 : 'Total quantity:',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.black,
                //               fontWeight: FontWeight.normal,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //           TextSpan(
                //             text: '${totalQuantity}',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.indigo,
                //               fontWeight: FontWeight.w300,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     RichText(
                //       text: TextSpan(
                //         children: [
                //           TextSpan(
                //             text: (appModel.activeLanguage.languageCode == 'ar')
                //                 ? ' الاجمالى  : '
                //                 : 'Total',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.black,
                //               fontWeight: FontWeight.normal,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //           TextSpan(
                //             text: '${widget.totalValue.toStringAsFixed(3)}',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.indigo,
                //               fontWeight: FontWeight.w300,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),

                // 10.verticalSpace,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     RichText(
                //       text: TextSpan(
                //         children: [
                //           TextSpan(
                //             text: (appModel.activeLanguage.languageCode == 'ar')
                //                 ? ' رسوم التوصيل : '
                //                 : ' Delivery : ',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.black,
                //               fontWeight: FontWeight.normal,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //           TextSpan(
                //             text: '${widget.delivery}',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.indigo,
                //               fontWeight: FontWeight.w300,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     RichText(
                //       text: TextSpan(
                //         children: [
                //           TextSpan(
                //             text: (appModel.activeLanguage.languageCode == 'ar')
                //                 ? ' السعر النهائى : '
                //                 : ' final price : ',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.black,
                //               fontWeight: FontWeight.normal,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //           TextSpan(
                //             text: '${widget.ValueFi.toStringAsFixed(3)}',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.indigo,
                //               fontWeight: FontWeight.w300,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                //
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: (appModel.activeLanguage.languageCode == 'ar')
                //             ? ' الخصم : '
                //             : ' Discount : ',
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           color: Colors.black,
                //           fontWeight: FontWeight.normal,
                //           fontFamily: 'Monadi',
                //         ),
                //       ),
                //       TextSpan(
                //         text: '${widget.discount}',
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           color: Colors.indigo,
                //           fontWeight: FontWeight.w300,
                //           fontFamily: 'Monadi',
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: (appModel.activeLanguage.languageCode == 'ar')
                //             ? ' الخصم من النقاط : '
                //             : ' Discount : ',
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           color: Colors.black,
                //           fontWeight: FontWeight.normal,
                //           fontFamily: 'Monadi',
                //         ),
                //       ),
                //       TextSpan(
                //         text: '${widget.discountPointsValue}',
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           color: Colors.indigo,
                //           fontWeight: FontWeight.w300,
                //           fontFamily: 'Monadi',
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Center(
                //   child: Container(
                //     width: 120.w,
                //     height: 30.h,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: Colors.green),
                //     child: Center(
                //       child: Text(
                //         (appModel.activeLanguage.languageCode == 'ar')
                //             ? 'بيانات العميل'
                //             : 'Customer data',
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           color: Colors.white,
                //           fontWeight: FontWeight.normal,
                //           fontFamily: 'Monadi',
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // 10.verticalSpace,

                5.verticalSpace,

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //
                //
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                       'ar')
                //                       ? 'المحافظه '
                //                       : 'Governorate',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.regionName}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? 'المنطقه  '
                //                       : 'Address',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.distrubit}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? 'الجاده  '
                //                       : 'Gada',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.gada}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? "المنزل  "
                //                       : 'House',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.House}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? "الدور"
                //                       : 'Floor',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.Floor}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //       ],
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? 'البلوك  '
                //                       : 'Block',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.block}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? "الشارع"
                //                       : 'Street',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.Strate}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? "الشقه"
                //                       : 'Apartment',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.Apartment}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //       ],
                //     ),
                //   ],
                // ),

                20.verticalSpace,
                Consumer(builder: (context, ref, child) {
                  final listItemOrderImage = ref.watch(orderProviderListImage);
                  final listItemOrder = ref.watch(orderProviderList);
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );

                      print(listItemOrder.orderList.length);
                      print(listItemOrderImage.orderListImage.length);
                      listItemOrder.clearItems();
                      listItemOrderImage.clearItems();
                      listItemOrder.clearItems();
                      print(listItemOrder.orderList.length);
                      print(listItemOrderImage.orderListImage.length);
                      listItemOrder.clearItems();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              (appModel.activeLanguage.languageCode == 'ar')
                                  ? 'الرجوع الى الصفحه الرئيسية'
                                  : 'Home page',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Monadi',
                              ),
                            ),
                          )),
                    ),
                  );
                }),
                20.verticalSpace,
                Consumer(
                  builder: (context, ref, child) {
                    final listItemOrderImage =
                        ref.watch(orderProviderListImage);
                    final listItemOrder = ref.watch(orderProviderList);
                    return InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyPreviousRequetsScreen()),
                        );
                        print(listItemOrder.orderList.length);
                        print(listItemOrderImage.orderListImage.length);
                        listItemOrder.clearItems();
                        listItemOrderImage.clearItems();
                        listItemOrder.clearItems();
                        print(listItemOrder.orderList.length);
                        print(listItemOrderImage.orderListImage.length);
                        listItemOrder.clearItems();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                (appModel.activeLanguage.languageCode == 'ar')
                                    ? 'متابعة الطلب'
                                    : 'Order Tracking',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                            )),
                      ),
                    );
                  },
                ),
                20.verticalSpace,
                Center(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // محاذاة النصوص في المنتصف
                    children: [
                      Text(
                        (appModel.activeLanguage.languageCode == 'ar')
                            ? 'شكرًا لتسوقكم'
                            : 'Thank you for shopping',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.indigo,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Monadi',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2), // مسافة بين النصوص
                      Text(
                        'WhatsApp: 22285055',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.indigo,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Monadi',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2), // مسافة بين النصوص
                      Text(
                        '@tmwenatapp',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.indigo,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Monadi',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                100.verticalSpace,
              ],
            ),
          ),
        ));
  }
}

//---------------------------------------------------------List Address---------
final getDataFromApiProviderr =
    ChangeNotifierProvider((ref) => GetDataListAddress());

class GetDataListAddress extends ChangeNotifier {
  GetDataListAddress() {
    getDataListAddress(governorateId: 4);
    getGovernoratesList();
  }

  dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey); // 32 chars
    final ivObj = encrypt.IV.fromUtf8(publicKey); // 16 chars
    final encrypter =
        encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

    try {
      final decrypted = encrypter
          .decrypt(encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
      return decrypted;
    } catch (e) {
      print("Error decrypting data: $e");
      return 'Error....................';
    }
  }

  List dataAddressList = [];

  void getDataListAddress({required var governorateId}) {
    dataAddressList = [];
    DioHelperOneSystem.getData(
            url:
                'api/Areas/GetAreaByGovernorateId?GovernorateId=$governorateId')
        .then((value) {
      print('11111111111111111111111111111111111111111111111111111');
      print('Success List Address');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      dataAddressList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(dataAddressList);
      print(dataAddressList[0]);

      print(dataAddressList.length);
      notifyListeners();
    }).catchError((error) {
      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');
    });
  }

  List governoratesList = [];
  void getGovernoratesList() {
    DioHelperOneSystem.getData(url: 'api/Governorates').then((value) {
      print('========================= Start =========================');
      print('Success Governorates List');
      print(value.data);
      print('========================== End ==========================');

      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      // فك تشفير النص
      final decryptedText = decrypt(encryptedText, privateKey, publicKey);

      // تحويل البيانات إلى قائمة
      governoratesList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList();

      // طباعة البيانات للتأكد
      print(governoratesList);
      if (governoratesList.isNotEmpty) {
        print(governoratesList[0]);
      }
      print('Governorates count: ${governoratesList.length}');

      // إخطار المستمعين
      notifyListeners();
    }).catchError((error) {
      print('Error occurred: $error');
      print('=================== Error End ====================');
    });
  }
}

//--------------------------------------------discount code------------------
final discountCodeFromApiProvider =
    ChangeNotifierProvider((ref) => GetDiscountCodeFromApi());
class GetDiscountCodeFromApi extends ChangeNotifier {
  dynamic decrypt(dynamic encryptedText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey);
    final ivObj = encrypt.IV.fromUtf8(publicKey);
    final encrypter =
    encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

    try {
      final decrypted = encrypter
          .decrypt(encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
      return decrypted;
    } catch (e) {
      print("Error decrypting data: $e");
      return null;
    }
  }

  String encryptData(dynamic plainText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey);
    final ivObj = encrypt.IV.fromUtf8(publicKey);
    final encrypter =
    encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

    try {
      final encrypted = encrypter
          .encrypt(plainText, iv: ivObj)
          .base64;
      return encrypted;
    } catch (e) {
      print("Error encrypting data: $e");
      return '';
    }
  }

  List<Map<String, dynamic>> discountCodeList = [];
  bool isLoading = false;

//   Future<void> getDiscountCode({
//     required BuildContext context,
//     required String discountCode,
//     required String customerPhone,
//     required List<Map<String, dynamic>> orderList,
//   }) async {
//     isLoading = true;
//     notifyListeners();
//
//     discountCodeList.clear();
//
//     // إعداد البيانات
//     final filteredOrderList = orderList.map((item) {
//       return {
//         "ItemID": item["ItemID"],
//         "Quantity": item["Quantity"],
//         "Price": item["Price"],
//         "BarCode": item["BarCode"],
//       };
//     }).toList();
//
//     final requestData = {
//       "DiscountCode": discountCode,
//       "CustomerPhone": customerPhone,
//       "_OrderItems": filteredOrderList,
//     };
//
//     // مفاتيح التشفير (استبدلها بموقع آمن)
//     const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
//     const publicKey = 'e0c9de1b2de26fe2';
//
//     try {
//       // تشفير البيانات
//       final encryptedRequest = encryptData(jsonEncode(requestData), privateKey, publicKey);
//
//       // إرسال الطلب
//       final response = await DioHelperOneSystem.postData(
//         url: 'api/Coupons/GetCouponsDiscount',
//         data: {"encryptedRequest": encryptedRequest},
//         // إضافة validateStatus لتجاهل رمز الحالة 400
//         options: Options(
//           validateStatus: (status) {
//             return status != null && status < 500; // اعتبر كل الأكواد أقل من 500 صالحة
//           },
//         ),
//       );
//
//       // التحقق من رمز الحالة
//       if (response.statusCode == 200) {
//         print("✅ Response Encrypted Data: ${response.data}");
//
//         final decryptedText = decrypt(response.data, privateKey, publicKey);
//         if (decryptedText == null || decryptedText.isEmpty) {
//           print("❌ Failed to decrypt response.");
//           _showErrorDialog(context, "خطأ", "تعذر فك تشفير البيانات المستلمة.");
//           return;
//         }
//
//         print("🔓 Response Decrypted Data: $decryptedText");
//
//         if (decryptedText.trim() == 'This Coupon has been used before') {
//           _showErrorDialog(context, "كود الخصم", "كود الخصم مستخدم سابقًا");
//         } else {
//           try {
//             discountCodeList = List<Map<String, dynamic>>.from(json.decode(decryptedText));
//             print("📦 Processed Discounts: $discountCodeList");
//           } catch (e) {
//             print("❌ Error parsing JSON: $e");
//             discountCodeList.clear();
//             _showErrorDialog(context, "خطأ", "حدث خطأ أثناء معالجة البيانات.");
//           }
//         }
//       } else {
//         // طباعة التفاصيل في حالة 400
//         print("❌ Bad Request (400): ${response.data}");
//         _showErrorDialog(context, "خطأ", "فشل الطلب. تأكد من صحة البيانات المرسلة.");
//       }
//     } catch (e) {
//       print("❌ Exception during request execution: $e");
//       discountCodeList.clear();
//       _showErrorDialog(context, "خطأ", "حدث خطأ أثناء تنفيذ الطلب.");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
// // Helper function to show error dialog
//   void _showErrorDialog(BuildContext context, String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           title: Row(
//             children: [
//               const Icon(Icons.warning_amber_rounded, color: Colors.amber),
//               const SizedBox(width: 10),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'Monadi',
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           content: Text(
//             message,
//             style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Monadi',
//               color: Colors.black,
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.orange,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('حسناً'),
//             ),
//           ],
//         );
//       },
//     );
//   }
  Future<void> getDiscountCode({
    required BuildContext context,
    required String discountCode,
    required String customerPhone,
    required List<Map<String, dynamic>> orderList,
  }) async {
    isLoading = true;
    notifyListeners();

    // Filtered Order List
    final filteredOrderList = orderList.map((item) {
      return {
        "ItemID": item["ItemID"],
        "Quantity": item["Quantity"],
        "Price": item["Price"],
        "BarCode": item["BarCode"],
      };
    }).toList();

    const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
    const publicKey = 'e0c9de1b2de26fe2';

    // Request Data
    final requestData = {
      "DiscountCode": discountCode,
      "CustomerPhone": customerPhone,
      "OrderItems": filteredOrderList,
    };

    // Serialize the requestData to JSON String
    final requestDataString = jsonEncode(requestData);

    // Encrypt requestDataString
    final encryptedRequest;
    try {
      encryptedRequest = encryptData(requestDataString, privateKey, publicKey);
 print("encryptedRequest:${encryptedRequest}");
    } catch (e) {
      print('Error encrypting data: $e');
      return; // Exit early if encryption fails
    }

    print("encryptedRequest$encryptedRequest");
    final jsonData = jsonEncode(encryptedRequest);

    try {
      final response = await DioHelperOneSystem.postData(
        url: 'api/Coupons/GetCouponsDiscount',
        data: jsonData,
      );

      isLoading = false;

      // Decrypt the  response data
      final decryptedText = decrypt(response.data, privateKey, publicKey);
      print("decryptedText: $decryptedText");

      if (decryptedText == null) {
        return;
      }

      print(' البيانات بعد فك التشفير: $decryptedText');

      if (decryptedText.trim() == 'This Coupon has been used before') {
        print(' الكود مستخدم مسبقًا.');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 28),
                  const SizedBox(width: 10),
                  Text(
                    ' كود الخصم',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Monadi',
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              content: Text(
                'كود الخصم مستخدم سابقًا',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Monadi',
                  color: AppColors.black,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Text(
                      'حسناً',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Monadi',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        try {
          // Deserialize decryptedText to update discountCodeList
          discountCodeList = List<Map<String, dynamic>>.from(json.decode(decryptedText));
          print(' القائمة بعد التحديث: $discountCodeList');
        } catch (e) {
          print(' خطأ أثناء تحليل البيانات: $e');
          discountCodeList.clear();
        }
      }
    } catch (error) {
      isLoading = false;
      discountCodeList.clear();
      print(' خطأ أثناء جلب البيانات: $error');
    } finally {
      notifyListeners();
    }
  }
}
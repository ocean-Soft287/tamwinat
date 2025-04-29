import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';


import 'dart:convert';

import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/add_address.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../../core/constants/constants.dart';

import '../../../../../../../riverpod/gh.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/app_colors.dart';


import '../../../../drawer/wallet/manager/wallet_riverpod.dart';
import '../../../../drawer/tamwnate_pro/manager/get_subscribtions_riverpod.dart';
import '../../../../drawer/wallet_poinets/manager/wallet_poinets_reiverpod.dart';
import 'Controller/basct_shop_contrroller.dart';
import 'Controller/checkout_riverpod.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import 'Controller/time_delivery_riverpod.dart';

import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart' as tabby;
const String liveAPIKey =



    'EAYSAFUI70Q8R55n2w2VhWqqAdPKlzpq-KpwHtK9RUvgHbEDATH2t7O_07DlunZ3RplCsVUCjPDNSY20I3WLT-CdOoVsWYdDWHXPZ7MbbCZu33JDSUSGnc3k6qOCd5TZfqbFY7_eFRjAFE0svqn6_aepXu1vy9TUK1FggNQ9ZSR-x71N52KZqlp77hIGBkes-wKwHISvRdc1REWJTN69UK0Xh0gZGpj-H3fD2Th1I7X96XuLMGiGdRxI2Iw4XDJmYM2GV6yFxsUNRp5fPkqB-7xEdJ87yHGiNRn3I2QgoWFefp5i4UGhyAOcVOMvI8OqZBL1x8nyMPZOY_6a-yHQ8mlKTrTOiDNw745PlucFhNOZi5CjreIL1-ITYmdtI3SQwWqaC8IyU14nHMf_W_NTk2ze1GPnIGwpMa-5jjPvhq_5ienCOxI5r86MoRpCLLcyWLIBXxtZU1G3Tn-4YRP8rcowVgRyyA7bKfKWbRYMCfrE2Hc3zIPCBOZv5le0CfaPaeyWIzTUBz6_0eKSX5aa4srricjTJKOJ1ZeDIxWFXMKhMxYQIcHyT9F_gaRfFr0GMegk4lzXxUK0qQrsE11JqWy6qVdRfW09PuRkYOVnmJiUYIJsE78b7MOBYhdVaQmNYwZQiQGWM2TuQNbvq_vgjy0kNQ7Ai0iRWc_1Yxqmh1oqtrxI';
class CheckoutPageOne extends ConsumerStatefulWidget {
  List<Map<String, dynamic>> newmyList;
  var nameControllerCheckOutOnSystem;
  var mobileNumberControllerCheckOutOnSystem;

  var gada;
  var BlockNumberControllerCheckOutOnSystem;
  var StreetControllerCheckOutOnSystem;
  var HouseControllerCheckOutOnSystem;
  var emailControllerCheckOutOnSystem;
  var scondPhoneControllerCheckOutOnSystem;
  var apartmentControllerCheckOutOnSystem;
  var floorControllerCheckOutOnSystem;
  var titleNotes;
  var BilleValue;
  var PaymentMethod;
  dynamic ValueselectedDistrict;
  dynamic regionName;
  late num DeliveryValue;
  num discountValue = 0.0;
  dynamic DiscountPercent = 0;
  String? placeId;
  String? customerAdressMap;

  CheckoutPageOne({
    required this.newmyList,
    required this.apartmentControllerCheckOutOnSystem,
    required this.ValueselectedDistrict,
    required this.BlockNumberControllerCheckOutOnSystem,
    required this.gada,
    required this.emailControllerCheckOutOnSystem,
    required this.floorControllerCheckOutOnSystem,
    required this.mobileNumberControllerCheckOutOnSystem,
    required this.nameControllerCheckOutOnSystem,
    required this.HouseControllerCheckOutOnSystem,
    this.customerAdressMap,
    this.placeId,
    this.BilleValue,
    this.regionName,
    this.PaymentMethod,
    required this.StreetControllerCheckOutOnSystem,
    required this.DeliveryValue,
    required this.titleNotes,
  });

  @override
  _CheckoutPageOneState createState() => _CheckoutPageOneState();
}

class _CheckoutPageOneState extends ConsumerState<CheckoutPageOne> {
  late MFApplePayButton mfApplePayButton;

  int numberItem = 1;
  final DateTime _timeData = DateTime.now();
  String? dayName = DateFormat('EEEE').format(DateTime.now());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? dayNameAr = DateFormat('EEEE').format(DateTime.now());

  TabbySession? session;
  // late String _time=DateTime.now().toString();
  bool checktime = false;
  late String day;
  late String time;
  late String dataDay;
  int selectedOption = 5;
  int selectedOptionWallet = 1;
  int selectdeleveryoption=1;
  int selectedOptionPaymentId = 4;
  int selectAddress = 0;
  double totalPrice = 0.0;
  double FinalPrice = 0.0;
  double roundedFinalPrice = 0.0;

  List<int> itemQuantities = [];
  int isTodayActive = 1;
  int checkDiscount = 1;
  late int DeliveryId;
  dynamic deleveryValue;
  dynamic discountCardValue;
  dynamic BillValue;
  Map<String, String> Day = {
    "Saturday": "السبت",
    "Sunday": "الأحد",
    "Friday": "الجمعة",
    "Monday": "الإثنين",
    "Tuesday": "الثلاثاء",
    "Wednesday": "الأربعاء",
    "Thursday": "الخميس",
  };
  int? selectedCardIndex = -1;
  bool checkWalletPoint = true;

  //----------------Start Payment--------------
  String? _response = '';
  TabbySession? sessionTabby;

  late MFGooglePayButton mfGooglePayButton;
  List<MFPaymentMethod> paymentMethods = [];
  List<bool> isSelected = [];
  int selectedPaymentMethodIndex = -1;
  bool paymentSuccess = false;

  String amount = '5.00';

  late MFCardPaymentView mfCardView;
  bool checkTimeNotFound = true;

  //----------------- End Payment----------




  String todayName = DateFormat.EEEE().format(DateTime.now());
  String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime today = DateTime.now();
  DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
  dynamic selectedTime;

  var discountValueControllerCheckOutOnSystem = TextEditingController();
  List<String> deliveryTimes = [
    '9:00 ص - 11:00 ص',
    '11:00 ص - 1:00 م',
    '1:00 م - 3:00 م',
    '3:00 م - 5:00 م',
    '7:00 م - 9:00 م',
  ];
  Map<String, dynamic>? selectedTimee;
  Map<String, dynamic>? selectedTimeeTomorow;
  late String ItemData;
  String? sessionGoogle;
  void _incrementNumberItem(int index) {
    setState(() {
      itemQuantities[index]++;
      updateQuantityInList(index, itemQuantities[index]);
    });
  }

  void _decrementNumberItem(int index) {
    setState(() {
      if (itemQuantities[index] > 0) {
        itemQuantities[index]--;
        updateQuantityInList(index, itemQuantities[index]);
      }
    });
  }

  void updateQuantityInList(int index, int quantity) {
    setState(() {
      widget.newmyList[index]['Quantity'] = quantity;
      calculateTotal();
    });
  }

  //--------------------Start payment------------
  initiate() async {
    if (liveAPIKey.isEmpty) {
      setState(() {
        _response =
        "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token";
      });
      return;
    }
    await MFSDK.init(liveAPIKey, MFCountry.KUWAIT, MFEnvironment.LIVE);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initiatePayment();
      await initiateSessionForGooglePay();
      await initiateSessionForCardView();
      await initApple();

    });

    if (paymentSuccess) {
      displayPaymentSuccessPage();
    } else {
      displayPaymentFailurePage();
    }

    MFExecutePaymentRequest executePaymentRequest = MFExecutePaymentRequest(invoiceValue:  double.parse(amount));
    executePaymentRequest.displayCurrencyIso = MFCurrencyISO.KUWAIT_KWD;
  }


  log(Object object) {
    var json = const JsonEncoder.withIndent('  ').convert(object);
    setState(() {
      debugPrint(json);
      _response = json;
    });
  }

  initiatePayment() async {
    var request = MFInitiatePaymentRequest(
        invoiceAmount: double.parse(amount),
        currencyIso: MFCurrencyISO.KUWAIT_KWD);

    await MFSDK
        .initiatePayment(request, MFLanguage.ENGLISH)
        .then((value) =>
    {
      log(value),
      paymentMethods.addAll(value.paymentMethods!),
      for (int i = 0; i < paymentMethods.length; i++)
        isSelected.add(false)
    })
        .catchError((error) => {log(error.message)});
  }

  initApple() async{

    MFInitiateSessionRequest initiateSessionRequest =
    MFInitiateSessionRequest(customerIdentifier: "12332212");

    await MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
        .then((value) => applePayPayment(value))
        .catchError((error) => {log(error.message)});
  }


  void applePayPayment(MFInitiateSessionResponse session) async {
    MFExecutePaymentRequest executePaymentRequest =
    MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.displayCurrencyIso = MFCurrencyISO.KUWAIT_KWD;

    try {
      await mfApplePayButton.displayApplePayButton(
          session, executePaymentRequest, MFLanguage.ENGLISH);

      await mfApplePayButton.executeApplePayButton(
        executePaymentRequest,
            (invoiceId) {
          debugPrint("Invoice ID: $invoiceId");
        },
      );
      debugPrint("Apple Pay payment executed successfully");
    } catch (error) {
      debugPrint("Apple Pay error: ${error.toString()}");
      // Optionally log the error or show a user-friendly message
      log(error.toString());
      // You can also navigate to an error page if needed
      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentErrorPage()));
    }
  }

  displayPaymentSuccessPage() {}

  displayPaymentFailurePage() {}

  setPaymentMethodSelected(int index, bool value) {
    if (value) {
      selectedPaymentMethodIndex = index;
      isSelected =
      List<bool>.generate(paymentMethods.length, (i) => i == index);
    } else {
      isSelected[index] = value;
      if (selectedPaymentMethodIndex == index) {
        selectedPaymentMethodIndex = -1;
      }
    }
  }

  String?sesionGoogle;
  initiateSessionForGooglePay() async {
    MFInitiateSessionRequest initiateSessionRequest = MFInitiateSessionRequest(

        customerIdentifier: "12332212");

    await MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
        .then((value) => {
      sesionGoogle=value.sessionId
    })
        .catchError((error) => {log(error.message)});
  }
  initiateSessionForCardView() async {
    /*
      If you want to use saved card option with embedded payment, send the parameter
      "customerIdentifier" with a unique value for each customer. This value cannot be used
      for more than one Customer.
     */
    // var request = MFInitiateSessionRequest("12332212");
    /*
      If not, then send null like this.
     */
    MFInitiateSessionRequest initiateSessionRequest =
    MFInitiateSessionRequest();

    await MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
        .then((value) =>{ loadEmbeddedPayment(value),loadCardView(value)})
        .catchError((error) => {log(error.toString())});
  }

  loadCardView(MFInitiateSessionResponse session) {
    mfCardView.load(session, (bin) {
      log(bin);
    });
  }
  dynamic sessionApple;
  loadEmbeddedPayment(MFInitiateSessionResponse session) async {
    MFExecutePaymentRequest executePaymentRequest =
    MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.displayCurrencyIso = MFCurrencyISO.KUWAIT_KWD;
    await loadCardView(session);

    sessionApple=session;
    if (Platform.isIOS) {
       applePayPayment(session);
    }
  }

  //-------------------Payment Google --------------



  //-------------------End Payment---------------














  @override
  void initState() {
    super.initState();
    initiate();
    // يمكنك هنا تهيئة قائمة itemQuantities بطول myList
    // itemQuantities = List.generate(widget.myList.length, (index) => 1);
    calculateTotal();
    ref.read(getSubscriptionProvider);
    ref.read(getAddressFromApiProvider);
    ref.read(getAddressFromApiProvider).getAddresss();
    ref
        .read(getAddressFromApiProvider)
        .dataAddressList;
    ref.read(getAddressFromApiProvider);
    ref.read(getDataTimeDeliveryProvider);
    ref.read(getDataTimeDeliveryTomorowProvider);
    ref.read(getDataTimeDeliverynowProvider).getDataTimeDeliverynow();



    print('*----------------------------------------------------------------------*');
// deleveryValue=ref
//     .read(getAddressFromApiProvider)
//     .dataAddressList[0]['deleveryValue'];
// print(ref.read(getAddressFromApiProvider).dataAddressList[0]['deleveryValue']);
    print('*--------------------------------------------------------------------------------');

  }

  double calculateTotalPrice(List<Map<String, dynamic>> items) {
    double total = 0.0;

    for (var item in items) {
      if (item.containsKey('Quantity') && item.containsKey('Price')) {
        num quantity;
        if (item['RequiredQTY'] > 0.0 && item['GiftQTY'] > 0.0 &&
            item['Quantity'] >= item['RequiredQTY']) {
          quantity = item['Quantity'] - item['Y_Gift_Qty'];
        }
        else {
          quantity = item['Quantity'];
        }
        double price = item['Price'];

        total += quantity * price;
      }
    }

    return total;
  }

  void calculateTotal() {
    setState(() {
      totalPrice = calculateTotalPrice(widget.newmyList);
    });
  }

  // void dispose() {
  //   super.dispose();
  //   _pageController.dispose();
  // }
  String titleAddress = "";
String selcetoption="1";
// 2bool
  @override
  Widget build(BuildContext context) {
    mfGooglePayButton = const MFGooglePayButton();
    mfApplePayButton = MFApplePayButton(applePayStyle: MFApplePayStyle());

    final getSubscriptionDelivery = ref.watch(getSubscriptionProvider);
    final lang = ref.watch(appModelProvider);
    final listAddressUser = ref.watch(getAddressFromApiProvider);
    final listItemOrder = ref.watch(orderProviderList);
    final listItemOrderImage = ref.watch(orderProviderListImage);
    final walletPoints = ref.watch(walletPointsProvider);
    BillValue =
    (listAddressUser.dataAddressList.isEmpty) ? 8 : listAddressUser
        .dataAddressList[listAddressUser.SelectIndexAddress]["BillValue"] ?? 8;

    deleveryValue= (listAddressUser.dataAddressList.isEmpty) ? 1 : listAddressUser
        .dataAddressList[listAddressUser.SelectIndexAddress]["DeliveryValue"] ??1.toString();


    var uuid = const Uuid();
    String uniqueReferenceId = uuid.v4();
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: AppColors.mainBackground(),
        extendBody: true,
        appBar: AppBar(

          backgroundColor: AppColors.mainBackground(),
          centerTitle: true,
          title: (UserPhone != null)
              ? InkWell(
            onTap: () {
              ref.watch(getAddressFromApiProvider);
              ref
                  .watch(getAddressFromApiProvider)
                  .dataAddressList;
              ref.watch(getAddressFromApiProvider).getAddresss();
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder:
                        (BuildContext context, StateSetter setState) {

                      return SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {

                                  Navigator.of(context).pop();
                                },
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddNewAddress()));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        (lang.activeLanguage
                                            .languageCode ==
                                            'ar')
                                            ? 'اضافه عنوان جديد'
                                            : 'Enter Please Address',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                          fontFamily: 'Monadi',
                                          color: AppColors.black,
                                        )),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.orange,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: const Icon(Icons.add,
                                          color: Colors.orange),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                  (lang.activeLanguage.languageCode ==
                                      'ar')
                                      ? 'العناوين المحفوظه'
                                      : 'Save titles',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    fontFamily: 'Monadi',
                                    color: AppColors.black,
                                  )),
                              const SizedBox(height: 16),
                              Flexible(
                                child: Consumer(
                                    builder: (context, ref, child) {
                                      ref.watch(getAddressFromApiProvider);

                                      return ListView.builder(
                                          itemCount: listAddressUser
                                              .dataAddressList.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            final item = listAddressUser
                                                .dataAddressList[index];
                                            return Column(
                                              children: [
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .location_on,
                                                                color: Colors
                                                                    .orange,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  print(
                                                                      'Gamal');
                                                                  print(item);
                                                                },
                                                                child: Text(
                                                                    (lang
                                                                        .activeLanguage
                                                                        .languageCode ==
                                                                        'ar')
                                                                        ? '${item["DistrictName2"]}'
                                                                        : '${item["DistrictEName2"]}',
                                                                    style:
                                                                    TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                      16.sp,
                                                                      fontFamily:
                                                                      'Monadi',
                                                                      color: AppColors
                                                                          .black,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                          Radio(
                                                            value: index,
                                                            groupValue:
                                                            selectAddress,
                                                            onChanged:
                                                                (value) {
                                                              print(
                                                                  'index $index');
                                                              print(
                                                                  selectAddress);

                                                              setState(() {
                                                                selectAddress =
                                                                value!;
                                                              });
                                                              setState(() {
                                                                print(
                                                                    listAddressUser
                                                                        .dataAddressList[
                                                                    selectAddress]);
                                                                // print(
                                                                //     selectAddress);
                                                                print(
                                                                    listAddressUser
                                                                        .dataAddressList[
                                                                    selectAddress]
                                                                    [
                                                                    "DeliveryValue"]);
                                                                deleveryValue =
                                                                (UserPhone !=
                                                                    null)
                                                                    ? listAddressUser
                                                                    .dataAddressList[selectAddress]
                                                                [
                                                                "DeliveryValue"]
                                                                    : deleveryValue;
                                                                print(
                                                                    'deleveryValue   $deleveryValue');
                                                                print(
                                                                    '"deleveryValue"   $BillValue (${DeliveryValue
                                                                        .runtimeType})');

                                                                widget
                                                                    .PaymentMethod =
                                                                    int.parse(
                                                                        listAddressUser
                                                                            .dataAddressList[selectAddress]
                                                                        [
                                                                        "PaymentMethod"]) ??
                                                                        2;
                                                                // widget.BilleValue=int.parse(listAddressUser.dataAddressList[selectAddress]["BillValue"]);
                                                                BillValue =
                                                                listAddressUser
                                                                    .dataAddressList[
                                                                listAddressUser
                                                                    .SelectIndexAddress]
                                                                [
                                                                "BillValue"];
                                                                print(
                                                                    '"BillValue"   $BillValue');
                                                                print(
                                                                    '"BillValue"   $BillValue (${BillValue
                                                                        .runtimeType})');

                                                                //
                                                                //  print(widget.PaymentMethod);
                                                                //  print('Gammmmmmmmmmmmmmmmmmmal');
                                                                //
                                                                //
                                                                //  print(deleveryValue);
                                                                // print(item[
                                                                //     selectAddress]);
                                                                // setState(() {
                                                                //   widget.DeliveryValue = (UserPhone != null) ? listAddressUser.dataAddressList[selectAddress]["DeliveryValue"] : widget.DeliveryValue!;
                                                                // });

                                                                BillValue =
                                                                (UserPhone !=
                                                                    null)
                                                                    ? listAddressUser
                                                                    .dataAddressList[listAddressUser
                                                                    .SelectIndexAddress]
                                                                [
                                                                "BillValue"]
                                                                    : BillValue;
                                                                print(
                                                                    BillValue);
                                                              });

                                                              listAddressUser
                                                                  .changeSelectIndex(
                                                                  index);
                                                              Navigator.of(
                                                                  context)
                                                                  .pop();
                                                            },
                                                            visualDensity:
                                                            const VisualDensity(
                                                                horizontal:
                                                                -4,
                                                                vertical:
                                                                -4),
                                                          ),
                                                        ],
                                                      ),
                                                      item["MapCustomerAddress"] ==
                                                          null
                                                          ? const SizedBox.shrink()
                                                          : InkWell(
                                                        onTap: (){
                                                          print(item);
                                                        },
                                                        child: Text(
                                                          '${item["MapCustomerAddress"]}',
                                                          maxLines: 2,
                                                          style:
                                                          TextStyle(
                                                            fontSize:
                                                            11.sp,
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontFamily:
                                                            'Monadi',
                                                          ),
                                                          textAlign:
                                                          TextAlign
                                                              .center,
                                                        ),
                                                      ),
                                                      5.verticalSpace,
                                                      Text(
                                                        '${item["CustomerAddress"]}',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontFamily:
                                                          'Monadi',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                10.verticalSpace,
                                                const Divider(
                                                  height: 1, // ارتفاع الخط
                                                  color:
                                                  Colors.grey, // لون الخط
                                                ),
                                              ],
                                            );
                                          });
                                    }),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
            child:
            Row(
              children: [
                Text(
                  (lang.activeLanguage.languageCode == 'ar')
                      ? 'التوصيل الى '
                      : 'Delivery to ',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  '${(UserPhone != null) ? listAddressUser
                      .dataAddressList[listAddressUser
                      .SelectIndexAddress]["DistrictName2"] : widget
                      .ValueselectedDistrict}',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: AppColors.black,
                  ),
                )
              ],
            ),
          )
              : const Text(''),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,

                    Column(
                      children: [
                        Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            final isNowInDeliveryTime = ref.watch(getDataTimeDeliverynowProvider).isNowInDeliveryTime;

                            if (!isNowInDeliveryTime) {
                              return const SizedBox();
                            }

                            return Row(
                              children: [
                                Radio<String>(
                                  value: "2",
                                  groupValue:
                                  selcetoption,
                                  onChanged: (
                                      value) {
                                    setState(() {
                                      selcetoption = value!;
                                      isTodayActive = 3;
                                      todayName = DateFormat.EEEE().format(today);
                                      selectedTime = DateFormat('hh:mm a').format(DateTime.now());

                                      todayDate = "توصيل الان${DateFormat('yyyy-MM-dd').format(DateTime.now())}";
                                    });
                                  },
                                ),
                                 Text(
                                  (lang.activeLanguage.languageCode == 'ar')
                                      ? 'اختر التوصيل الان'
                                      : 'Choose Delivery Now',
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: AppColors.black,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: [

                        Radio<String>(
                          value: "1",
                          groupValue:
                          selcetoption,
                          onChanged: (
                              value) {
                            setState(() {
                              selcetoption = value!;
                            });
                          },
                        ),
                        const SizedBox(
                            width: 0),
                        Text(
                          (lang.activeLanguage.languageCode == 'ar')
                              ? 'اختر وقت التوصيل'
                              : 'Choose Delivery Time',

                          textAlign:
                          TextAlign
                              .center,
                          style:  GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    selcetoption=="1"?   Column(
                      children: [


                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isTodayActive = 1;
                                    todayName = DateFormat.EEEE().format(today);
                                    todayDate = DateFormat('yyyy-MM-dd').format(today);
                                    selectedCardIndex = 100;
                                    checkTimeNotFound = true;
                                  });
                                  print('$todayName, التاريخ: $todayDate');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: isTodayActive==1 ? Colors.orange : Colors.white,
                                    border: Border.all(
                                      color: Colors.orange,
                                      width: 1.5,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Center(
                                    child: Text(
                                      (lang.activeLanguage.languageCode == 'ar')
                                          ? '${Day[DateFormat.EEEE().format(today)]}'
                                          : DateFormat.EEEE().format(today),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Monadi',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isTodayActive = 2;
                                    todayName = DateFormat.EEEE().format(tomorrow);
                                    todayDate = DateFormat('yyyy-MM-dd').format(tomorrow);
                                  });
                                  print('$todayName, التاريخ: $todayDate');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.orange,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    color: isTodayActive==2 ? Colors.orange : Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Center(
                                    child: Text(
                                      (lang.activeLanguage.languageCode == 'ar')
                                          ? '${Day[DateFormat.EEEE().format(tomorrow)]}'
                                          : DateFormat.EEEE().format(tomorrow),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Monadi',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        10.verticalSpace,

                        10.verticalSpace,


                        (isTodayActive == 1)
                            ? Consumer(builder: (context, ref, child) {
                          final listTimeDelivery =
                          ref.watch(getDataTimeDeliveryProvider);
                          //  selectedDistrict ??= listAddress.dataAddressList.first;

                          return
                            GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: listTimeDelivery.dataTimeDeliveryList
                                    .length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 3.7,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 5,
                                ),
                                itemBuilder: (context, index) {
                                  final startTime =
                                  DateTime.parse(listTimeDelivery
                                      .dataTimeDeliveryList[index]["StartTime"]);
                                  final endTime = DateTime.parse(listTimeDelivery
                                      .dataTimeDeliveryList[index]["EndTime"]);
                                  final formattedStartTime = DateFormat('hh:mm a')
                                      .format(startTime)
                                      .replaceAll('AM', 'ص')
                                      .replaceAll('PM', 'م');
                                  final formattedEndTime = DateFormat('hh:mm a')
                                      .format(endTime)
                                      .replaceAll('AM', 'ص')
                                      .replaceAll('PM', 'م');


                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        DeliveryId = listTimeDelivery
                                            .dataTimeDeliveryList[index]["ID"];


                                        selectedTime =
                                        '${DateFormat('hh:mm a').format(
                                            DateTime.parse(listTimeDelivery
                                                .dataTimeDeliveryList[index]["StartTime"]))} \u00B7 ${DateFormat(
                                            'hh:mm a').format(DateTime.parse(
                                            listTimeDelivery
                                                .dataTimeDeliveryList[index]["EndTime"]))}';
                                        selectedCardIndex = index;
                                        checkTimeNotFound = true;
                                      });
                                    },
                                    child: Container(


                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.orange,
                                          width: 1,
                                        ),

                                        borderRadius: BorderRadius.circular(15),
                                        color: selectedCardIndex == index ? Colors
                                            .orange : Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(

                                          '$formattedStartTime \u00B7 $formattedEndTime',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Monadi',
                                              color: Colors.black
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                        })
                            : Consumer(builder: (context, ref, child) {
                          final listTimeTomorowDelivery =
                          ref.watch(getDataTimeDeliveryTomorowProvider);
                          //  selectedDistrict ??= listAddress.dataAddressList.first;

                          return
                            GridView.builder(
                                itemCount: listTimeTomorowDelivery
                                    .dataTimeDeliveryTomorowList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 3.7,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 5,
                                ),
                                itemBuilder: (context, index) {
                                  final startTime =
                                  DateTime.parse(listTimeTomorowDelivery
                                      .dataTimeDeliveryTomorowList[index]["StartTime"]);
                                  final endTime = DateTime.parse(
                                      listTimeTomorowDelivery
                                          .dataTimeDeliveryTomorowList[index]["EndTime"]);
                                  final formattedStartTime = DateFormat('hh:mm a')
                                      .format(startTime)
                                      .replaceAll('AM', 'ص')
                                      .replaceAll('PM', 'م');
                                  final formattedEndTime = DateFormat('hh:mm a')
                                      .format(endTime)
                                      .replaceAll('AM', 'ص')
                                      .replaceAll('PM', 'م');


                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        DeliveryId = listTimeTomorowDelivery
                                            .dataTimeDeliveryTomorowList[index]["ID"];


                                        selectedTime =
                                        '${DateFormat('hh:mm a').format(
                                            DateTime.parse(listTimeTomorowDelivery
                                                .dataTimeDeliveryTomorowList[index]["StartTime"]))} \u00B7 ${DateFormat(
                                            'hh:mm a').format(DateTime.parse(
                                            listTimeTomorowDelivery
                                                .dataTimeDeliveryTomorowList[index]["EndTime"]))}';
                                        selectedCardIndex = index;
                                        checkTimeNotFound = true;
                                      });
                                    },
                                    child: Container(


                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.orange,
                                          width: 1,
                                        ),

                                        borderRadius: BorderRadius.circular(12),
                                        color: selectedCardIndex == index ? Colors
                                            .orange : Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(

                                          '$formattedStartTime \u00B7 $formattedEndTime',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Monadi',
                                              color: Colors.black
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                        }),
                      ],
                    ):const SizedBox(),
                    if(checkTimeNotFound == false)

                      Center(child: Text(
                        (lang.activeLanguage.languageCode == 'ar')
                            ?


                        'يرجى اختيار وقت التوصيل '
                            : 'Please Choose Delivery Time',
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: Colors.red,
                        ),)),
                    15.verticalSpace,

                    const Divider(
                      thickness: 1,
                      height: 1,
                      color: Colors.black,
                      endIndent: 20,
                      indent: 20,
                    ),
                    15.verticalSpace,
                    Consumer(
                      builder: (context, ref, child) {
                        final codeDiscount = ref.watch(
                            discountCodeFromApiProvider);

                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.orange,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(
                                25), // Adjust the border radius as needed
                            color: Colors
                                .white,

                          ),
                          height: 40.h,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(

                                  decoration: InputDecoration(
                                    hintText:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? '  ادخل كود الخصم'
                                        : ' Enter discount code',
                                    hintStyle: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14.sp,
                                      color: AppColors.gray,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  controller:
                                  discountValueControllerCheckOutOnSystem,
                                ),
                              ),
                              const SizedBox(width: 8),

                              InkWell(
                                onTap: () {
                                  if (discountValueControllerCheckOutOnSystem.text.isNotEmpty) {
                                    setState(() {
                                      codeDiscount.isLoading = true; // تفعيل وضع التحميل
                                    });

                                    codeDiscount.getDiscountCode(
                                      context: context,
                                      DiscountCode: discountValueControllerCheckOutOnSystem.text,
                                      CustomerPhone: (UserPhone != null)
                                          ? UserPhone
                                          : '${widget.mobileNumberControllerCheckOutOnSystem}',
                                    ).then((_) {
                                      setState(() {
                                        codeDiscount.isLoading = false; // إيقاف التحميل بعد اكتمال العملية

                                        if (codeDiscount.discountCodeList.isNotEmpty &&
                                            codeDiscount.discountCodeList[0]["DiscountValue"] == 0) {
                                          // خصم كنسبة مئوية
                                          widget.DiscountPercent = codeDiscount.discountCodeList[0]["DiscountPercent"];
                                          widget.discountValue = ((widget.DiscountPercent / 100) * totalPrice);
                                        } else {
                                          // خصم بقيمة ثابتة
                                          widget.discountValue = codeDiscount.discountCodeList[0]["DiscountValue"];
                                        }

                                        roundedFinalPrice = ((totalPrice - widget.discountValue) +
                                            ((totalPrice >= 20)
                                                ? 0
                                                : ((UserPhone == null)
                                                ? widget.DeliveryValue
                                                : double.parse(deleveryValue ?? '1.00'))));

                                        FinalPrice = double.parse(roundedFinalPrice.toStringAsFixed(3));

                                        print('Updated discount list: ${codeDiscount.discountCodeList}');
                                      });
                                    }).catchError((error) {
                                      setState(() {
                                        codeDiscount.isLoading = false; // إيقاف التحميل في حالة الخطأ
                                      });
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: codeDiscount.isLoading
                                      ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.orange,
                                    ),
                                  )
                                      : Text(
                                    (lang.activeLanguage.languageCode == 'ar') ? 'تفعيل' : 'Apply',
                                    style: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        );
                      },
                    ),
                    10.verticalSpace,
                    // if(UserPhone != null)
                    //   Consumer(
                    //     builder: (context, ref, child) {
                    //       final walletPoints = ref.watch(walletPointsProvider);
                    //
                    //       return Container(
                    //         padding: const EdgeInsetsDirectional.symmetric(
                    //             horizontal: 5, vertical: 1),
                    //         decoration: BoxDecoration(
                    //           border: Border.all(
                    //             color: Colors.orange,
                    //             width: 1,
                    //           ),
                    //           borderRadius: BorderRadius.circular(
                    //               25),
                    //           color: Colors
                    //               .white,
                    //
                    //         ),
                    //         height: 40.h,
                    //         child: Row(
                    //           children: [
                    //             Text(
                    //               (lang.activeLanguage.languageCode == 'ar')
                    //                   ? 'محفظه (نقاطى)'
                    //                   : 'Wallet (My Points)',
                    //               style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 14.sp,
                    //                 fontFamily: 'Monadi',
                    //                 color: AppColors.black,
                    //               ),
                    //             ),
                    //             const SizedBox(width: 5,),
                    //             if (walletPoints.walletPointsList.isNotEmpty )
                    //               Text(
                    //                 '${walletPoints
                    //                     .walletPointsList[0]['PointsBalance']
                    //                     .toStringAsFixed(3)}',
                    //                 style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 14.sp,
                    //                   fontFamily: 'Monadi',
                    //                   color: Colors.orange,
                    //                 ),
                    //               ),
                    //             const SizedBox(width: 5,),
                    //             Text(
                    //               (lang.activeLanguage.languageCode == 'ar')
                    //                   ? 'نقطة'
                    //                   : 'Point',
                    //               style: TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 14.sp,
                    //                 fontFamily: 'Monadi',
                    //                 color: AppColors.black,
                    //               ),
                    //             ),
                    //             const Spacer(),
                    //             InkWell(
                    //               onTap: () {
                    //                 setState(() {
                    //                   if (checkWalletPoint) {
                    //                     FinalPrice = 0.0;
                    //
                    //                     double value = (getSubscriptionDelivery
                    //                         .subscriptionList[0]['IsSubscribe'] ==
                    //                         true)
                    //                         ? 0.000
                    //                         : (deleveryValue ?? 0.500);
                    //
                    //                     FinalPrice = (totalPrice + value) -
                    //                         walletPoints
                    //                             .walletPointsList[0]['PointsValue'];
                    //
                    //                     checkWalletPoint = false;
                    //                   }
                    //                   else {
                    //                     ScaffoldMessenger.of(context)
                    //                         .showSnackBar(const SnackBar(
                    //                         backgroundColor:
                    //                         Color(0xffcc0000),
                    //                         content: Text(
                    //                           'عدد النقاط غير كافى ',
                    //                         )));
                    //                   }
                    //                 });
                    //               },
                    //               child: Padding(
                    //                 padding: const EdgeInsets.symmetric(
                    //                     horizontal: 5),
                    //                 child: Text(
                    //                   (lang.activeLanguage.languageCode == 'ar')
                    //                       ? 'دفع'
                    //                       : 'Apply',
                    //                   style: GoogleFonts.tajawal(
                    //                     fontWeight: FontWeight.w600,
                    //                     fontSize: 14.sp,
                    //                     color: Colors.orange,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // 10.verticalSpace,

                    Consumer(builder: (context, ref, child) {
                      final getAmount = ref.watch(getWalletApiProvider);
                      final orderItemFun = ref.watch(orderItemProvider);
                      final listItemOrderImage = ref.watch(
                          orderProviderListImage);
                      return Row(
                        children: [
                          Text(
                            (lang.activeLanguage.languageCode == 'ar')
                                ? 'رصيد المحفظه'
                                : 'Wallet Balance',
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.black,
                            ),
                          ),
                          10.horizontalSpace,
                          Row(
                            children: [
                              Text(
                                (getAmount.amountValueList.isNotEmpty)
                                    ? '${getAmount.amountValueList[0]['Balance']
                                    .toStringAsFixed(3)}'
                                    : '0.0',
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: AppColors.green,
                                ),
                              ),
                              5.horizontalSpace,
                              Text(
                                (lang.activeLanguage.languageCode == 'ar')
                                    ? 'د.ك '
                                    : 'K.D',
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate() &&
                                  selectedCardIndex! >= 0) {
                                if (totalPrice + widget.discountValue <=
                                    ((UserPhone == null)
                                        ? widget.BilleValue
                                        : num.parse(BillValue ?? '3.5'))) {

                                }

                                else {
                                  if (getAmount.amountValueList[0].isNotEmpty) {
                                    discountCardValue = (FinalPrice == 0.0)
                                        ? (totalPrice + (double.parse(deleveryValue ?? '1.00')))
                                        : FinalPrice;

                                    if (getAmount
                                        .amountValueList[0]['Balance'] >=
                                        discountCardValue) {
                                      print('Final Price  ${FinalPrice}');

                                      print(
                                          'discountCardValue   ${discountCardValue}');
                                      orderItemFun.orderItemFu(
                                          context: context,

                                          OrderDate: DateFormat('yyyy-MM-dd')
                                              .format(_timeData)
                                              .toString(),
                                          CustomerAddress: listAddressUser
                                              .dataAddressList[selectAddress]
                                          ["CustomerAddress"], regionName:listAddressUser
                                          .dataAddressList[
                                      selectAddress]
                                      [
                                      "GovernorateName"],
                                          CustomerPhone: listAddressUser
                                              .dataAddressList[selectAddress]
                                          ["CustomerPhone"],
                                          CustomerName: listAddressUser
                                              .dataAddressList[selectAddress]
                                          ["ArabicName"],
                                          Email: listAddressUser
                                              .dataAddressList[selectAddress]["Email"],
                                          DeliveryID: DeliveryId,
                                          DiscountCode:
                                          discountValueControllerCheckOutOnSystem
                                              .text,
                                          Details: widget.titleNotes,
                                          DeliveryDate: todayDate,
                                          DeliveryDay: todayName,
                                          OrderTime: selectedTime,
                                          TotalValue: totalPrice,
                                          Additions:(totalPrice>=20)?0:
                                          double.parse(
                                              deleveryValue ?? '1.00'),
                                          Discount: widget.discountValue,
                                          FinalValue: (FinalPrice == 0.0)
                                              ? ((totalPrice +
                                              double.parse(deleveryValue ?? '1.00')) - discountCardValue)
                                              : (FinalPrice - discountCardValue),

                                          DiscountCardValue: discountCardValue,
                                          PayID: 0,
                                          OnlineStoreId: -1,
                                          orderList: widget.newmyList,
                                          Image: listItemOrderImage
                                              .orderListImage,
                                          paymentMethodeWalet: 1,
                                          discountPointsValue: walletPoints
                                              .walletPointsList[0]['PointsValue']
                                      );

                                      print('DFinal Price  ${FinalPrice}');

                                      print(
                                          'discountCardValue   ${discountCardValue}');
                                    } else {
                                      print('Final Price  ${FinalPrice}');

                                      print(
                                          'discountCardValue   ${discountCardValue}');
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                      title: Text(
                                                        'اجمالى الفاتوره اكبر من رصيد المحفظه ',
                                                        style: GoogleFonts
                                                            .cairo(
                                                          fontSize: 16.sp,
                                                          color: const Color(
                                                              0xff000000),
                                                          fontWeight: FontWeight
                                                              .w500,
                                                        ),
                                                      ),
                                                      content: Column(
                                                        mainAxisSize: MainAxisSize
                                                            .min,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                (lang
                                                                    .activeLanguage
                                                                    .languageCode ==
                                                                    'ar')
                                                                    ? 'رصيد المحفظه'
                                                                    : 'Wallet Balance',
                                                                style: GoogleFonts
                                                                    .cairo(
                                                                  fontSize: 16
                                                                      .sp,
                                                                  color: const Color(
                                                                      0xff000000),
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                ),
                                                              ),
                                                              12
                                                                  .horizontalSpace,
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    (getAmount
                                                                        .amountValueList.isNotEmpty)
                                                                        ? '${getAmount
                                                                        .amountValueList[0]['Balance']
                                                                        .toStringAsFixed(
                                                                        3)}'
                                                                        : '0.0',
                                                                    style:
                                                                    GoogleFonts
                                                                        .cairo(
                                                                      fontSize: 16
                                                                          .sp,
                                                                      color:
                                                                      Colors
                                                                          .orange,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    (lang
                                                                        .activeLanguage
                                                                        .languageCode ==
                                                                        'ar')
                                                                        ? 'د.ك '
                                                                        : 'K.D',
                                                                    style:
                                                                    GoogleFonts
                                                                        .cairo(
                                                                      fontSize: 16
                                                                          .sp,
                                                                      color:
                                                                      AppColors
                                                                          .black,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                (lang
                                                                    .activeLanguage
                                                                    .languageCode ==
                                                                    'ar')
                                                                    ? 'اجمالى الفاتوره '
                                                                    : 'Total Invoice',
                                                                style: GoogleFonts
                                                                    .cairo(
                                                                  fontSize: 16
                                                                      .sp,
                                                                  color: AppColors
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                              12
                                                                  .horizontalSpace,
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    (FinalPrice ==
                                                                        0.0)
                                                                        ? ' ${(totalPrice +
                                                                        ((UserPhone ==
                                                                            null)
                                                                            ? widget
                                                                            .DeliveryValue
                                                                            : double
                                                                            .parse(
                                                                            deleveryValue ??
                                                                                '1.00')))
                                                                        .toStringAsFixed(
                                                                        3)} '
                                                                        : ' ${(FinalPrice)
                                                                        .toStringAsFixed(
                                                                        3)} ',
                                                                    style:
                                                                    GoogleFonts
                                                                        .cairo(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontSize: 16
                                                                          .sp,
                                                                      color:
                                                                      Colors
                                                                          .orange,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    (lang
                                                                        .activeLanguage
                                                                        .languageCode ==
                                                                        'ar')
                                                                        ? 'د.ك '
                                                                        : 'K.D',
                                                                    style:
                                                                    GoogleFonts
                                                                        .cairo(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontSize: 16
                                                                          .sp,
                                                                      color:
                                                                      AppColors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          Text(
                                                            "اختار احدى طرق الدفع لدفع ما تبقى من الفاتوره",
                                                            style: GoogleFonts
                                                                .cairo(
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              fontSize: 16.sp,
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              50
                                                                  .horizontalSpace,
                                                              Radio(
                                                                value: 1,
                                                                groupValue:
                                                                selectedOptionWallet,
                                                                onChanged: (
                                                                    value) {
                                                                  setState(() {
                                                                    selectedOptionWallet =
                                                                    value!;
                                                                    print(
                                                                        selectedOptionWallet);
                                                                  });
                                                                },
                                                                visualDensity:
                                                                const VisualDensity(
                                                                    horizontal: -4,
                                                                    vertical: -4),
                                                              ),
                                                              const SizedBox(
                                                                  width: 0),
                                                              Text(
                                                                (lang
                                                                    .activeLanguage
                                                                    .languageCode ==
                                                                    'ar')
                                                                    ? 'الدفع كى نت اونلاين'
                                                                    : 'KNET Online Payment (Online)',
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                                style: GoogleFonts
                                                                    .cairo(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize: 16
                                                                      .sp,
                                                                  color: AppColors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              50
                                                                  .horizontalSpace,
                                                              Radio(
                                                                value: 2,
                                                                groupValue:
                                                                selectedOptionWallet,
                                                                onChanged: (
                                                                    value) {
                                                                  setState(() {
                                                                    selectedOptionWallet =
                                                                    value!;
                                                                    print(
                                                                        selectedOptionWallet);
                                                                  });
                                                                },
                                                                visualDensity:
                                                                const VisualDensity(
                                                                    horizontal: -4,
                                                                    vertical: -4),
                                                              ),
                                                              const SizedBox(
                                                                  width: 0),
                                                              Text(
                                                                (lang
                                                                    .activeLanguage
                                                                    .languageCode ==
                                                                    'ar')
                                                                    ? 'فيزا / ماستر'
                                                                    : "VISA/MASTER",
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                                style: GoogleFonts
                                                                    .cairo(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize: 16
                                                                      .sp,
                                                                  color: AppColors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              50
                                                                  .horizontalSpace,
                                                              Radio(
                                                                value: 24,
                                                                groupValue:
                                                                selectedOptionWallet,
                                                                onChanged: (
                                                                    value) {
                                                                  setState(() {
                                                                    selectedOptionWallet =
                                                                    value!;
                                                                    print(
                                                                        selectedOptionWallet);
                                                                  });
                                                                },
                                                                visualDensity:
                                                                const VisualDensity(
                                                                    horizontal: -4,
                                                                    vertical: -4),
                                                              ),
                                                              const SizedBox(
                                                                  width: 0),
                                                              Text(
                                                                (lang
                                                                    .activeLanguage
                                                                    .languageCode ==
                                                                    'ar')
                                                                    ? 'ابل باى'
                                                                    : 'Apple Pay (KWD)',
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                                style: GoogleFonts
                                                                    .cairo(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize: 16
                                                                      .sp,
                                                                  color: AppColors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              50
                                                                  .horizontalSpace,
                                                              Radio(
                                                                value: 26,
                                                                groupValue:
                                                                selectedOptionWallet,
                                                                onChanged: (
                                                                    value) {
                                                                  setState(() {
                                                                    selectedOptionWallet =
                                                                    value!;
                                                                    print(
                                                                        selectedOptionWallet);
                                                                  });
                                                                },
                                                                visualDensity:
                                                                const VisualDensity(
                                                                    horizontal: -4,
                                                                    vertical: -4),
                                                              ),
                                                              const SizedBox(
                                                                  width: 0),
                                                              Text(
                                                                (lang
                                                                    .activeLanguage
                                                                    .languageCode ==
                                                                    'ar')
                                                                    ? 'جوجل باى'
                                                                    : 'Google Pay (KWD(Online)',
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                                style: GoogleFonts
                                                                    .cairo(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize: 16
                                                                      .sp,
                                                                  color: AppColors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        Row(children: [
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () async {
                                                                var request =
                                                                MFExecutePaymentRequest(
                                                                  customerName: listAddressUser
                                                                      .dataAddressList[
                                                                  selectAddress]
                                                                  ["ArabicName"],
                                                                  customerMobile: listAddressUser
                                                                      .dataAddressList[
                                                                  selectAddress]
                                                                  ["CustomerPhone"],
                                                                  paymentMethodId:
                                                                  selectedOptionWallet,
                                                                  invoiceValue:
                                                                  (discountCardValue -
                                                                      getAmount
                                                                          .amountValueList[
                                                                      0][
                                                                      'Balance']),
                                                                );
                                                                request
                                                                    .displayCurrencyIso =
                                                                    MFCurrencyISO
                                                                        .KUWAIT_KWD;

                                                                await MFSDK
                                                                    .executePayment(
                                                                    request,
                                                                    MFLanguage
                                                                        .ARABIC,
                                                                        (
                                                                        invoiceId) {
                                                                      log(
                                                                          invoiceId);
                                                                      setState(() {
                                                                        paymentSuccess =
                                                                        true;
                                                                      });
                                                                    })
                                                                    .then((
                                                                    value) =>
                                                                {
                                                                  log(value),
                                                                  orderItemFun
                                                                      .orderItemFu(
                                                                      context:
                                                                      context,
                                                                      OrderDate: DateFormat(
                                                                          'yyyy-MM-dd')
                                                                          .format(
                                                                          _timeData)
                                                                          .toString(),
                                                                      CustomerAddress:
                                                                      listAddressUser
                                                                          .dataAddressList[selectAddress]
                                                                      [
                                                                      "CustomerAddress"],
                                                                      CustomerPhone:
                                                                      listAddressUser
                                                                          .dataAddressList[selectAddress]
                                                                      [
                                                                      "CustomerPhone"], regionName:listAddressUser
                                                                      .dataAddressList[
                                                                  selectAddress]
                                                                  [
                                                                  "RegionName"],
                                                                      CustomerName:
                                                                      listAddressUser
                                                                          .dataAddressList[selectAddress]
                                                                      [
                                                                      "ArabicName"],
                                                                      Email: listAddressUser
                                                                          .dataAddressList[
                                                                      selectAddress]
                                                                      ["Email"],
                                                                      DeliveryID:
                                                                      DeliveryId,
                                                                      DiscountCode:
                                                                      discountValueControllerCheckOutOnSystem
                                                                          .text,
                                                                      Details: widget
                                                                          .titleNotes,
                                                                      DeliveryDate:
                                                                      todayDate,
                                                                      DeliveryDay:
                                                                      todayName,
                                                                      OrderTime:
                                                                      selectedTime,
                                                                      TotalValue:
                                                                      totalPrice,
                                                                      Additions: double
                                                                          .parse(
                                                                          deleveryValue ??
                                                                              '1.00'),
                                                                      Discount: widget
                                                                          .discountValue,
                                                                      FinalValue: (FinalPrice ==
                                                                          0.0)
                                                                          ? ((totalPrice +
                                                                          double
                                                                              .parse(
                                                                              deleveryValue ??
                                                                                  '1.00')) -
                                                                          discountCardValue)
                                                                          : (FinalPrice -
                                                                          discountCardValue),
                                                                      DiscountCardValue:
                                                                      getAmount
                                                                          .amountValueList[
                                                                      0]
                                                                      [
                                                                      'Balance'],
                                                                      PayID: 2,
                                                                      OnlineStoreId:
                                                                      -1,
                                                                      orderList: widget
                                                                          .newmyList,
                                                                      Image: listItemOrderImage
                                                                          .orderListImage,
                                                                      discountPointsValue: walletPoints
                                                                          .walletPointsList[0]['PointsValue']
                                                                  ),
                                                                })
                                                                    .catchError((
                                                                    error) =>
                                                                {
                                                                  log(error
                                                                      .message),
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (
                                                                          context) =>
                                                                          PaymentErrorPage(),
                                                                    ),
                                                                  )
                                                                });
                                                              },
                                                              child: Container(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    7.0),
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      5),
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    'موافق',
                                                                    style: TextStyle(
                                                                      color:
                                                                      Colors
                                                                          .orange,
                                                                      fontSize: 12
                                                                          .sp,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                    context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .orange,
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      5.0),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                      'الغاء',
                                                                      style: TextStyle(
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                      ),
                                                                    )),
                                                              ),
                                                            ),
                                                          )
                                                        ])
                                                      ]);
                                                });
                                          });
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) =>
                                          AlertDialog(
                                              title: Text(
                                                'لايوجد رصيد بالمحفظه',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: const Color(
                                                      0xff000000),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Monadi',
                                                ),
                                              ),
                                              content: Text(
                                                "يرجى عمل ايداع بالمحفظه او استخدام وسيله دفع اخرى ",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: const Color(
                                                      0xff000000),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Monadi',
                                                ),
                                              ),
                                              actions: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.all(
                                                          8.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.orange,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                            'موافق',
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                    );
                                  }
                                }
                              }
                              else {

                                setState(() {
                                  checkTimeNotFound = false;
                                });
                              }
                              setState(() {});
                            },
                            child: Text(
                              (lang.activeLanguage.languageCode == 'ar')
                                  ? 'دفع'
                                  : 'pay',
                              style: GoogleFonts.cairo(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          5.horizontalSpace,
                          Image.asset(AppAssets.wallet, width: 30,
                            height: 30,
                            fit: BoxFit.contain,),
                        ],
                      );
                    }),

                    13.verticalSpace,

                    const Divider(
                      thickness: 1,
                      height: 1,
                      color: Colors.black,
                      endIndent: 20,
                      indent: 20,
                    ),
                    5.verticalSpace,
                    Text(
                        (lang.activeLanguage.languageCode == 'ar')
                            ? ' طريقه الدفع'
                            : 'Choose Payment Method',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          fontFamily: 'Monadi',
                          color: AppColors.black,
                        )),
                    if (widget.PaymentMethod != 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // 50.horizontalSpace,
                          Radio(
                            value: 0,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                if (widget.PaymentMethod == 0) {
                                  selectedOption = value!;
                                  print(selectedOption);
                                } else if (widget.PaymentMethod == 2) {
                                  selectedOption = value!;
                                  print(selectedOption);
                                } else if (widget.PaymentMethod == null) {
                                  selectedOption = value!;
                                  print(selectedOption);
                                } else {
                                  print(widget.PaymentMethod);
                                  print(widget.PaymentMethod.runtimeType);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text((lang
                                            .activeLanguage.languageCode ==
                                            'ar')
                                            ? 'هذه المنطقه طرق الدفع المتاحه فيها الدفع عن طريق الكى نت فقط'
                                            : 'These are the payment methods that you can choose to pay via KNET only'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                                (lang.activeLanguage
                                                    .languageCode ==
                                                    'ar')
                                                    ? 'موافق'
                                                    : 'OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              });
                            },
                            visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                          ),
                          Text(
                            (lang.activeLanguage.languageCode == 'ar')
                                ? 'الدفع عند الاستلام '
                                : 'Cash on Delivery ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            ),
                          ),
                          const Spacer(),

                          Image.asset(AppAssets.money, width: 30,
                            height: 30,
                            fit: BoxFit.contain,),
                        ],
                      ),
                    if (widget.PaymentMethod != 0)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // 50.horizontalSpace,
                                  Radio(
                                    value: 1,
                                    groupValue: selectedOption,
                                    onChanged: (value) {
                                      setState(() {
                                        if (widget.PaymentMethod == 1) {
                                          selectedOption = value!;
                                          selectedOptionPaymentId = 1;
                                          print(selectedOption);
                                        } else if (widget.PaymentMethod == 2) {
                                          selectedOption = value!;
                                          selectedOptionPaymentId = 1;
                                          print(selectedOption);
                                        } else
                                        if (widget.PaymentMethod == null) {
                                          selectedOption = value!;
                                          selectedOptionPaymentId = 1;
                                          print(selectedOption);
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Text(
                                                    (lang.activeLanguage
                                                        .languageCode ==
                                                        'ar')
                                                        ? 'هذه المنطقه طرق الدفع المتاحه فيها الدفع كاش'
                                                        : 'This area has cash payment methods available'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                        (lang.activeLanguage
                                                            .languageCode ==
                                                            'ar')
                                                            ? 'موافق'
                                                            : 'OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      });
                                    },
                                    visualDensity:
                                    const VisualDensity(horizontal: -4, vertical: -4),
                                  ),
                                  const SizedBox(width: 0),
                                  Text(
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'الدفع كى نت اونلاين'
                                        : 'KNET Online Payment (Online)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      fontFamily: 'Monadi',
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Image.network(
                                  'https://portal.myfatoorah.com/imgs/payment-methods/kn.png',
                                  width: 30, height: 30, fit: BoxFit.contain
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // 50.horizontalSpace,
                                  Radio(
                                    value: 2,
                                    groupValue: selectedOption,
                                    onChanged: (value) {
                                      setState(() {
                                        if (widget.PaymentMethod == 1) {
                                          selectedOption = value!;
                                          selectedOptionPaymentId = 2;
                                          print(selectedOption);
                                        } else if (widget.PaymentMethod == 2) {
                                          selectedOption = value!;
                                          selectedOptionPaymentId = 2;
                                          print(selectedOption);
                                        } else
                                        if (widget.PaymentMethod == null) {
                                          selectedOption = value!;
                                          selectedOptionPaymentId = 2;
                                          print(selectedOption);
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Text(
                                                    (lang.activeLanguage
                                                        .languageCode ==
                                                        'ar')
                                                        ? 'هذه المنطقه طرق الدفع المتاحه فيها الدفع كاش'
                                                        : 'This area has cash payment methods available'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                        (lang.activeLanguage
                                                            .languageCode ==
                                                            'ar')
                                                            ? 'موافق'
                                                            : 'OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      });
                                    },
                                    visualDensity:
                                    const VisualDensity(horizontal: -4, vertical: -4),
                                  ),
                                  const SizedBox(width: 0),
                                  Text(
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'فيزا / ماستر'
                                        : "VISA/MASTER",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      fontFamily: 'Monadi',
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Image.network(
                                  'https://portal.myfatoorah.com/imgs/payment-methods/vm.png',
                                  width: 30, height: 30, fit: BoxFit.contain
                              )
                            ],
                          ),

                          // if(Platform.isIOS)
                          //   Consumer(
                          //
                          //       builder: (context, ref, child) {
                          //         final orderItemFun = ref.watch(
                          //             orderItemProvider);
                          //         final listItemOrderImage =
                          //         ref.watch(orderProviderListImage);
                          //
                          //         return
                          //           InkWell(
                          //             onTap: () async {
                          //               if (_formKey.currentState!.validate() && selectedCardIndex! >= 0) {
                          //                 print("press applepay");
                          //
                          //                 MFExecutePaymentRequest executePaymentRequest =
                          //                 MFExecutePaymentRequest(
                          //                   invoiceValue: (FinalPrice == 0.0)
                          //                       ? (totalPrice +
                          //                       ((totalPrice >= 20) // إذا كانت totalPrice أكبر من أو تساوي 20
                          //                           ? 0.0 // لا يتم إضافة رسوم التوصيل
                          //                           : (UserPhone == null)
                          //                           ? double.parse(widget.DeliveryValue.toString()) // إذا كانت UserPhone فارغة
                          //                           : double.parse(
                          //                           (getSubscriptionDelivery.subscriptionList.isEmpty)
                          //                               ? '0.500' // إذا كانت subscriptionList فارغة
                          //                               : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                          //                               ? '0.000' // إذا كانت الاشتراك نشطًا
                          //                               : (deleveryValue ?? '1.00') // إذا لم يكن هناك قيمة محددة
                          //                       )
                          //                       )
                          //                   )
                          //                       : FinalPrice,
                          //                 );
                          //
                          //                 executePaymentRequest.displayCurrencyIso = MFCurrencyISO.KUWAIT_KWD;
                          //
                          //                 await mfApplePayButton.displayApplePayButton(
                          //                     sessionApple, executePaymentRequest, MFLanguage.ENGLISH)
                          //                     .then((value) =>
                          //                 {
                          //                   log(value),
                          //                   mfApplePayButton
                          //                       .executeApplePayButton(executePaymentRequest, (invoiceId) => log(invoiceId))
                          //                       .then((value) {
                          //                     if (UserPhone != null) {
                          //                       orderItemFun.orderItemFu(
                          //                         DistriictName: listAddressUser.dataAddressList[selectAddress]["DistrictName"],
                          //                         context: context,
                          //                         regionName:listAddressUser.dataAddressList[selectAddress]["RegionName"],
                          //                         OrderDate: DateFormat('yyyy-MM-dd').format(_timeData).toString(),
                          //                         CustomerAddress: listAddressUser.dataAddressList[selectAddress]["CustomerAddress"],
                          //                         CustomerPhone: listAddressUser.dataAddressList[selectAddress]["CustomerPhone"],
                          //                         CustomerName: listAddressUser.dataAddressList[selectAddress]["ArabicName"],
                          //                         Block: listAddressUser.dataAddressList[selectAddress]["Block"],
                          //                         Street: listAddressUser.dataAddressList[selectAddress]["StreetName"],
                          //                         House: listAddressUser.dataAddressList[selectAddress]["HouseNo"],
                          //                         DiscountCode: discountValueControllerCheckOutOnSystem.text,
                          //                         Gada: listAddressUser.dataAddressList[selectAddress]["Gada"],
                          //                         Floor: listAddressUser.dataAddressList[selectAddress]["Floor"],
                          //                         Apartment: listAddressUser.dataAddressList[selectAddress]["Apartment"],
                          //                         Email: listAddressUser.dataAddressList[selectAddress]["Email"],
                          //                         DeliveryID: DeliveryId,
                          //                         Details: widget.titleNotes,
                          //                         DeliveryDate: todayDate,
                          //                         DeliveryDay: todayName,
                          //                         OrderTime: selectedTime,
                          //                         TotalValue: totalPrice,
                          //                         Additions:(totalPrice>=20)?0: (UserPhone == null) ? widget.DeliveryValue :
                          //                         (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true) ? 0.000 : deleveryValue ??1,
                          //                         Discount: widget.discountValue,
                          //                         FinalValue: (FinalPrice == 0.0)
                          //                             ? (totalPrice >= 20
                          //                             ? totalPrice // إذا كانت قيمة totalPrice أكبر من أو تساوي 20، لا تتم إضافة رسوم التوصيل
                          //                             : totalPrice + double.parse(
                          //                             (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                          //                                 ? '0.000' // إذا كان الاشتراك نشطًا، لا يتم إضافة رسوم التوصيل
                          //                                 : deleveryValue ??'1.00' // إذا لم يكن الاشتراك نشطًا، يتم إضافة القيمة الافتراضية
                          //                         )
                          //                         )
                          //                             : FinalPrice,
                          //
                          //                         DiscountCardValue: 0,
                          //                         PayID: 2,
                          //                         OnlineStoreId: -1,
                          //                         orderList: widget.newmyList,
                          //                         Image: listItemOrderImage.orderListImage,
                          //                         discountPointsValue: walletPoints.walletPointsList[0]['PointsValue'],
                          //                       );
                          //                     }
                          //                     else {
                          //                       orderItemFun.orderItemFu(
                          //                         DistriictName: widget.ValueselectedDistrict,
                          //                         context: context,
                          //                         OrderDate: DateFormat('yyyy-MM-dd').format(_timeData).toString(),
                          //                         CustomerPhone: widget.mobileNumberControllerCheckOutOnSystem,
                          //                         CustomerName: widget.nameControllerCheckOutOnSystem,
                          //                         customerMapAdress: widget.customerAdressMap,
                          //                         placeId: widget.placeId,
                          //                         regionName: widget.regionName,
                          //                         Block: widget.BlockNumberControllerCheckOutOnSystem,
                          //                         Street: widget.StreetControllerCheckOutOnSystem,
                          //                         House: widget.HouseControllerCheckOutOnSystem,
                          //                         Gada: widget.gada,
                          //                         Floor: widget.floorControllerCheckOutOnSystem,
                          //                         Apartment: widget.apartmentControllerCheckOutOnSystem,
                          //                         Email: widget.emailControllerCheckOutOnSystem,
                          //                         DeliveryID: DeliveryId,
                          //                         DiscountCode: discountValueControllerCheckOutOnSystem.text,
                          //                         Details: widget.titleNotes,
                          //                         DeliveryDate: todayDate,
                          //                         DeliveryDay: todayName,
                          //                         OrderTime: selectedTime,
                          //                         TotalValue: totalPrice,
                          //                         Additions:(totalPrice>=20)?0: (UserPhone == null) ? widget.DeliveryValue :
                          //                         (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true) ? 0.000 : deleveryValue ??1,
                          //                         Discount: widget.discountValue,
                          //                         FinalValue: (FinalPrice == 0.0)
                          //                             ? (totalPrice >= 20
                          //                             ? totalPrice // إذا كانت قيمة totalPrice أكبر من أو تساوي 20، لا تتم إضافة رسوم التوصيل
                          //                             : totalPrice + widget.DeliveryValue) // إذا كانت قيمة totalPrice أقل من 20، يتم إضافة رسوم التوصيل
                          //                             : FinalPrice, // إذا كانت قيمة FinalPrice ليست 0.0، يتم استخدام FinalPrice مباشرةً
                          //
                          //                         DiscountCardValue: 0,
                          //                         PayID: 2,
                          //                         OnlineStoreId: -1,
                          //                         orderList: widget.newmyList,
                          //                         Image: listItemOrderImage.orderListImage,
                          //                         CustomerAddress: widget.customerAdressMap, // UPDATED HERE
                          //                       );
                          //                     }
                          //                   }
                          //                   )
                          //                       .catchError((error) => {
                          //                     Navigator.push(
                          //                       context,
                          //                       MaterialPageRoute(builder: (context) => PaymentErrorPage()),
                          //                     ),
                          //
                          //                     log(error.message)})
                          //                 })
                          //                     .catchError((error) =>
                          //                 {
                          //                   Navigator.push(
                          //                     context,
                          //                     MaterialPageRoute(builder: (context) => PaymentErrorPage()),
                          //                   ),
                          //
                          //                   log(error.message)
                          //                 });
                          //               }
                          //
                          //             },
                          //             child:   Row(
                          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Row(
                          //                   mainAxisAlignment: MainAxisAlignment.start,
                          //                   children: [
                          //                     // 50.horizontalSpace,
                          //                     Radio(
                          //                       value: 24,
                          //                       groupValue: selectedOption,
                          //                       onChanged: (value) {
                          //                         setState(() {
                          //                           if (widget.PaymentMethod == 1) {
                          //                             selectedOption = value!;
                          //                             selectedOptionPaymentId = 24;
                          //                             print(selectedOption);
                          //                           } else if (widget.PaymentMethod == 2) {
                          //                             selectedOption = value!;
                          //                             selectedOptionPaymentId = 24;
                          //                             print(selectedOption);
                          //                           } else
                          //                           if (widget.PaymentMethod == null) {
                          //                             selectedOption = value!;
                          //                             selectedOptionPaymentId = 24;
                          //                             print(selectedOption);
                          //                           } else {
                          //                             showDialog(
                          //                               context: context,
                          //                               builder: (BuildContext context) {
                          //                                 return AlertDialog(
                          //                                   content: Text(
                          //                                       (lang.activeLanguage
                          //                                           .languageCode ==
                          //                                           'ar')
                          //                                           ? 'هذه المنطقه طرق الدفع المتاحه فيها الدفع كاش'
                          //                                           : 'This area has cash payment methods available'),
                          //                                   actions: <Widget>[
                          //                                     TextButton(
                          //                                       onPressed: () {
                          //                                         Navigator.of(context)
                          //                                             .pop();
                          //                                       },
                          //                                       child: Text(
                          //                                           (lang.activeLanguage
                          //                                               .languageCode ==
                          //                                               'ar')
                          //                                               ? 'موافق'
                          //                                               : 'OK'),
                          //                                     ),
                          //                                   ],
                          //                                 );
                          //                               },
                          //                             );
                          //                           }
                          //                         });
                          //                       },
                          //                       visualDensity:
                          //                       const VisualDensity(horizontal: -4, vertical: -4),
                          //                     ),
                          //                     const SizedBox(width: 0),
                          //                     Text(
                          //                       (lang.activeLanguage.languageCode == 'ar')
                          //                           ? 'ابل باى'
                          //                           : 'Apple Pay (KWD)',
                          //                       textAlign: TextAlign.center,
                          //                       style: TextStyle(
                          //                         fontWeight: FontWeight.w500,
                          //                         fontSize: 16.sp,
                          //                         fontFamily: 'Monadi',
                          //                         color: AppColors.black,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 Image.network(
                          //                     'https://portal.myfatoorah.com/imgs/payment-methods/ap.png',
                          //                     width: 30, height: 30, fit: BoxFit.contain
                          //                 )
                          //               ],
                          //             ),
                          //           );
                          //
                          //       }
                          //   ),

                          if (Platform.isAndroid)
                            Consumer(

                                builder: (context, ref, child) {
                                  final orderItemFun = ref.watch(
                                      orderItemProvider);
                                  final listItemOrderImage =
                                  ref.watch(orderProviderListImage);

                                  return
                                    InkWell(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate() && selectedCardIndex! >= 0) {
                                          print('GAAAAAAAAAAAAAAAAA1111111111111111111111');
                                          MFGooglePayRequest googlePayRequest = MFGooglePayRequest(
                                            totalPrice: (FinalPrice == 0.0)
                                                ? (totalPrice >= 20
                                                ? totalPrice  // إذا كانت قيمة totalPrice أكبر من أو تساوي 20، لا يتم إضافة رسوم التوصيل
                                                : (totalPrice +
                                                ((UserPhone == null)
                                                    ? widget.DeliveryValue
                                                    : double.parse(
                                                    (getSubscriptionDelivery.subscriptionList.isEmpty)
                                                        ? '0.500'
                                                        : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                        ? '0.000'
                                                        : deleveryValue ?? '1.00'))))
                                                .toStringAsFixed(3)
                                                : FinalPrice.toStringAsFixed(3),


                                            merchantId: "your_actual_google_merchant_id",
                                            merchantName: "Test Vendor",
                                            countryCode: MFCountry.KUWAIT,
                                            currencyIso: MFCurrencyISO.KUWAIT_KWD,
                                          );

                                          try {
                                            await MFSDK.setupGooglePayHelper(sesionGoogle!, googlePayRequest, (invoiceId) {
                                              if (invoiceId != null) {
                                                log("-----------Invoice Id: $invoiceId------------");

                                                // Call your orderItemFun after successful payment
                                                if (UserPhone != null) {
                                                  orderItemFun.orderItemFu(
                                                    DistriictName: listAddressUser.dataAddressList[selectAddress]["RegionName"],
                                                    context: context,
                                                    regionName:listAddressUser.dataAddressList[selectAddress]["DistrictName"],
                                                    OrderDate: DateFormat('yyyy-MM-dd').format(_timeData).toString(),
                                                    CustomerAddress: listAddressUser.dataAddressList[selectAddress]["CustomerAddress"],
                                                    CustomerPhone: listAddressUser.dataAddressList[selectAddress]["CustomerPhone"],
                                                    CustomerName: listAddressUser.dataAddressList[selectAddress]["ArabicName"],
                                                    Block: listAddressUser.dataAddressList[selectAddress]["Block"],
                                                    Street: listAddressUser.dataAddressList[selectAddress]["StreetName"],
                                                    House: listAddressUser.dataAddressList[selectAddress]["HouseNo"],
                                                    DiscountCode: discountValueControllerCheckOutOnSystem.text,
                                                    Gada: listAddressUser.dataAddressList[selectAddress]["Gada"],
                                                    Floor: listAddressUser.dataAddressList[selectAddress]["Floor"],
                                                    Apartment: listAddressUser.dataAddressList[selectAddress]["Apartment"],
                                                    Email: listAddressUser.dataAddressList[selectAddress]["Email"],
                                                    DeliveryID: DeliveryId,
                                                    Details: widget.titleNotes,
                                                    DeliveryDate: todayDate,
                                                    DeliveryDay: todayName,
                                                    OrderTime: selectedTime,
                                                    TotalValue: totalPrice,
                                                    Additions:totalPrice >= 20?0: (UserPhone == null) ? widget.DeliveryValue :
                                                    (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true) ? 0.000 : deleveryValue ?? 1,
                                                    Discount: widget.discountValue,
                                                    FinalValue: (FinalPrice == 0.0)
                                                        ? (totalPrice >= 20
                                                        ? totalPrice  // إذا كانت قيمة totalPrice أكبر من أو تساوي 20، لا يتم إضافة رسوم التوصيل
                                                        : (totalPrice +
                                                        double.parse(
                                                            (getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                                                getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                                ? '0.000'
                                                                : deleveryValue ?? '1.00')))
                                                        : FinalPrice,

                                                    DiscountCardValue: 0,
                                                    PayID: 2,
                                                    OnlineStoreId: -1,
                                                    orderList: widget.newmyList,
                                                    Image: listItemOrderImage.orderListImage,
                                                    discountPointsValue: walletPoints.walletPointsList[0]['PointsValue'],
                                                  );
                                                } else {
                                                  orderItemFun.orderItemFu(
                                                    DistriictName: widget.ValueselectedDistrict,
                                                    context: context,
                                                    OrderDate: DateFormat('yyyy-MM-dd').format(_timeData).toString(),
                                                    CustomerPhone: widget.mobileNumberControllerCheckOutOnSystem,
                                                    CustomerName: widget.nameControllerCheckOutOnSystem,
                                                    customerMapAdress: widget.customerAdressMap,
                                                    placeId: widget.placeId,
                                                    regionName: widget.regionName,
                                                    Block: widget.BlockNumberControllerCheckOutOnSystem,
                                                    Street: widget.StreetControllerCheckOutOnSystem,
                                                    House: widget.HouseControllerCheckOutOnSystem,
                                                    Gada: widget.gada,
                                                    Floor: widget.floorControllerCheckOutOnSystem,
                                                    Apartment: widget.apartmentControllerCheckOutOnSystem,
                                                    Email: widget.emailControllerCheckOutOnSystem,
                                                    DeliveryID: DeliveryId,
                                                    DiscountCode: discountValueControllerCheckOutOnSystem.text,
                                                    Details: widget.titleNotes,
                                                    DeliveryDate: todayDate,
                                                    DeliveryDay: todayName,
                                                    OrderTime: selectedTime,
                                                    TotalValue: totalPrice,
                                                    Additions: totalPrice >= 20?0:(UserPhone == null) ? widget.DeliveryValue :
                                                    (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true) ? 0.000 : deleveryValue ?? 1,
                                                    Discount: (widget.discountValue == 0.0) ? widget.DiscountPercent : widget.discountValue,
                                                    FinalValue: (FinalPrice == 0.0)
                                                        ? (totalPrice >= 20
                                                        ? totalPrice  // إذا كانت قيمة totalPrice أكبر من أو تساوي 20، لا يتم إضافة رسوم التوصيل
                                                        : (totalPrice + widget.DeliveryValue))
                                                        : FinalPrice,

                                                    DiscountCardValue: 0,
                                                    PayID: 2,
                                                    OnlineStoreId: -1,
                                                    orderList: widget.newmyList,
                                                    Image: listItemOrderImage.orderListImage,
                                                    CustomerAddress: widget.customerAdressMap, // UPDATED HERE
                                                  );
                                                }
                                              } else {
                                                log("Failed to get invoice ID");
                                              }
                                            }).then((value) => log("Payment successful: $value"))
                                                .catchError((error) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => PaymentErrorPage()),
                                              );
                                              log("Payment failed: ${error.message}");
                                            });
                                          } catch (error) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => PaymentErrorPage()),
                                            );
                                            log("Error occurred: $error");
                                          }
                                        } else {
                                          setState(() {
                                            checkTimeNotFound = false;
                                          });
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              // 50.horizontalSpace,
                                              Radio(
                                                value: 26,
                                                groupValue: selectedOption,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (widget.PaymentMethod == 1 || widget.PaymentMethod == 2 || widget.PaymentMethod == null) {
                                                      selectedOption = value!;
                                                      selectedOptionPaymentId = 26;
                                                    } else {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            content: Text(
                                                              (lang.activeLanguage.languageCode == 'ar')
                                                                  ? 'هذه المنطقه طرق الدفع المتاحه فيها الدفع كاش'
                                                                  : 'This area has cash payment methods available',
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: Text(
                                                                  (lang.activeLanguage.languageCode == 'ar') ? 'موافق' : 'OK',
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                  });
                                                },
                                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                              ),
                                              Text(
                                                (lang.activeLanguage.languageCode == 'ar') ? 'جوجل باى' : 'Google Pay ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp,
                                                  fontFamily: 'Monadi',
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Image.network(
                                            'https://portal.myfatoorah.com/imgs/payment-methods/gp.png',
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.contain,
                                          )
                                        ],
                                      ),
                                    );

                                }
                            ),


                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Divider(
                              thickness: 1,
                              height: 1,
                              color: Colors.black,
                              endIndent: 10,
                              indent: 10,
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //
                          //     Radio(
                          //       value: 10,
                          //       groupValue: selectedOption,
                          //       onChanged: (value) {
                          //         setState(() {
                          //
                          //           selectedOption = value!;
                          //         });
                          //       },
                          //       visualDensity:
                          //       const VisualDensity(horizontal: -4, vertical: -4),
                          //     ),
                          //
                          //     Expanded(
                          //       child: TabbyPresentationSnippet(
                          //         price: (FinalPrice == 0.0)
                          //             ? ' ${(totalPrice >= 20
                          //             ? totalPrice // إذا كانت قيمة totalPrice أكبر من أو تساوي 20، لا يتم إضافة رسوم التوصيل
                          //             : (totalPrice +
                          //             ((UserPhone == null)
                          //                 ? widget.DeliveryValue
                          //                 : double.parse(
                          //                 (getSubscriptionDelivery.subscriptionList.isEmpty)
                          //                     ? '0.500'
                          //                     : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                          //                     ? '0.000'
                          //                     : deleveryValue ?? '0.500'))))
                          //             .toStringAsFixed(3)} '
                          //             : ' ${(FinalPrice).toStringAsFixed(3)} ',
                          //
                          //         currency: Currency.kwd,
                          //         lang:(lang.activeLanguage.languageCode=='ar')? Lang.ar:Lang.en,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 8),
                          //   child: Divider(
                          //     thickness: 1,
                          //     height: 1,
                          //     color: Colors.black,
                          //     endIndent: 10,
                          //     indent: 10,
                          //   ),
                          // ),
                        ],
                      ),




                    13.verticalSpace,
                    Row(
                      children: [
                        Text(
                            (lang.activeLanguage.languageCode == 'ar')
                                ? 'المجموع الفرعى'
                                : 'Total Price',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),
                        const Spacer(),
                        Row(
                          children: [
                            Text(' ${totalPrice.toStringAsFixed(3)} ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.sp,
                                  fontFamily: 'Monadi',
                                  color: AppColors.black,
                                )),
                            Text(
                                (lang.activeLanguage.languageCode == 'ar')
                                    ? 'د.ك '
                                    : 'K.D',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.sp,
                                  fontFamily: 'Monadi',
                                  color: AppColors.black,
                                )),
                          ],
                        )
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                            (lang.activeLanguage.languageCode == 'ar')
                                ? 'رسوم التوصيل '
                                : 'Delivery Fees',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '${(totalPrice >= 20) ? 0.000 :
                              ((UserPhone == null)
                                  ? widget.DeliveryValue
                                  : (
                                  num.parse(
                                    (
                                        (totalPrice >= 20)
                                            ? 0.toString()
                                            : (
                                            getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                                getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true
                                        )
                                            ? '0.000'
                                            : deleveryValue ?? '1.00'
                                    ),
                                  )
                              ).toStringAsFixed(3)
                              )
                              }',
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 12.sp,
                                fontFamily: 'Monadi',
                                color: AppColors.black,
                              ),
                            ),

                            Text(
                                (lang.activeLanguage.languageCode == 'ar')
                                    ? 'د.ك '
                                    : 'K.D',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.sp,
                                  fontFamily: 'Monadi',
                                  color: AppColors.black,
                                )),
                          ],
                        )
                      ],
                    ),
                    (widget.discountValue != 0.0)
                        ?
                    Row(
                      children: [
                        Text(
                            (lang.activeLanguage.languageCode == 'ar')
                                ? 'الخصم'
                                : 'Discount ',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),
                        const Spacer(),
                        Text(

                            (widget.DiscountPercent != 0)?
                            '${widget.DiscountPercent}':
                            ' ${widget.discountValue.toStringAsFixed(3)} ',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),
                        Text(
                            (widget.DiscountPercent != 0)
                                ? '  %'
                                : (lang.activeLanguage.languageCode == 'ar' ? 'د.ك' : 'K.D'),
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),

                      ],
                    )
                        : Row(
                      children: [
                        Text(
                            (lang.activeLanguage.languageCode == 'ar')
                                ? 'الخصم'
                                : 'Discount',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),
                        const Spacer(),
                        Text(    (widget.DiscountPercent != 0)?
                        '${widget.DiscountPercent}':
                        ' ${widget.discountValue.toStringAsFixed(3)} ',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),
                        Text(
                            (widget.DiscountPercent != 0)
                                ? '  %'
                                : (lang.activeLanguage.languageCode == 'ar' ? 'د.ك' : 'K.D'),
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),

                      ],
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        Text(
                            (lang.activeLanguage.languageCode == 'ar')
                                ? 'المجموع الكلى'
                                : 'Total Amount',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 14.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              ' ${
                                  (FinalPrice == 0.0)
                                      ? (totalPrice +
                                      num.parse(
                                          (totalPrice >= 20
                                              ? '0'
                                              : (getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                              getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                              ? '0.000'
                                              : (deleveryValue != null ? deleveryValue.toString() : '1.00')
                                          )
                                      )
                                  ).toStringAsFixed(3)
                                      : FinalPrice.toStringAsFixed(3)
                              }',
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 14.sp,
                                fontFamily: 'Monadi',
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                                (lang.activeLanguage.languageCode == 'ar')
                                    ? 'د.ك '
                                    : 'K.D',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.sp,
                                  fontFamily: 'Monadi',
                                  color: AppColors.black,
                                )),
                          ],
                        )
                      ],
                    ),








                    80.verticalSpace,

                    (totalPrice + widget.discountValue <=
                        ((UserPhone == null)
                            ? widget.BilleValue
                            : num.parse(BillValue.toString() ?? '3.5')))
                        ? Center(
                      child: Text(
                          (lang.activeLanguage.languageCode == 'ar')
                              ? 'الطلب اقل من ${((UserPhone == null) ? widget
                              .BilleValue.toStringAsFixed(3) : BillValue ??
                              listAddressUser.dataAddressList[0]['BillValue'] ??
                              '')}د.ك'
                              : 'The order value is less ${widget.BilleValue ??
                              ''}k.D ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            fontFamily: 'Monadi',
                            color: Colors.red,
                          )),
                    )
                        : Padding(
                      padding:
                      REdgeInsets.only(left: 16, right: 16, bottom: 36),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final orderItemFun = ref.watch(orderItemProvider);
                          final listItemOrderImage =
                          ref.watch(orderProviderListImage);


                          if(selectedOption==26)
                          {
                            return googlePayButton();

                          }
                          else if(selectedOption==24)
                          { //
                            //TODO : Loading issue here
                            return applePayView();
                          }
                          else
                          {
                            if (selectedOption == 0  )

                            {
                              return
                                MainConfirmButton(
                                    background: Colors.orange,
                                    title: (lang.activeLanguage.languageCode ==
                                        'ar')
                                        ? 'كاش'
                                        : "Cash",
                                    // Replace with your loading state

                                    onTap: () {
                                      if (_formKey.currentState!.validate() &&
                                          selectedCardIndex! >= 0) {
                                        (UserPhone != null)
                                            ? orderItemFun.orderItemFu(
                                          context: context,
                                          OrderDate:
                                          DateFormat('yyyy-MM-dd')
                                              .format(_timeData)
                                              .toString(),
                                          CustomerAddress: listAddressUser
                                              .dataAddressList[
                                          selectAddress]
                                          ["CustomerAddress"],
                                          regionName:listAddressUser
                                              .dataAddressList[
                                          selectAddress]
                                          [
                                          "RegionName"],
                                          CustomerPhone: listAddressUser
                                              .dataAddressList[
                                          selectAddress]
                                          ["CustomerPhone"],
                                          CustomerName: listAddressUser
                                              .dataAddressList[
                                          selectAddress]
                                          ["ArabicName"],
                                          Email: listAddressUser
                                              .dataAddressList[
                                          selectAddress]["Email"],
                                          DeliveryID: DeliveryId,
                                          DiscountCode:
                                          discountValueControllerCheckOutOnSystem
                                              .text,
                                          Details: widget.titleNotes??'',
                                          DeliveryDate: todayDate,
                                          DeliveryDay: todayName,
                                          OrderTime: selectedTime,
                                          TotalValue: totalPrice,
                                          Additions:
                                          (totalPrice >= 20)?0.0:
                                          double.parse(
                                              (getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                                  getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                  ? '0.000'  // إذا كان هناك اشتراك، رسوم التوصيل ستكون 0
                                                  : deleveryValue ?? '1.00'  // إذا لم يكن هناك اشتراك، استخدم قيمة deleveryValue أو 5.000 كقيمة افتراضية
                                          ),

                                          Discount: widget.discountValue,
                                          FinalValue: (FinalPrice == 0.0)
                                              ? (totalPrice >= 20
                                              ? totalPrice + 0.0
                                              : totalPrice + double.parse(
                                              (getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                                  getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                  ? '0.000'  // إذا كان هناك اشتراك، رسوم التوصيل ستكون 0
                                                  : deleveryValue ?? '1.00'  // إذا لم يكن هناك اشتراك، استخدم قيمة deleveryValue أو 5.000 كقيمة افتراضية
                                          )
                                          )
                                              : FinalPrice,

                                          DiscountCardValue: 0,
                                          PayID: selectedOption,
                                          OnlineStoreId: -1,
                                          orderList: widget.newmyList,
                                          Image: listItemOrderImage
                                              .orderListImage,
                                          customerMapAdress:
                                          listAddressUser
                                              .dataAddressList[
                                          selectAddress]
                                          ["MapCustomerAddress"],
                                          placeId: listAddressUser
                                              .dataAddressList[
                                          selectAddress]
                                          ["MapPlaceID"],
                                          discountPointsValue: walletPoints.walletPointsList.isNotEmpty
                                              ? walletPoints.walletPointsList[0]['PointsValue']
                                              : 0.0,
                                        )
                                            : orderItemFun.orderItemFu(
                                          DistriictName: widget
                                              .ValueselectedDistrict,
                                          regionName:widget.regionName,
                                          context: context,
                                          OrderDate:
                                          DateFormat('yyyy-MM-dd')
                                              .format(_timeData)
                                              .toString(),
                                          CustomerPhone: widget
                                              .mobileNumberControllerCheckOutOnSystem,
                                          CustomerName: widget
                                              .nameControllerCheckOutOnSystem,
                                          Block: widget
                                              .BlockNumberControllerCheckOutOnSystem,
                                          Street: widget
                                              .StreetControllerCheckOutOnSystem,
                                          House: widget
                                              .HouseControllerCheckOutOnSystem,
                                          Gada: widget.gada,
                                          Floor: widget
                                              .floorControllerCheckOutOnSystem,
                                          DiscountCode:
                                          discountValueControllerCheckOutOnSystem
                                              .text,
                                          Apartment: widget
                                              .apartmentControllerCheckOutOnSystem,
                                          Email: widget
                                              .emailControllerCheckOutOnSystem,
                                          DeliveryID: DeliveryId,
                                          Details: widget.titleNotes,
                                          DeliveryDate: todayDate,
                                          DeliveryDay: todayName,
                                          OrderTime: selectedTime,
                                          TotalValue: totalPrice,
                                          Additions:
                                          (totalPrice >= 20)?0.0:

                                          ((UserPhone == null)
                                              ? widget.DeliveryValue
                                              : (getSubscriptionDelivery
                                              .subscriptionList[0]['IsSubscribe'] ==
                                              true) ? '0.000' : deleveryValue ?? 1),
                                          Discount: widget.discountValue,
                                          FinalValue: (FinalPrice == 0.0)
                                              ? (totalPrice >= 20
                                              ? totalPrice + 0.0  // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
                                              : totalPrice + widget.DeliveryValue  // إذا كان totalPrice أقل من 20، أضف رسوم التوصيل
                                          )
                                              : FinalPrice,

                                          DiscountCardValue: 0,
                                          PayID: selectedOption,
                                          OnlineStoreId: -1,
                                          orderList: widget.newmyList,
                                          Image: listItemOrderImage
                                              .orderListImage,
                                          customerMapAdress:
                                          widget.customerAdressMap,
                                          placeId: widget.placeId,
                                        );
                                      }
                                      else {
                                        print('HAAA');
                                        setState(() {
                                          checkTimeNotFound = false;
                                        });
                                      }

                                      print(widget.newmyList);
                                      print(_timeData);
                                      print(selectedTime);
                                      print(dayNameAr!);

                                      print(
                                          'apartment ${widget
                                              .apartmentControllerCheckOutOnSystem}');
                                      print(
                                          'apartment ${widget
                                              .titleNotes}'); //  listItemOrder.clearItems();
                                    });

                            }
                            else if(selectedOption == 10){
                              return MainConfirmButton(
                                  background: Colors.orange,
                                  title: (lang.activeLanguage.languageCode ==
                                      'ar')
                                      ? 'المتابعه'
                                      : "Continue",
                                  // Replace with your loading state

                                  onTap: () async  {
                                    if (_formKey.currentState!.validate()
                                    ) {

                                      final mockPayload = Payment(

                                        amount: (FinalPrice == 0.0)
                                            ? (totalPrice >= 20
                                            ? totalPrice + 0.0  // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
                                            : (totalPrice +
                                            ((UserPhone == null)
                                                ? widget.DeliveryValue
                                                : double.parse(
                                                (getSubscriptionDelivery.subscriptionList.isEmpty)
                                                    ? '0.000'
                                                    : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                    ? '0.000'
                                                    : deleveryValue ?? '1.00')
                                            )
                                        )
                                        ).toStringAsFixed(3)
                                            : FinalPrice.toStringAsFixed(3),

                                        currency: Currency.kwd,
                                        buyer: Buyer(
                                          email: (UserPhone != null)
                                              ? listAddressUser.dataAddressList[selectAddress]["Email"]
                                              : widget.emailControllerCheckOutOnSystem,
                                          phone: (UserPhone != null)
                                              ? listAddressUser.dataAddressList[selectAddress]["CustomerPhone"]
                                              : widget.mobileNumberControllerCheckOutOnSystem,
                                          name: (UserPhone != null)
                                              ? listAddressUser.dataAddressList[selectAddress]["ArabicName"]
                                              : widget.nameControllerCheckOutOnSystem,
                                          dob: '1990-01-01',
                                        ),
                                        buyerHistory: BuyerHistory(
                                          loyaltyLevel: 0,
                                          registeredSince: '2019-08-24T14:15:22Z',
                                          wishlistCount: 0,
                                        ),
                                        shippingAddress: const ShippingAddress(
                                          city: 'string',
                                          address: 'string',
                                          zip: 'string',
                                        ),
                                        order: Order(referenceId: uniqueReferenceId, items: [
                                          OrderItem(
                                            title: 'Jersey',
                                            description: 'Jersey',
                                            quantity: 1,
                                            unitPrice: '10.00',
                                            referenceId: 'uuid',
                                            productUrl: 'http://example.com',
                                            category: 'clothes',
                                          )
                                        ]),
                                        orderHistory: [
                                          tabby.OrderHistoryItem(
                                            purchasedAt: '2019-08-24T14:15:22Z',
                                            amount: (FinalPrice == 0.0)
                                                ? (totalPrice >= 20
                                                ? totalPrice + 0.0  // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
                                                : (totalPrice +
                                                ((UserPhone == null)
                                                    ? widget.DeliveryValue
                                                    : double.parse(
                                                    (getSubscriptionDelivery.subscriptionList.isEmpty)
                                                        ? '0.000'
                                                        : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                        ? '0.000'
                                                        : deleveryValue ?? '1.00')
                                                )
                                            )
                                            ).toStringAsFixed(3)
                                                : FinalPrice.toStringAsFixed(3),

                                            paymentMethod: OrderHistoryItemPaymentMethod.card,
                                            status: OrderHistoryItemStatus.newOne,
                                          )
                                        ],
                                      );

                                      try {
                                        session = await TabbySDK().createSession(TabbyCheckoutPayload(
                                          merchantCode: 'Tmwenat appkwt',
                                          lang: Lang.en,

                                          payment: mockPayload,
                                        ));
                                        setState(() {
                                          if (session != null &&
                                              session!.availableProducts.installments != null &&
                                              session!.availableProducts.installments!.webUrl != null) {
                                            TabbyWebView.showWebView(
                                              context: context,
                                              webUrl: session!.availableProducts.installments!.webUrl,
                                              onResult: (WebViewResult resultCode) {
                                                print('Result Code: ${resultCode.name}');

                                                if (resultCode.name == 'authorized') {
                                                  (UserPhone != null)
                                                      ? orderItemFun
                                                      .orderItemFu(
                                                      DistriictName: listAddressUser
                                                          .dataAddressList[
                                                      selectAddress]
                                                      [
                                                      "DistrictName"],
                                                      context: context,
                                                      OrderDate: DateFormat(
                                                          'yyyy-MM-dd')
                                                          .format(
                                                          _timeData)
                                                          .toString(),
                                                      CustomerAddress:
                                                      listAddressUser
                                                          .dataAddressList[
                                                      selectAddress]
                                                      [
                                                      "CustomerAddress"],
                                                      regionName:
                                                      listAddressUser
                                                          .dataAddressList[
                                                      selectAddress]
                                                      [
                                                      "RegionName"],


                                                      CustomerPhone: listAddressUser
                                                          .dataAddressList[
                                                      selectAddress]
                                                      [
                                                      "CustomerPhone"],
                                                      CustomerName: listAddressUser
                                                          .dataAddressList[
                                                      selectAddress]
                                                      [
                                                      "ArabicName"],
                                                      Block: listAddressUser
                                                          .dataAddressList[
                                                      selectAddress]
                                                      ["Block"],
                                                      Street: listAddressUser
                                                          .dataAddressList[
                                                      selectAddress]
                                                      [
                                                      "StreetName"],
                                                      House: listAddressUser
                                                          .dataAddressList[
                                                      selectAddress]
                                                      ["HouseNo"],
                                                      DiscountCode:
                                                      discountValueControllerCheckOutOnSystem
                                                          .text,
                                                      Gada: listAddressUser
                                                          .dataAddressList[
                                                      selectAddress]
                                                      ["Gada"],
                                                      Floor: listAddressUser
                                                          .dataAddressList[
                                                      selectAddress]
                                                      ["Floor"],
                                                      Apartment: listAddressUser
                                                          .dataAddressList[
                                                      selectAddress]
                                                      ["Apartment"],
                                                      Email: listAddressUser
                                                          .dataAddressList[
                                                      selectAddress]
                                                      ["Email"],
                                                      DeliveryID:
                                                      DeliveryId,
                                                      Details: widget
                                                          .titleNotes,
                                                      DeliveryDate:
                                                      todayDate,
                                                      DeliveryDay:
                                                      todayName,
                                                      OrderTime:
                                                      selectedTime,
                                                      TotalValue:
                                                      totalPrice,
                                                      Additions:
                                                      (totalPrice >= 20)?0.0:
                                                      ((UserPhone ==
                                                          null)
                                                          ? widget
                                                          .DeliveryValue
                                                          : (getSubscriptionDelivery
                                                          .subscriptionList[0]['IsSubscribe'] ==
                                                          true) ? 0.000 : deleveryValue ??
                                                          1),
                                                      Discount: widget
                                                          .discountValue,
                                                      FinalValue: (FinalPrice == 0.0)
                                                          ? (totalPrice >= 20
                                                          ? totalPrice + 0.0  // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
                                                          : (totalPrice +
                                                          double.parse(
                                                              (getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                                                  getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                                  ? '0.000'  // إذا كان هناك اشتراك، رسوم التوصيل صفر
                                                                  : deleveryValue ?? '1.00'  // إذا لم يكن هناك اشتراك، استخدم قيمة رسوم التوصيل الافتراضية
                                                          )
                                                      )
                                                      )
                                                          : FinalPrice,  // إذا كانت قيمة FinalPrice ليست صفرًا، استخدمها كما هي

                                                      DiscountCardValue:
                                                      0,
                                                      PayID: 2,
                                                      OnlineStoreId: -1,
                                                      orderList: widget
                                                          .newmyList,
                                                      Image: listItemOrderImage
                                                          .orderListImage,
                                                      discountPointsValue: walletPoints
                                                          .walletPointsList[0]['PointsValue']
                                                  )
                                                      : orderItemFun.orderItemFu(
                                                      DistriictName: widget
                                                          .ValueselectedDistrict,  regionName:widget.regionName,
                                                      context: context,
                                                      OrderDate: DateFormat('yyyy-MM-dd')
                                                          .format(
                                                          _timeData)
                                                          .toString(),
                                                      CustomerPhone: widget
                                                          .mobileNumberControllerCheckOutOnSystem,
                                                      CustomerName: widget
                                                          .nameControllerCheckOutOnSystem,
                                                      customerMapAdress:
                                                      widget
                                                          .customerAdressMap,
                                                      placeId: widget
                                                          .placeId,
                                                      Block: widget
                                                          .BlockNumberControllerCheckOutOnSystem,
                                                      Street: widget
                                                          .StreetControllerCheckOutOnSystem,
                                                      House: widget
                                                          .HouseControllerCheckOutOnSystem,
                                                      Gada: widget.gada,
                                                      Floor: widget
                                                          .floorControllerCheckOutOnSystem,
                                                      Apartment: widget
                                                          .apartmentControllerCheckOutOnSystem,
                                                      Email: widget
                                                          .emailControllerCheckOutOnSystem,
                                                      DeliveryID:
                                                      DeliveryId,
                                                      DiscountCode:
                                                      discountValueControllerCheckOutOnSystem
                                                          .text,
                                                      Details: widget
                                                          .titleNotes,
                                                      DeliveryDate:
                                                      todayDate,
                                                      DeliveryDay:
                                                      todayName,
                                                      OrderTime:
                                                      selectedTime,
                                                      TotalValue:
                                                      totalPrice,
                                                      Additions:
                                                      (totalPrice >= 20)?0.0:((UserPhone == null)
                                                          ? widget
                                                          .DeliveryValue
                                                          : (getSubscriptionDelivery
                                                          .subscriptionList[0]['IsSubscribe'] ==
                                                          true) ? 0.000 : deleveryValue ??
                                                          1),
                                                      Discount: (widget.discountValue ==
                                                          0.0)
                                                          ? widget.DiscountPercent
                                                          : widget.discountValue,
                                                      FinalValue: (FinalPrice == 0.0)
                                                          ? (totalPrice >= 20
                                                          ? totalPrice + 0.0  // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
                                                          : (totalPrice + widget.DeliveryValue)
                                                      )
                                                          : FinalPrice,  // إذا كانت قيمة FinalPrice ليست صفرًا، استخدمها كما هي

                                                      DiscountCardValue: 0,
                                                      PayID: 2,
                                                      OnlineStoreId: -1,
                                                      orderList: widget.newmyList,
                                                      Image: listItemOrderImage
                                                          .orderListImage,
                                                      CustomerAddress: widget
                                                          .customerAdressMap // UPDATED HERE
                                                  );
                                                } else if (resultCode.name == 'rejected' || resultCode.name == 'expired' || resultCode.name == 'close') {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PaymentErrorPage(),
                                                    ),
                                                  );
                                                  // هنا يمكنك عرض رسالة خطأ أو اتخاذ إجراء آخر مثل إعادة المحاولة
                                                } else {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PaymentErrorPage(),
                                                    ),
                                                  );
                                                }

                                              },
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentErrorPage(),
                                              ),
                                            );
                                            print('Session not initialized or no web URL found');
                                          }
                                        });
                                      } catch (e) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PaymentErrorPage(),
                                          ),
                                        );
                                        print('Error creating session: $e');
                                      }



                                    }
                                  });
                            }
                            else
                            {   return  MainConfirmButton(
                                background: Colors.orange,
                                title: (lang.activeLanguage.languageCode == 'ar') ? ' ادفع' : 'Pay',
                                onTap: () async {
                                  if (_formKey.currentState!.validate() && selectedCardIndex! >= 0) {







                                    var request = MFExecutePaymentRequest(
                                      customerName: (UserPhone != null)
                                          ? listAddressUser.dataAddressList[selectAddress]["ArabicName"]
                                          : widget.nameControllerCheckOutOnSystem,
                                      customerMobile: (UserPhone != null)
                                          ? listAddressUser.dataAddressList[selectAddress]["CustomerPhone"]
                                          : widget.mobileNumberControllerCheckOutOnSystem,
                                      paymentMethodId: selectedOptionPaymentId,
                                      invoiceValue: double.parse(
                                        (FinalPrice == 0.0)
                                            ? (totalPrice >= 20
                                            ? totalPrice.toStringAsFixed(3)
                                            : (totalPrice + ((UserPhone == null)
                                            ? widget.DeliveryValue
                                            : double.parse(
                                            (getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                                getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                ? '0.000'
                                                : deleveryValue ?? '1.00'))
                                        ).toStringAsFixed(3))
                                            : FinalPrice.toStringAsFixed(3),
                                      ),
                                    );
                                    request.displayCurrencyIso = MFCurrencyISO.KUWAIT_KWD;

                                    await MFSDK.executePayment(
                                        request, MFLanguage.ARABIC, (invoiceId) {
                                      log(invoiceId);
                                      setState(() {
                                        paymentSuccess = true;
                                      });
                                    }
                                    ).then((value) {
                                      print('--------------------------------------------------------');

                                      log(value);
                                      print('-----------------------------------------------------');
                                      print(value.invoiceStatus);
                                      print('-----------------------2222222------------------------------');
                                      try {
                                        (UserPhone != null)
                                            ? orderItemFun.orderItemFu(
                                          context: context,
                                          OrderDate: DateFormat('yyyy-MM-dd').format(_timeData).toString(),
                                          CustomerAddress: listAddressUser.dataAddressList[selectAddress]["CustomerAddress"],
                                          regionName: listAddressUser.dataAddressList[selectAddress]["RegionName"],
                                          CustomerPhone: listAddressUser.dataAddressList[selectAddress]["CustomerPhone"],
                                          CustomerName: listAddressUser.dataAddressList[selectAddress]["ArabicName"],
                                          Email: listAddressUser.dataAddressList[selectAddress]["Email"],
                                          DeliveryID: DeliveryId,
                                          DiscountCode: discountValueControllerCheckOutOnSystem.text,
                                          Details: widget.titleNotes ?? '',
                                          DeliveryDate: todayDate,
                                          DeliveryDay: todayName,
                                          OrderTime: selectedTime,
                                          TotalValue: totalPrice,
                                          Additions: (totalPrice >= 20)
                                              ? 0.0
                                              : double.tryParse(
                                              (getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                                  getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                  ? '0.000'
                                                  : deleveryValue ?? '1.00') ??
                                              1.00,
                                          Discount: widget.discountValue,
                                          FinalValue: (FinalPrice == 0.0)
                                              ? (totalPrice >= 20
                                              ? totalPrice
                                              : totalPrice + (double.tryParse(
                                              (getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                                  getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                  ? '0.000'
                                                  : deleveryValue ?? '1.00') ??
                                              1.00))
                                              : FinalPrice,
                                          DiscountCardValue: 0,
                                          PayID: 2,
                                          OnlineStoreId: -1,
                                          orderList: widget.newmyList,
                                          Image: listItemOrderImage.orderListImage,
                                          discountPointsValue: walletPoints.walletPointsList.isNotEmpty
                                              ? walletPoints.walletPointsList[0]['PointsValue']
                                              : 0,
                                        )
                                            : orderItemFun.orderItemFu(
                                          DistriictName: widget.ValueselectedDistrict,
                                          regionName: widget.regionName,
                                          context: context,
                                          OrderDate: DateFormat('yyyy-MM-dd').format(_timeData).toString(),
                                          CustomerPhone: widget.mobileNumberControllerCheckOutOnSystem,
                                          CustomerName: widget.nameControllerCheckOutOnSystem,
                                          customerMapAdress: widget.customerAdressMap,
                                          placeId: widget.placeId,
                                          Block: widget.BlockNumberControllerCheckOutOnSystem,
                                          Street: widget.StreetControllerCheckOutOnSystem,
                                          House: widget.HouseControllerCheckOutOnSystem,
                                          Gada: widget.gada,
                                          Floor: widget.floorControllerCheckOutOnSystem,
                                          Apartment: widget.apartmentControllerCheckOutOnSystem,
                                          Email: widget.emailControllerCheckOutOnSystem,
                                          DeliveryID: DeliveryId,
                                          DiscountCode: discountValueControllerCheckOutOnSystem.text,
                                          Details: widget.titleNotes,
                                          DeliveryDate: todayDate,
                                          DeliveryDay: todayName,
                                          OrderTime: selectedTime,
                                          TotalValue: totalPrice,
                                          Additions: (totalPrice >= 20)
                                              ? 0.0
                                              : ((UserPhone == null)
                                              ? widget.DeliveryValue
                                              : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                              ? 0.0
                                              : double.tryParse(deleveryValue ?? '1.00') ?? 1.00),
                                          Discount: (widget.discountValue == 0.0) ? widget.DiscountPercent : widget.discountValue,
                                          FinalValue: (FinalPrice == 0.0)
                                              ? (totalPrice >= 20 ? totalPrice : (totalPrice + widget.DeliveryValue))
                                              : FinalPrice,
                                          DiscountCardValue: 0,
                                          PayID: 2,
                                          OnlineStoreId: -1,
                                          orderList: widget.newmyList,
                                          Image: listItemOrderImage.orderListImage,
                                          CustomerAddress: widget.customerAdressMap,
                                        );
                                      }  catch (e, stackTrace) {
                                        log("⚠️ حدث خطأ: $e");
                                        log("🔍 تتبع الخطأ: $stackTrace");
                                        print('********************************************************');
                                        log('Error inside then block: \$e');
                                        print('*********************************************///');

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PaymentSuccessButOrderFailedScreen(
                                              sendOrderAgain: (){

                                                (UserPhone != null)
                                                    ? orderItemFun.orderItemFu(
                                                  context: context,
                                                  OrderDate: DateFormat('yyyy-MM-dd').format(_timeData).toString(),
                                                  CustomerAddress: listAddressUser.dataAddressList[selectAddress]["CustomerAddress"],
                                                  regionName: listAddressUser.dataAddressList[selectAddress]["RegionName"],
                                                  CustomerPhone: listAddressUser.dataAddressList[selectAddress]["CustomerPhone"],
                                                  CustomerName: listAddressUser.dataAddressList[selectAddress]["ArabicName"],
                                                  Email: listAddressUser.dataAddressList[selectAddress]["Email"],
                                                  DeliveryID: DeliveryId,
                                                  DiscountCode: discountValueControllerCheckOutOnSystem.text,
                                                  Details: widget.titleNotes ?? '',
                                                  DeliveryDate: todayDate,
                                                  DeliveryDay: todayName,
                                                  OrderTime: selectedTime,
                                                  TotalValue: totalPrice,
                                                  Additions: (totalPrice >= 20)
                                                      ? 0.0
                                                      : double.tryParse(
                                                      (getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                                          getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                          ? '0.000'
                                                          : deleveryValue ?? '1.00') ??
                                                      1.00,
                                                  Discount: widget.discountValue,
                                                  FinalValue: (FinalPrice == 0.0)
                                                      ? (totalPrice >= 20
                                                      ? totalPrice
                                                      : totalPrice + (double.tryParse(
                                                      (getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                                          getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                          ? '0.000'
                                                          : deleveryValue ?? '1.00') ??
                                                      1.00))
                                                      : FinalPrice,
                                                  DiscountCardValue: 0,
                                                  PayID: 2,
                                                  OnlineStoreId: -1,
                                                  orderList: widget.newmyList,
                                                  Image: listItemOrderImage.orderListImage,
                                                  discountPointsValue: walletPoints.walletPointsList.isNotEmpty
                                                      ? walletPoints.walletPointsList[0]['PointsValue']
                                                      : 0,
                                                )
                                                    : orderItemFun.orderItemFu(
                                                  DistriictName: widget.ValueselectedDistrict,
                                                  regionName: widget.regionName,
                                                  context: context,
                                                  OrderDate: DateFormat('yyyy-MM-dd').format(_timeData).toString(),
                                                  CustomerPhone: widget.mobileNumberControllerCheckOutOnSystem,
                                                  CustomerName: widget.nameControllerCheckOutOnSystem,
                                                  customerMapAdress: widget.customerAdressMap,
                                                  placeId: widget.placeId,
                                                  Block: widget.BlockNumberControllerCheckOutOnSystem,
                                                  Street: widget.StreetControllerCheckOutOnSystem,
                                                  House: widget.HouseControllerCheckOutOnSystem,
                                                  Gada: widget.gada,
                                                  Floor: widget.floorControllerCheckOutOnSystem,
                                                  Apartment: widget.apartmentControllerCheckOutOnSystem,
                                                  Email: widget.emailControllerCheckOutOnSystem,
                                                  DeliveryID: DeliveryId,
                                                  DiscountCode: discountValueControllerCheckOutOnSystem.text,
                                                  Details: widget.titleNotes,
                                                  DeliveryDate: todayDate,
                                                  DeliveryDay: todayName,
                                                  OrderTime: selectedTime,
                                                  TotalValue: totalPrice,
                                                  Additions: (totalPrice >= 20)
                                                      ? 0.0
                                                      : ((UserPhone == null)
                                                      ? widget.DeliveryValue
                                                      : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                                      ? 0.0
                                                      : double.tryParse(deleveryValue ?? '1.00') ?? 1.00),
                                                  Discount: (widget.discountValue == 0.0) ? widget.DiscountPercent : widget.discountValue,
                                                  FinalValue: (FinalPrice == 0.0)
                                                      ? (totalPrice >= 20 ? totalPrice : (totalPrice + widget.DeliveryValue))
                                                      : FinalPrice,
                                                  DiscountCardValue: 0,
                                                  PayID: 2,
                                                  OnlineStoreId: -1,
                                                  orderList: widget.newmyList,
                                                  Image: listItemOrderImage.orderListImage,
                                                  CustomerAddress: widget.customerAdressMap,
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    }).catchError((error) {
                                      log(error);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PaymentErrorPage(

                                          ),
                                        ),
                                      );
                                    }





                                    );
                                  }


                                  else {
                                    setState(() {
                                      checkTimeNotFound = false;
                                    });
                                  }
                                }
                            );

                            }
                          }



                        },
                      ),
                    ),


                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget googlePayButton() {
    return SizedBox(
      height: 70,
      child: mfGooglePayButton,
    );
  }
  Widget applePayView() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: mfApplePayButton,
        ),
      ],
    );
  }
}



class PaymentErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('عملية لم تنجح',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Monadi',
                fontSize: 16,
              )),
          20.verticalSpace,
          Image.asset(width: 60, 'assets/images/all/paymentField.jpg'),
          20.verticalSpace,
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  const Text('لقد تم رفض العمليه ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Monadi',
                      )),
                  5.verticalSpace,
                  const Text('ليست ناجحه',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontFamily: 'Monadi',
                      )),
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.orange,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: const Center(
                      child: Text(
                        'العودة الى تنفيذ الطلب',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                            color: Colors.white),
                      )),
                ),
              ],
            ),
          )),
    );
  }
}

class PaymentSuccessPage extends StatelessWidget {
  final Widget colum1;

  const PaymentSuccessPage({required this.colum1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: colum1);
  }
}


class PaymentSuccessButOrderFailedScreen extends StatelessWidget {
  final VoidCallback sendOrderAgain;

  const PaymentSuccessButOrderFailedScreen({Key? key, required this.sendOrderAgain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'تم الدفع بنجاح',
            style: TextStyle(
              color: Colors.green,
              fontFamily: 'Monadi',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          20.verticalSpace,

          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'لكن حدث خطأ أثناء إرسال الطلب!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Monadi',
                    ),
                  ),
                  5.verticalSpace,
                  const Text(
                    'يرجى المحاولة مرة أخرى',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'Monadi',
                    ),
                  ),
                  20.verticalSpace,
                  InkWell(
                    onTap: sendOrderAgain,
                    child: Container(
                      height: 40.h,
                      margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'إعادة المحاولة',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}





import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';
import 'dart:convert';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/payment_page_success.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/check_out_app_bar.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/google_apple_pay_pay.dart';
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

// ignore: must_be_immutable
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
  int selectedOptionPaymentId = 4;
  int selectAddress = 0;
  double totalPrice = 0.0;
  // ignore: non_constant_identifier_names
  double FinalPrice = 0.0;
  double roundedFinalPrice = 0.0;
  List<int> itemQuantities = [];
  int isTodayActive = 1;
  int checkDiscount = 1;
   int? DeliveryId;
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
  late MFApplePayButton mfApplePayButton;
  bool checkTimeNotFound = true;

  //----------------- End Payment----------
  String todayName = DateFormat.EEEE().format(DateTime.now());
  String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime today = DateTime.now();
  DateTime tomorrow = DateTime.now().add(Duration(days: 1));
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
    });

    if (paymentSuccess) {
      displayPaymentSuccessPage();
    } else {
      displayPaymentFailurePage();
    }

    MFExecutePaymentRequest executePaymentRequest =
        MFExecutePaymentRequest(invoiceValue: double.parse(amount));
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
        .then((value) => {
              log(value),
              paymentMethods.addAll(value.paymentMethods!),
              for (int i = 0; i < paymentMethods.length; i++)
                isSelected.add(false)
            })
        .catchError((error) => {log(error.message)});
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

  String? sesionGoogle;
  initiateSessionForGooglePay() async {
    MFInitiateSessionRequest initiateSessionRequest =
        MFInitiateSessionRequest(customerIdentifier: "12332212");

    await MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
        .then((value) => {sesionGoogle = value.sessionId})
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
        .then((value) => loadEmbeddedPayment(value))
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
        MFExecutePaymentRequest(invoiceValue: 10  );
    executePaymentRequest.displayCurrencyIso = MFCurrencyISO.KUWAIT_KWD;
    await loadCardView(session);

    sessionApple = session;
    if (Platform.isIOS) {
      applePayPayment(session);
    }
  }

  applePayPayment(MFInitiateSessionResponse session) async {

    MFExecutePaymentRequest executePaymentRequest =
        MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.displayCurrencyIso = MFCurrencyISO.KUWAIT_KWD;

    await mfApplePayButton
        .displayApplePayButton(
            session, executePaymentRequest, MFLanguage.ENGLISH)
        .then((value) => {
              mfApplePayButton
                  .executeApplePayButton(
                      null, (invoiceId) => {debugPrint(invoiceId)})
                  .then((value) => {debugPrint(value.toString())})
                  .catchError((error) => {debugPrint(error.message)})
            })
        .catchError((error) {
      {
        debugPrint(error.message);
        log("____Error______");
        log(error);
      }
    });
  }

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
    ref.read(getAddressFromApiProvider).dataAddressList;
    ref.read(getAddressFromApiProvider);
    ref.read(getDataTimeDeliveryProvider);
    ref.read(getDataTimeDeliveryTomorowProvider);
    ref.read(getDataTimeDeliverynowProvider).getDataTimeDeliverynow();

    mfApplePayButton = MFApplePayButton();

    print(
        '*----------------------------------------------------------------------*');
// deleveryValue=ref
//     .read(getAddressFromApiProvider)
//     .dataAddressList[0]['deleveryValue'];
// print(ref.read(getAddressFromApiProvider).dataAddressList[0]['deleveryValue']);
    print(
        '*--------------------------------------------------------------------------------');
  }

  double calculateTotalPrice(List<Map<String, dynamic>> items) {
    double total = 0.0;

    for (var item in items) {
      if (item.containsKey('Quantity') && item.containsKey('Price')) {
        num quantity;
        if (item['RequiredQTY'] > 0.0 &&
            item['GiftQTY'] > 0.0 &&
            item['Quantity'] >= item['RequiredQTY']) {
          quantity = item['Quantity'] - item['Y_Gift_Qty'];
        } else {
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

 
  String titleAddress = "";
  String selcetoption = "1";

  @override
  Widget build(BuildContext context) {
    mfGooglePayButton = MFGooglePayButton();
    mfApplePayButton = MFApplePayButton(applePayStyle: MFApplePayStyle());
    final getSubscriptionDelivery = ref.watch(getSubscriptionProvider);
    final lang = ref.watch(appModelProvider);
    final listAddressUser = ref.watch(getAddressFromApiProvider);
     final orderItemFun = ref.watch(orderItemProvider);
       
    final listitemorder = ref.watch(orderProviderList);
    final listItemOrderImage = ref.watch(orderProviderListImage);
    final walletPoints = ref.watch(walletPointsProvider);
    BillValue = (listAddressUser.dataAddressList.isEmpty)
        ? 8
        : listAddressUser.dataAddressList[listAddressUser.SelectIndexAddress]
                ["BillValue"] ??
            8;

    deleveryValue = (listAddressUser.dataAddressList.isEmpty)
        ? 1
        : listAddressUser.dataAddressList[listAddressUser.SelectIndexAddress]
                ["DeliveryValue"] ??
            1.toString();

    var uuid = Uuid();
    String uniqueReferenceId = uuid.v4();
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: AppColors.mainBackground(),
        extendBody: true,
        appBar:checkout_system_app_bar(
          context: context,
          ref: ref,
          BillValue: BillValue,
          selectAddress: listAddressUser.SelectIndexAddress,
          deleveryValue: deleveryValue,
          paymentMethod:  int.parse(listAddressUser.dataAddressList[selectAddress]
                                                                              [
                                                                              "PaymentMethod"]) ??2,
          valueselectedDistrict:  widget.ValueselectedDistrict,
          lang: lang,
          listAddressUser: listAddressUser,
        )

      ,  body:   SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:                          
 Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
               //now deliverytime
                item1(lang),
                item2(lang),
                selcetoption == "1"
                    ? item3(lang)
                    : const SizedBox(),
                if (checkTimeNotFound == false)
                  Center(
                      child: Text(
                    (lang.activeLanguage.languageCode == 'ar')
                        ? 'يرجى اختيار وقت التوصيل '
                        : 'Please Choose Delivery Time',
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Colors.red,
                    ),
                  )),
                15.verticalSpace,
                15.verticalSpace,
                divider(),
                15.verticalSpace,
                item4(lang),
                10.verticalSpace,
                /// UserPhone item
                payUsingWallet(lang, listAddressUser, walletPoints),
                13.verticalSpace,
                 divider(),
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
           
                // if (widget.PaymentMethod != 1)
                //   item6(context, lang),
              
                if (widget.PaymentMethod != 0)
                  paymentwaySelection(context, lang, getSubscriptionDelivery, listAddressUser, walletPoints),
                13.verticalSpace,
             item8(lang, getSubscriptionDelivery),
            
                (widget.discountValue != 0.0)
                    ? item9(lang)
                    : item10(lang),
               
                5.verticalSpace,
                item11(lang, getSubscriptionDelivery),
                80.verticalSpace,

                (totalPrice + widget.discountValue <=
                        ((UserPhone == null)
                            ? widget.BilleValue
                            : num.parse(BillValue.toString() ?? '3.5')))
                    ? item12(lang, listAddressUser)
                    : paymentSelectionType(lang, listAddressUser, getSubscriptionDelivery, walletPoints, uniqueReferenceId),
             
              ],
            ),
          ),
        )),
      ),
    );
  }

  Padding paymentSelectionType(AppModel lang, GetDataAddressFromApi listAddressUser, GetSubscriptionProviderApi getSubscriptionDelivery, WalletPoints walletPoints, String uniqueReferenceId) {
    return Padding(
                      padding:
                          REdgeInsets.only(left: 16, right: 16, bottom: 36),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final orderItemFun = ref.watch(orderItemProvider);
                          final listItemOrderImage =
                              ref.watch(orderProviderListImage);

  if (selectedOption == 3 && DeliveryId != null
                        ) {
                        
                              return GoogleApplePayPay(
                                    onError: (p0) {
                                  navigate_faild_payment(context);
                              },onPaymentResult: (p0) {
                                
                                      if (_formKey.currentState!.validate() )
      
 create_order(orderItemFun, context, listAddressUser, getSubscriptionDelivery, listItemOrderImage, walletPoints);
 
                              },
    paymentItems: getPaymentItems(
    totalPrice,
    FinalPrice,
    DeliveryValue,
    widget.discountValue,
  ),
  totalAmount: FinalPrice.toStringAsFixed(3));
                        
                          }else if (selectedOption == 0) {

                              return MainConfirmButton(
                                  background: Colors.orange,
                                  title: (lang.activeLanguage.languageCode ==
                                          'ar')
                                      ? 'كاش'
                                      : "Cash",
                                  // Replace with your loading state

                                  onTap: () {
                                   
                         

                                      if (_formKey.currentState!.validate() ) {

                                     if( selectedCardIndex! < 0){
                                Fluttertoast.showToast(msg: "برجاء اختيار موعد الاستلام");
                                     }else{

                                     cash_payment_method(orderItemFun, context, listAddressUser, getSubscriptionDelivery, listItemOrderImage, walletPoints);
                                     }
                                  
                                  }
                                  });

                            } else if (selectedOption == 4) {
                            
                              return MainConfirmButton(
                                  background: Colors.orange,
                                  title: (lang.activeLanguage.languageCode ==
                                          'ar')
                                      ? 'المتابعه'
                                      : "Continue",
                                  // Replace with your loading state

                                  onTap: () async {
                                                if (_formKey.currentState!.validate() 
    ) {
                                   if( selectedCardIndex! < 0){
                                Fluttertoast.showToast(msg: "برجاء اختيار موعد الاستلام");
                                     }else{

                                    await tabby_payment_method(getSubscriptionDelivery, listAddressUser, uniqueReferenceId, context, orderItemFun, listItemOrderImage, walletPoints);    
                                     }
                                  
                               
                               
                                setState(() {
                                  
                                });
     }
                                  });
                          
                          
                          
                            } else {
                              return MainConfirmButton(
                                  background: Colors.orange,
                                  title: (lang.activeLanguage.languageCode ==
                                          'ar')
                                      ? ' ادفع'
                                      : 'Pay',
                                  onTap: () async {
                                                if (_formKey.currentState!.validate() ) {
                                  
                                      if( selectedCardIndex! < 0){
                                Fluttertoast.showToast(msg: "برجاء اختيار موعد الاستلام");
                                     }else{

                                    await myfatoorah_payment_method(listAddressUser, getSubscriptionDelivery, orderItemFun, context, listItemOrderImage, walletPoints);
                                     }
                                  
                               
     }
                                  });
                           
                            }
                        },
                      ),
                    );
  }
List<PaymentItem> getPaymentItems(double totalPrice, double? FinalPrice, num? deliveryValue, num? discountValue) {
  final List<PaymentItem> items = [];

  items.add(
    PaymentItem(
      label: 'Subtotal',
      amount: totalPrice.toStringAsFixed(3),
      status: PaymentItemStatus.final_price,
    ),
  );

  if ((FinalPrice == 0.0 ? totalPrice < 20 : FinalPrice! < 20)) {
    items.add(
      PaymentItem(
        label: 'Delivery Fee',
        amount: deliveryValue!.toStringAsFixed(3),
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  if (discountValue! > 0) {
    items.add(
      PaymentItem(
        label: 'Discount',
        amount: '-$discountValue',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  // Add Total
  final calculatedTotal = FinalPrice == 0.0
      ? (totalPrice >= 20 ? totalPrice : totalPrice + deliveryValue!)
      : FinalPrice;

  items.add(
    PaymentItem(
      label: 'Total',
      amount: calculatedTotal!.toStringAsFixed(3),
      status: PaymentItemStatus.final_price,
    ),
  );

  return items;
}
  Future<void> myfatoorah_payment_method(GetDataAddressFromApi listAddressUser, GetSubscriptionProviderApi getSubscriptionDelivery, OrderItemFun orderItemFun, BuildContext context, ListItemOrderImage listItemOrderImage, WalletPoints walletPoints) async {
        if (_formKey.currentState!.validate() 
       ) {
        if( selectedCardIndex! < 0){
      var request = MFExecutePaymentRequest(
        customerName: (UserPhone != null)
            ? listAddressUser.dataAddressList[
                selectAddress]["ArabicName"]
            : widget
                .nameControllerCheckOutOnSystem,
        customerMobile: (UserPhone != null)
            ? listAddressUser.dataAddressList[
                    selectAddress]
                ["CustomerPhone"]
            : widget
                .mobileNumberControllerCheckOutOnSystem,
        paymentMethodId:
            selectedOptionPaymentId,
        invoiceValue: double.parse(
          (FinalPrice == 0.0)
              ? (totalPrice >= 20
                  ? totalPrice
                      .toStringAsFixed(3)
                  : (totalPrice +
                          ((UserPhone == null)
                              ? widget
                                  .DeliveryValue
                              : double.parse((getSubscriptionDelivery
                                          .subscriptionList
                                          .isNotEmpty &&
                                      getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] ==
                                          true)
                                  ? '0.000'
                                  : deleveryValue ??
                                      '1.00')))
                      .toStringAsFixed(3))
              : FinalPrice.toStringAsFixed(3),
        ),
      );
      request.displayCurrencyIso =
          MFCurrencyISO.KUWAIT_KWD;
    
      await MFSDK.executePayment(
          request, MFLanguage.ARABIC,
          (invoiceId) {
        log(invoiceId);
        setState(() {
          paymentSuccess = true;
        });
      }).then((value) {
        print(
            '--------------------------------------------------------');
  
        log(value);
        print(
            '-----------------------------------------------------');
        print(value.invoiceStatus);
        print(
            '-----------------------2222222------------------------------');
        try {
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
                  regionName: listAddressUser
                              .dataAddressList[
                          selectAddress]
                      ["RegionName"],
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
                  DeliveryID: DeliveryId!,
                  DiscountCode:
                      discountValueControllerCheckOutOnSystem
                          .text,
                  Details:
                      widget.titleNotes ?? '',
                  DeliveryDate: todayDate,
                  DeliveryDay: todayName,
                  OrderTime: selectedTime,
                  TotalValue: totalPrice,
                  Additions: (totalPrice >=
                          20)
                      ? 0.0
                      : double.tryParse((getSubscriptionDelivery
                                      .subscriptionList
                                      .isNotEmpty &&
                                  getSubscriptionDelivery.subscriptionList[0]
                                          [
                                          'IsSubscribe'] ==
                                      true)
                              ? '0.000'
                              : deleveryValue ??
                                  '1.00') ??
                          1.00,
                  Discount:
                      widget.discountValue,
                  FinalValue: (FinalPrice ==
                          0.0)
                      ? (totalPrice >= 20
                          ? totalPrice
                          : totalPrice +
                              (double.tryParse((getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                          getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] ==
                                              true)
                                      ? '0.000'
                                      : deleveryValue ??
                                          '1.00') ??
                                  1.00))
                      : FinalPrice,
                  DiscountCardValue: 0,
                  PayID: 2,
                  OnlineStoreId: -1,
                  orderList: widget.newmyList,
                  Image: listItemOrderImage
                      .orderListImage,
                  discountPointsValue: walletPoints
                          .walletPointsList
                          .isNotEmpty
                      ? walletPoints
                              .walletPointsList[
                          0]['PointsValue']
                      : 0,
                )
              : orderItemFun.orderItemFu(
                  DistriictName: widget
                      .ValueselectedDistrict,
                  regionName:
                      widget.regionName,
                  context: context,
                  OrderDate:
                      DateFormat('yyyy-MM-dd')
                          .format(_timeData)
                          .toString(),
                  CustomerPhone: widget
                      .mobileNumberControllerCheckOutOnSystem,
                  CustomerName: widget
                      .nameControllerCheckOutOnSystem,
                  customerMapAdress: widget
                      .customerAdressMap,
                  placeId: widget.placeId,
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
                  DeliveryID: DeliveryId!,
                  DiscountCode:
                      discountValueControllerCheckOutOnSystem
                          .text,
                  Details: widget.titleNotes,
                  DeliveryDate: todayDate,
                  DeliveryDay: todayName,
                  OrderTime: selectedTime,
                  TotalValue: totalPrice,
                  Additions: (totalPrice >=
                          20)
                      ? 0.0
                      : ((UserPhone == null)
                          ? widget
                              .DeliveryValue
                          : (getSubscriptionDelivery
                                          .subscriptionList[0]
                                      [
                                      'IsSubscribe'] ==
                                  true)
                              ? 0.0
                              : double.tryParse(
                                      deleveryValue ??
                                          '1.00') ??
                                  1.00),
                  Discount:
                      (widget.discountValue ==
                              0.0)
                          ? widget
                              .DiscountPercent
                          : widget
                              .discountValue,
                  FinalValue: (FinalPrice ==
                          0.0)
                      ? (totalPrice >= 20
                          ? totalPrice
                          : (totalPrice +
                              widget
                                  .DeliveryValue))
                      : FinalPrice,
                  DiscountCardValue: 0,
                  PayID: 2,
                  OnlineStoreId: -1,
                  orderList: widget.newmyList,
                  Image: listItemOrderImage
                      .orderListImage,
                  CustomerAddress: widget
                      .customerAdressMap,
                );
        } catch (e, stackTrace) {
          log("⚠️ حدث خطأ: $e");
          log("🔍 تتبع الخطأ: $stackTrace");
          print(
              '********************************************************');
          log('Error inside then block: \$e');
          print(
              '*********************************************///');
    
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PaymentSuccessButOrderFailedScreen(
                sendOrderAgain: () {
                  (UserPhone != null)
                      ? orderItemFun
                          .orderItemFu(
                          context: context,
                          OrderDate: DateFormat(
                                  'yyyy-MM-dd')
                              .format(
                                  _timeData)
                              .toString(),
                          CustomerAddress: listAddressUser
                                      .dataAddressList[
                                  selectAddress]
                              [
                              "CustomerAddress"],
                          regionName: listAddressUser
                                      .dataAddressList[
                                  selectAddress]
                              ["RegionName"],
                          CustomerPhone: listAddressUser
                                      .dataAddressList[
                                  selectAddress]
                              [
                              "CustomerPhone"],
                          CustomerName: listAddressUser
                                      .dataAddressList[
                                  selectAddress]
                              ["ArabicName"],
                          Email: listAddressUser
                                      .dataAddressList[
                                  selectAddress]
                              ["Email"],
                          DeliveryID:
                              DeliveryId!,
                          DiscountCode:
                              discountValueControllerCheckOutOnSystem
                                  .text,
                          Details: widget
                                  .titleNotes ??
                              '',
                          DeliveryDate:
                              todayDate,
                          DeliveryDay:
                              todayName,
                          OrderTime:
                              selectedTime,
                          TotalValue:
                              totalPrice,
                          Additions: (totalPrice >=
                                  20)
                              ? 0.0
                              : double.tryParse((getSubscriptionDelivery.subscriptionList.isNotEmpty &&
                                          getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] ==
                                              true)
                                      ? '0.000'
                                      : deleveryValue ??
                                          '1.00') ??
                                  1.00,
                          Discount: widget
                              .discountValue,
                          FinalValue: (FinalPrice ==
                                  0.0)
                              ? (totalPrice >=
                                      20
                                  ? totalPrice
                                  : totalPrice +
                                      (double.tryParse((getSubscriptionDelivery.subscriptionList.isNotEmpty && getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true)
                                              ? '0.000'
                                              : deleveryValue ?? '1.00') ??
                                          1.00))
                              : FinalPrice,
                          DiscountCardValue:
                              0,
                          PayID: 2,
                          OnlineStoreId: -1,
                          orderList: widget
                              .newmyList,
                          Image: listItemOrderImage
                              .orderListImage,
                          discountPointsValue: walletPoints
                                  .walletPointsList
                                  .isNotEmpty
                              ? walletPoints
                                      .walletPointsList[0]
                                  [
                                  'PointsValue']
                              : 0,
                        )
                      : orderItemFun
                          .orderItemFu(
                          DistriictName: widget
                              .ValueselectedDistrict,
                          regionName: widget
                              .regionName,
                          context: context,
                          OrderDate: DateFormat(
                                  'yyyy-MM-dd')
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
                          placeId:
                              widget.placeId,
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
                              DeliveryId!,
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
                          Additions: (totalPrice >=
                                  20)
                              ? 0.0
                              : ((UserPhone ==
                                      null)
                                  ? widget
                                      .DeliveryValue
                                  : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] ==
                                          true)
                                      ? 0.0
                                      : double.tryParse(deleveryValue ??
                                              '1.00') ??
                                          1.00),
                          Discount: (widget
                                      .discountValue ==
                                  0.0)
                              ? widget
                                  .DiscountPercent
                              : widget
                                  .discountValue,
                          FinalValue: (FinalPrice ==
                                  0.0)
                              ? (totalPrice >=
                                      20
                                  ? totalPrice
                                  : (totalPrice +
                                      widget
                                          .DeliveryValue))
                              : FinalPrice,
                          DiscountCardValue:
                              0,
                          PayID: 2,
                          OnlineStoreId: -1,
                          orderList: widget
                              .newmyList,
                          Image: listItemOrderImage
                              .orderListImage,
                          CustomerAddress: widget
                              .customerAdressMap,
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
            builder: (context) =>
                PaymentErrorPage(),
          ),
        );
      });
        }
    } else {
      setState(() {
        checkTimeNotFound = false;
      });
                                       
    }
                                    
  }

  Future<void> tabby_payment_method(GetSubscriptionProviderApi getSubscriptionDelivery, GetDataAddressFromApi listAddressUser, String uniqueReferenceId, BuildContext context, OrderItemFun orderItemFun, ListItemOrderImage listItemOrderImage, WalletPoints walletPoints) async {
     if (_formKey.currentState!.validate()) {
     
      final mockPayload = Payment(
        amount: (FinalPrice == 0.0)
            ? (totalPrice >= 20
                    ? totalPrice +
                        0.0 // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
                    : (totalPrice +
                        ((UserPhone == null)
                            ? widget
                                .DeliveryValue
                            : double.parse((getSubscriptionDelivery
                                    .subscriptionList
                                    .isEmpty)
                                ? '0.000'
                                : (getSubscriptionDelivery.subscriptionList[0]
                                            [
                                            'IsSubscribe'] ==
                                        true)
                                    ? '0.000'
                                    : deleveryValue ??
                                        '1.00'))))
                .toStringAsFixed(3)
            : FinalPrice.toStringAsFixed(3),
        currency: Currency.kwd,
        buyer: Buyer(
          email: (UserPhone != null)
              ? listAddressUser
                      .dataAddressList[
                  selectAddress]["Email"]
              : widget
                  .emailControllerCheckOutOnSystem,
          phone: (UserPhone != null)
              ? listAddressUser
                          .dataAddressList[
                      selectAddress]
                  ["CustomerPhone"]
              : widget
                  .mobileNumberControllerCheckOutOnSystem,
          name: (UserPhone != null)
              ? listAddressUser
                      .dataAddressList[
                  selectAddress]["ArabicName"]
              : widget
                  .nameControllerCheckOutOnSystem,
          dob: '1990-01-01',
        ),
        buyerHistory: BuyerHistory(
          loyaltyLevel: 0,
          registeredSince:
              '2019-08-24T14:15:22Z',
          wishlistCount: 0,
        ),
        shippingAddress:
            const ShippingAddress(
          city: 'string',
          address: 'string',
          zip: 'string',
        ),
        order: Order(
            referenceId: uniqueReferenceId,
            items: [
              OrderItem(
                title: 'Jersey',
                description: 'Jersey',
                quantity: 1,
                unitPrice: '10.00',
                referenceId: 'uuid',
                productUrl:
                    'http://example.com',
                category: 'clothes',
              )
            ]),
        orderHistory: [
          tabby.OrderHistoryItem(
            purchasedAt:
                '2019-08-24T14:15:22Z',
            amount: (FinalPrice == 0.0)
                ? (totalPrice >= 20
                        ? totalPrice +
                            0.0 // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
                        : (totalPrice +
                            ((UserPhone ==
                                    null)
                                ? widget
                                    .DeliveryValue
                                : double.parse((getSubscriptionDelivery
                                        .subscriptionList
                                        .isEmpty)
                                    ? '0.000'
                                    : (getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] ==
                                            true)
                                        ? '0.000'
                                        : deleveryValue ??
                                            '1.00'))))
                    .toStringAsFixed(3)
                : FinalPrice.toStringAsFixed(
                    3),
            paymentMethod:
                OrderHistoryItemPaymentMethod
                    .card,
            status:
                OrderHistoryItemStatus.newOne,
          )
        ],
      );
    
      try {
        session = await TabbySDK()
            .createSession(
                TabbyCheckoutPayload(
          merchantCode: 'Tmwenat appkwt',
          lang: Lang.en,
          payment: mockPayload,
        ));
        setState(() {
          if (session != null &&
              session!.availableProducts
                      .installments !=
                  null) {
            TabbyWebView.showWebView(
              context: context,
              webUrl: session!
                  .availableProducts
                  .installments!
                  .webUrl,
              onResult:
                  (WebViewResult resultCode) {
                print(
                    'Result Code: ${resultCode.name}');
    
                if (resultCode.name ==
                    'authorized') {
              create_order(orderItemFun, context, listAddressUser, getSubscriptionDelivery, listItemOrderImage, walletPoints);
                } else if (resultCode.name ==
                        'rejected' ||
                    resultCode.name ==
                        'expired' ||
                    resultCode.name ==
                        'close') {
                  navigate_faild_payment(context);
                 
                } else {
                  navigate_faild_payment(context);
             
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
            print(
                'Session not initialized or no web URL found');
          }
        });
      } catch (e) {
                         navigate_faild_payment(context);

       
        print('Error creating session: $e');
      }
    }
                                    
  }

  void navigate_faild_payment(BuildContext context) {
         Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PaymentErrorPage(),
      ),
    );
                 
  }

  void cash_payment_method(OrderItemFun orderItemFun, BuildContext context, GetDataAddressFromApi listAddressUser, GetSubscriptionProviderApi getSubscriptionDelivery, ListItemOrderImage listItemOrderImage, WalletPoints walletPoints) {
       create_order(orderItemFun, context, listAddressUser, getSubscriptionDelivery, listItemOrderImage, walletPoints);
  }

  void create_order(OrderItemFun orderItemFun, BuildContext context, GetDataAddressFromApi listAddressUser, GetSubscriptionProviderApi getSubscriptionDelivery, ListItemOrderImage listItemOrderImage, WalletPoints walletPoints) {
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
           regionName: listAddressUser
                       .dataAddressList[
                   selectAddress]
               ["RegionName"],
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
           DeliveryID: DeliveryId!,
           DiscountCode:
               discountValueControllerCheckOutOnSystem
                   .text,
           Details:
               widget.titleNotes ?? '',
           DeliveryDate: todayDate,
           DeliveryDay: todayName,
           OrderTime: selectedTime,
           TotalValue: totalPrice,
           Additions: (totalPrice >= 20)
               ? 0.0
               : double.parse(
                   (getSubscriptionDelivery
                               .subscriptionList
                               .isNotEmpty &&
                           getSubscriptionDelivery
                                       .subscriptionList[0]
                                   ['IsSubscribe'] ==
                               true)
                       ? '0.000' // إذا كان هناك اشتراك، رسوم التوصيل ستكون 0
                       : deleveryValue ??
                           '1.00' // إذا لم يكن هناك اشتراك، استخدم قيمة deleveryValue أو 5.000 كقيمة افتراضية
                   ),
          
           Discount: widget.discountValue,
           FinalValue: (FinalPrice == 0.0)
               ? (totalPrice >= 20
                   ? totalPrice + 0.0
                   : totalPrice +
                       double.parse(
                           (getSubscriptionDelivery
                                       .subscriptionList
                                       .isNotEmpty &&
                                   getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] ==
                                       true)
                               ? '0.000' // إذا كان هناك اشتراك، رسوم التوصيل ستكون 0
                               : deleveryValue ??
                                   '1.00' // إذا لم يكن هناك اشتراك، استخدم قيمة deleveryValue أو 5.000 كقيمة افتراضية
                           ))
               : FinalPrice,
           DiscountCardValue: 0,
           PayID:  selectedOption,
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
           discountPointsValue: walletPoints
                   .walletPointsList
                   .isNotEmpty
               ? walletPoints
                       .walletPointsList[0]
                   ['PointsValue']
               : 0.0,
         )
       : orderItemFun.orderItemFu(
           DistriictName: widget
               .ValueselectedDistrict,
           regionName: widget.regionName,
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
           DeliveryID: DeliveryId!,
           Details: widget.titleNotes,
           DeliveryDate: todayDate,
           DeliveryDay: todayName,
           OrderTime: selectedTime,
           TotalValue: totalPrice,
           Additions: (totalPrice >= 20)
               ? 0.0
               : ((UserPhone == null)
                   ? widget.DeliveryValue
                   : (getSubscriptionDelivery
                                   .subscriptionList[0]
                               [
                               'IsSubscribe'] ==
                           true)
                       ? '0.000'
                       : deleveryValue ??
                           1),
           Discount: widget.discountValue,
           FinalValue: (FinalPrice == 0.0)
               ? (totalPrice >= 20
                       ? totalPrice +
                           0.0 // إذا كان totalPrice أكبر من أو يساوي 20، لا تضف رسوم توصيل
                       : totalPrice +
                           widget
                               .DeliveryValue // إذا كان totalPrice أقل من 20، أضف رسوم التوصيل
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
  }

  
  Center item12(AppModel lang, GetDataAddressFromApi listAddressUser) {
    // Determine the message based on the active language and user phone status.
    final message = (lang.activeLanguage.languageCode == 'ar')
        ? 'الطلب اقل من ${((UserPhone == null) ? widget.BilleValue.toStringAsFixed(3) : BillValue ?? listAddressUser.dataAddressList[0]['BillValue'] ?? '')}د.ك'
        : 'The order value is less ${widget.BilleValue ?? ''}k.D ';
    return Center(
                      child: Text(
                          (lang.activeLanguage.languageCode == 'ar')
                              ? 'الطلب اقل من ${((UserPhone == null) ? widget.BilleValue.toStringAsFixed(3) : BillValue ?? listAddressUser.dataAddressList[0]['BillValue'] ?? '')}د.ك'
                              : 'The order value is less ${widget.BilleValue ?? ''}k.D ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            fontFamily: 'Monadi',
                            color: Colors.red,
                          )),
                    );
  }

  Row item11(AppModel lang, GetSubscriptionProviderApi getSubscriptionDelivery) {
    return Row(
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
                        ' ${(FinalPrice == 0.0) ? (totalPrice + num.parse((totalPrice >= 20 ? '0' : (getSubscriptionDelivery.subscriptionList.isNotEmpty && getSubscriptionDelivery.subscriptionList[0]['IsSubscribe'] == true) ? '0.000' : (deleveryValue != null ? deleveryValue.toString() : '1.00')))).toStringAsFixed(3) : FinalPrice.toStringAsFixed(3)}',
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
              );
  }

  Row item10(AppModel lang) {
    return Row(
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
                        Text(
                            (widget.DiscountPercent != 0)
                                ? '${widget.DiscountPercent}'
                                : ' ${widget.discountValue.toStringAsFixed(3)} ',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),
                        Text(
                            (widget.DiscountPercent != 0)
                                ? '  %'
                                : (lang.activeLanguage.languageCode == 'ar'
                                    ? 'د.ك'
                                    : 'K.D'),
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),
                      ],
                    );
  }

  Row item9(AppModel lang) {
    return Row(
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
                            (widget.DiscountPercent != 0)
                                ? '${widget.DiscountPercent}'
                                : ' ${widget.discountValue.toStringAsFixed(3)} ',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),
                        Text(
                            (widget.DiscountPercent != 0)
                                ? '  %'
                                : (lang.activeLanguage.languageCode == 'ar'
                                    ? 'د.ك'
                                    : 'K.D'),
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12.sp,
                              fontFamily: 'Monadi',
                              color: AppColors.black,
                            )),
                      ],
                    );
  }

  Column item8(AppModel lang, GetSubscriptionProviderApi getSubscriptionDelivery) {
    return Column(
                children: [
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
                            '${(totalPrice >= 20) ? 0.000 : ((UserPhone == null) ? widget.DeliveryValue : (num.parse(
                                ((totalPrice >= 20)
                                    ? 0.toString()
                                    : (getSubscriptionDelivery
                                                .subscriptionList.isNotEmpty &&
                                            getSubscriptionDelivery
                                                        .subscriptionList[0]
                                                    ['IsSubscribe'] ==
                                                true)
                                        ? '0.000'
                                        : deleveryValue ?? '1.00'),
                              )).toStringAsFixed(3))}',
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
                ],
              );
  }

  Column paymentwaySelection(BuildContext context, AppModel lang, GetSubscriptionProviderApi getSubscriptionDelivery, GetDataAddressFromApi listAddressUser, WalletPoints walletPoints) {
    return Column(
                  children: [
                   /// Cash Payment
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
                                          (lang.activeLanguage.languageCode ==
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

                    Image.asset(
                      AppAssets.money,
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
  
                  
                  
                   //'الدفع كى نت اونلاين
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
                                 
                                  } else if (widget.PaymentMethod == 2) {
                                    selectedOption = value!;
                                    selectedOptionPaymentId = 1;
                                    print(selectedOption);
                                  } else if (widget.PaymentMethod == null) {
                                    selectedOption = value!;
                                    selectedOptionPaymentId = 1;
                                    print(selectedOption);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text((lang.activeLanguage
                                                      .languageCode ==
                                                  'ar')
                                              ? 'هذه المنطقه طرق الدفع المتاحه فيها الدفع كاش'
                                              : 'This area has cash payment methods available'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text((lang.activeLanguage
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
                              visualDensity: const VisualDensity(
                                  horizontal: -4, vertical: -4),
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
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain)
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
                                  } else if (widget.PaymentMethod == null) {
                                    selectedOption = value!;
                                    selectedOptionPaymentId = 2;
                                    print(selectedOption);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text((lang.activeLanguage
                                                      .languageCode ==
                                                  'ar')
                                              ? 'هذه المنطقه طرق الدفع المتاحه فيها الدفع كاش'
                                              : 'This area has cash payment methods available'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text((lang.activeLanguage
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
                                  VisualDensity(horizontal: -4, vertical: -4),
                            ),
                            SizedBox(width: 0),
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
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain)
                      ],
                    ),

                    // if (Platform.isIOS)
                    //   Consumer(builder: (context, ref, child) {
                    //     final orderItemFun = ref.watch(orderItemProvider);
                    //     final listItemOrderImage =
                    //         ref.watch(orderProviderListImage);

                    //     return InkWell(
                    //       onTap: () async {
                    //         if (_formKey.currentState!.validate() &&
                    //             selectedCardIndex! >= 0 && DeliveryId != null) {
                    //           print(
                    //               'GAAAAAAAAAAAAAAAAA1111111111111111111111');

                    //           MFExecutePaymentRequest executePaymentRequest =
                    //               MFExecutePaymentRequest(
                    //             invoiceValue: (FinalPrice == 0.0)
                    //                 ? (totalPrice +
                    //                     ((totalPrice >=
                    //                             20) // إذا كانت totalPrice أكبر من أو تساوي 20
                    //                         ? 0.0 // لا يتم إضافة رسوم التوصيل
                    //                         : (UserPhone == null)
                    //                             ? double.parse(widget
                    //                                     .DeliveryValue
                    //                                 .toString()) // إذا كانت UserPhone فارغة
                    //                             : double.parse(
                    //                                 (getSubscriptionDelivery
                    //                                         .subscriptionList
                    //                                         .isEmpty)
                    //                                     ? '0.500' // إذا كانت subscriptionList فارغة
                    //                                     : (getSubscriptionDelivery
                    //                                                     .subscriptionList[0]
                    //                                                 [
                    //                                                 'IsSubscribe'] ==
                    //                                             true)
                    //                                         ? '0.000' // إذا كانت الاشتراك نشطًا
                    //                                         : (deleveryValue ??
                    //                                             '1.00') // إذا لم يكن هناك قيمة محددة
                    //                                 )))
                    //                 : FinalPrice,
                    //           );

                    //           executePaymentRequest.displayCurrencyIso =
                    //               MFCurrencyISO.KUWAIT_KWD;

                    //           await mfApplePayButton
                    //               .displayApplePayButton(
                    //                   sessionApple!,
                    //                   executePaymentRequest,
                    //                   MFLanguage.ENGLISH)
                    //               .then((value) => {
                    //                     log(value),
                    //                     mfApplePayButton
                    //                         .executeApplePayButton(null,
                    //                             (invoiceId) => log(invoiceId))
                    //                         .then((value) {
                    //                       if (UserPhone != null) {
                    //                         orderItemFun.orderItemFu(
                    //                           DistriictName: listAddressUser
                    //                                       .dataAddressList[
                    //                                   selectAddress]
                    //                               ["DistrictName"],
                    //                           context: context,
                    //                           regionName: listAddressUser
                    //                                       .dataAddressList[
                    //                                   selectAddress]
                    //                               ["RegionName"],
                    //                           OrderDate:
                    //                               DateFormat('yyyy-MM-dd')
                    //                                   .format(_timeData)
                    //                                   .toString(),
                    //                           CustomerAddress: listAddressUser
                    //                                       .dataAddressList[
                    //                                   selectAddress]
                    //                               ["CustomerAddress"],
                    //                           CustomerPhone: listAddressUser
                    //                                       .dataAddressList[
                    //                                   selectAddress]
                    //                               ["CustomerPhone"],
                    //                           CustomerName: listAddressUser
                    //                                       .dataAddressList[
                    //                                   selectAddress]
                    //                               ["ArabicName"],
                    //                           Block: listAddressUser
                    //                                   .dataAddressList[
                    //                               selectAddress]["Block"],
                    //                           Street: listAddressUser
                    //                                       .dataAddressList[
                    //                                   selectAddress]
                    //                               ["StreetName"],
                    //                           House: listAddressUser
                    //                                   .dataAddressList[
                    //                               selectAddress]["HouseNo"],
                    //                           DiscountCode:
                    //                               discountValueControllerCheckOutOnSystem
                    //                                   .text,
                    //                           Gada: listAddressUser
                    //                                   .dataAddressList[
                    //                               selectAddress]["Gada"],
                    //                           Floor: listAddressUser
                    //                                   .dataAddressList[
                    //                               selectAddress]["Floor"],
                    //                           Apartment: listAddressUser
                    //                                   .dataAddressList[
                    //                               selectAddress]["Apartment"],
                    //                           Email: listAddressUser
                    //                                   .dataAddressList[
                    //                               selectAddress]["Email"],
                    //                           DeliveryID: DeliveryId!,
                    //                           Details: widget.titleNotes,
                    //                           DeliveryDate: todayDate,
                    //                           DeliveryDay: todayName,
                    //                           OrderTime: selectedTime,
                    //                           TotalValue: totalPrice,
                    //                           Additions: (totalPrice >= 20)
                    //                               ? 0
                    //                               : (UserPhone == null)
                    //                                   ? widget.DeliveryValue
                    //                                   : (getSubscriptionDelivery
                    //                                                   .subscriptionList[0]
                    //                                               [
                    //                                               'IsSubscribe'] ==
                    //                                           true)
                    //                                       ? 0.000
                    //                                       : deleveryValue ??
                    //                                           1,
                    //                           Discount: widget.discountValue,
                    //                           FinalValue: (FinalPrice == 0.0)
                    //                               ? (totalPrice >= 20
                    //                                   ? totalPrice // إذا كانت قيمة totalPrice أكبر من أو تساوي 20، لا تتم إضافة رسوم التوصيل
                    //                                   : totalPrice +
                    //                                       double.parse(
                    //                                           (getSubscriptionDelivery.subscriptionList[0]
                    //                                                       [
                    //                                                       'IsSubscribe'] ==
                    //                                                   true)
                    //                                               ? '0.000' // إذا كان الاشتراك نشطًا، لا يتم إضافة رسوم التوصيل
                    //                                               : deleveryValue ??
                    //                                                   '1.00' // إذا لم يكن الاشتراك نشطًا، يتم إضافة القيمة الافتراضية
                    //                                           ))
                    //                               : FinalPrice,
                    //                           DiscountCardValue: 0,
                    //                           PayID: 2,
                    //                           OnlineStoreId: -1,
                    //                           orderList: widget.newmyList,
                    //                           Image: listItemOrderImage
                    //                               .orderListImage,
                    //                           discountPointsValue:
                    //                               walletPoints
                    //                                       .walletPointsList[0]
                    //                                   ['PointsValue'],
                    //                         );
                    //                       } else {
                    //                         orderItemFun.orderItemFu(
                    //                           DistriictName: widget
                    //                               .ValueselectedDistrict,
                    //                           context: context,
                    //                           OrderDate:
                    //                               DateFormat('yyyy-MM-dd')
                    //                                   .format(_timeData)
                    //                                   .toString(),
                    //                           CustomerPhone: widget
                    //                               .mobileNumberControllerCheckOutOnSystem,
                    //                           CustomerName: widget
                    //                               .nameControllerCheckOutOnSystem,
                    //                           customerMapAdress:
                    //                               widget.customerAdressMap,
                    //                           placeId: widget.placeId,
                    //                           regionName: widget.regionName,
                    //                           Block: widget
                    //                               .BlockNumberControllerCheckOutOnSystem,
                    //                           Street: widget
                    //                               .StreetControllerCheckOutOnSystem,
                    //                           House: widget
                    //                               .HouseControllerCheckOutOnSystem,
                    //                           Gada: widget.gada,
                    //                           Floor: widget
                    //                               .floorControllerCheckOutOnSystem,
                    //                           Apartment: widget
                    //                               .apartmentControllerCheckOutOnSystem,
                    //                           Email: widget
                    //                               .emailControllerCheckOutOnSystem,
                    //                           DeliveryID: DeliveryId!,
                    //                           DiscountCode:
                    //                               discountValueControllerCheckOutOnSystem
                    //                                   .text,
                    //                           Details: widget.titleNotes,
                    //                           DeliveryDate: todayDate,
                    //                           DeliveryDay: todayName,
                    //                           OrderTime: selectedTime,
                    //                           TotalValue: totalPrice,
                    //                           Additions: (totalPrice >= 20)
                    //                               ? 0
                    //                               : (UserPhone == null)
                    //                                   ? widget.DeliveryValue
                    //                                   : (getSubscriptionDelivery
                    //                                                   .subscriptionList[0]
                    //                                               [
                    //                                               'IsSubscribe'] ==
                    //                                           true)
                    //                                       ? 0.000
                    //                                       : deleveryValue ??
                    //                                           1,
                    //                           Discount: widget.discountValue,
                    //                           FinalValue: (FinalPrice == 0.0)
                    //                               ? (totalPrice >= 20
                    //                                   ? totalPrice // إذا كانت قيمة totalPrice أكبر من أو تساوي 20، لا تتم إضافة رسوم التوصيل
                    //                                   : totalPrice +
                    //                                       widget
                    //                                           .DeliveryValue) // إذا كانت قيمة totalPrice أقل من 20، يتم إضافة رسوم التوصيل
                    //                               : FinalPrice, // إذا كانت قيمة FinalPrice ليست 0.0، يتم استخدام FinalPrice مباشرةً

                    //                           DiscountCardValue: 0,
                    //                           PayID: 2,
                    //                           OnlineStoreId: -1,
                    //                           orderList: widget.newmyList,
                    //                           Image: listItemOrderImage
                    //                               .orderListImage,
                    //                           CustomerAddress: widget
                    //                               .customerAdressMap, // UPDATED HERE
                    //                         );
                    //                       }
                    //                     }).catchError((error) => {
                    //                               Navigator.push(
                    //                                 context,
                    //                                 MaterialPageRoute(
                    //                                     builder: (context) =>
                    //                                         PaymentErrorPage()),
                    //                               ),
                    //                               log(error.message)
                    //                             })
                    //                   })
                    //               .catchError((error) => {
                    //                     Navigator.push(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                           builder: (context) =>
                    //                               PaymentErrorPage()),
                    //                     ),
                    //                     log(error.message)
                    //                   });
                    //         }
                    //       },
                    //       child: 
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children: [
                    //               // 50.horizontalSpace,
                    //               Radio(
                    //                 value: 3,
                    //                 groupValue: selectedOption,
                    //                 onChanged: (value) {
                    //                   setState(() {
                    //                     if (widget.PaymentMethod == 1) {
                    //                       selectedOption = value!;
                    //                       selectedOptionPaymentId = 3;
                    //                       print(selectedOption);
                    //                     } else if (widget.PaymentMethod ==
                    //                         2) {
                    //                       selectedOption = value!;
                    //                       selectedOptionPaymentId = 3;
                    //                       print(selectedOption);
                    //                     } else if (widget.PaymentMethod ==
                    //                         null) {
                    //                       selectedOption = value!;
                    //                       selectedOptionPaymentId = 3;
                    //                       print(selectedOption);
                    //                     } else {
                    //                       showDialog(
                    //                         context: context,
                    //                         builder: (BuildContext context) {
                    //                           return AlertDialog(
                    //                             content: Text((lang
                    //                                         .activeLanguage
                    //                                         .languageCode ==
                    //                                     'ar')
                    //                                 ? 'هذه المنطقه طرق الدفع المتاحه فيها الدفع كاش'
                    //                                 : 'This area has cash payment methods available'),
                    //                             actions: <Widget>[
                    //                               TextButton(
                    //                                 onPressed: () {
                    //                                   Navigator.of(context)
                    //                                       .pop();
                    //                                 },
                    //                                 child: Text((lang
                    //                                             .activeLanguage
                    //                                             .languageCode ==
                    //                                         'ar')
                    //                                     ? 'موافق'
                    //                                     : 'OK'),
                    //                               ),
                    //                             ],
                    //                           );
                    //                         },
                    //                       );
                    //                     }
                    //                   });
                    //                 },
                    //                 visualDensity: VisualDensity(
                    //                     horizontal: -4, vertical: -4),
                    //               ),
                    //               SizedBox(width: 0),
                    //               Text(
                    //                 (lang.activeLanguage.languageCode == 'ar')
                    //                     ? 'ابل باى'
                    //                     : 'Apple Pay (KWD)',
                    //                 textAlign: TextAlign.center,
                    //                 style: TextStyle(
                    //                   fontWeight: FontWeight.w500,
                    //                   fontSize: 16.sp,
                    //                   fontFamily: 'Monadi',
                    //                   color: AppColors.black,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           Image.network(
                    //               'https://portal.myfatoorah.com/imgs/payment-methods/ap.png',
                    //               width: 30,
                    //               height: 30,
                    //               fit: BoxFit.contain)
                    //         ],
                    //       ),
                       
                    //     );
                    //   }),
                 
                    /// Google & Apple Pay    
                 
                    if (Platform.isAndroid)
                      Consumer(builder: (context, ref, child) {
                        final orderItemFun = ref.watch(orderItemProvider);
                        final listItemOrderImage =
                            ref.watch(orderProviderListImage);

                        return InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate() &&
                                selectedCardIndex! >= 0&& DeliveryId != null ) {
                              print(
                                  'GAAAAAAAAAAAAAAAAA1111111111111111111111');
                              MFGooglePayRequest googlePayRequest =
                                  MFGooglePayRequest(
                                totalPrice: (FinalPrice == 0.0)
                                    ? (totalPrice >= 20
                                            ? totalPrice // إذا كانت قيمة totalPrice أكبر من أو تساوي 20، لا يتم إضافة رسوم التوصيل
                                            : (totalPrice +
                                                ((UserPhone == null)
                                                    ? widget.DeliveryValue
                                                    : double.parse((getSubscriptionDelivery
                                                            .subscriptionList
                                                            .isEmpty)
                                                        ? '0.500'
                                                        : (getSubscriptionDelivery
                                                                        .subscriptionList[0]
                                                                    [
                                                                    'IsSubscribe'] ==
                                                                true)
                                                            ? '0.000'
                                                            : deleveryValue ??
                                                                '1.00'))))
                                        .toStringAsFixed(3)
                                    : FinalPrice.toStringAsFixed(3),
                                merchantId: "your_actual_google_merchant_id",
                                merchantName: "Test Vendor",
                                countryCode: MFCountry.KUWAIT,
                                currencyIso: MFCurrencyISO.KUWAIT_KWD,
                              );

                              try {
                                await MFSDK
                                    .setupGooglePayHelper(
                                        sesionGoogle!, googlePayRequest,
                                        (invoiceId) {
                                      if (invoiceId != null) {
                                        log("-----------Invoice Id: $invoiceId------------");

                                        // Call your orderItemFun after successful payment
                                        if (UserPhone != null) {
                                          orderItemFun.orderItemFu(
                                            DistriictName: listAddressUser
                                                    .dataAddressList[
                                                selectAddress]["RegionName"],
                                            context: context,
                                            regionName: listAddressUser
                                                        .dataAddressList[
                                                    selectAddress]
                                                ["DistrictName"],
                                            OrderDate:
                                                DateFormat('yyyy-MM-dd')
                                                    .format(_timeData)
                                                    .toString(),
                                            CustomerAddress: listAddressUser
                                                        .dataAddressList[
                                                    selectAddress]
                                                ["CustomerAddress"],
                                            CustomerPhone: listAddressUser
                                                        .dataAddressList[
                                                    selectAddress]
                                                ["CustomerPhone"],
                                            CustomerName: listAddressUser
                                                    .dataAddressList[
                                                selectAddress]["ArabicName"],
                                            Block: listAddressUser
                                                    .dataAddressList[
                                                selectAddress]["Block"],
                                            Street: listAddressUser
                                                    .dataAddressList[
                                                selectAddress]["StreetName"],
                                            House: listAddressUser
                                                    .dataAddressList[
                                                selectAddress]["HouseNo"],
                                            DiscountCode:
                                                discountValueControllerCheckOutOnSystem
                                                    .text,
                                            Gada: listAddressUser
                                                    .dataAddressList[
                                                selectAddress]["Gada"],
                                            Floor: listAddressUser
                                                    .dataAddressList[
                                                selectAddress]["Floor"],
                                            Apartment: listAddressUser
                                                    .dataAddressList[
                                                selectAddress]["Apartment"],
                                            Email: listAddressUser
                                                    .dataAddressList[
                                                selectAddress]["Email"],
                                            DeliveryID: DeliveryId!,
                                            Details: widget.titleNotes,
                                            DeliveryDate: todayDate,
                                            DeliveryDay: todayName,
                                            OrderTime: selectedTime,
                                            TotalValue: totalPrice,
                                            Additions: totalPrice >= 20
                                                ? 0
                                                : (UserPhone == null)
                                                    ? widget.DeliveryValue
                                                    : (getSubscriptionDelivery
                                                                    .subscriptionList[0]
                                                                [
                                                                'IsSubscribe'] ==
                                                            true)
                                                        ? 0.000
                                                        : deleveryValue ?? 1,
                                            Discount: widget.discountValue,
                                            FinalValue: (FinalPrice == 0.0)
                                                ? (totalPrice >= 20
                                                    ? totalPrice // إذا كانت قيمة totalPrice أكبر من أو تساوي 20، لا يتم إضافة رسوم التوصيل
                                                    : (totalPrice +
                                                        double.parse((getSubscriptionDelivery
                                                                    .subscriptionList
                                                                    .isNotEmpty &&
                                                                getSubscriptionDelivery
                                                                            .subscriptionList[0]
                                                                        [
                                                                        'IsSubscribe'] ==
                                                                    true)
                                                            ? '0.000'
                                                            : deleveryValue ??
                                                                '1.00')))
                                                : FinalPrice,
                                            DiscountCardValue: 0,
                                            PayID: 2,
                                            OnlineStoreId: -1,
                                            orderList: widget.newmyList,
                                            Image: listItemOrderImage
                                                .orderListImage,
                                            discountPointsValue: walletPoints
                                                    .walletPointsList[0]
                                                ['PointsValue'],
                                          );
                                        } else {
                                          orderItemFun.orderItemFu(
                                            DistriictName:
                                                widget.ValueselectedDistrict,
                                            context: context,
                                            OrderDate:
                                                DateFormat('yyyy-MM-dd')
                                                    .format(_timeData)
                                                    .toString(),
                                            CustomerPhone: widget
                                                .mobileNumberControllerCheckOutOnSystem,
                                            CustomerName: widget
                                                .nameControllerCheckOutOnSystem,
                                            customerMapAdress:
                                                widget.customerAdressMap,
                                            placeId: widget.placeId,
                                            regionName: widget.regionName,
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
                                            DeliveryID: DeliveryId!,
                                            DiscountCode:
                                                discountValueControllerCheckOutOnSystem
                                                    .text,
                                            Details: widget.titleNotes,
                                            DeliveryDate: todayDate,
                                            DeliveryDay: todayName,
                                            OrderTime: selectedTime,
                                            TotalValue: totalPrice,
                                            Additions: totalPrice >= 20
                                                ? 0
                                                : (UserPhone == null)
                                                    ? widget.DeliveryValue
                                                    : (getSubscriptionDelivery
                                                                    .subscriptionList[0]
                                                                [
                                                                'IsSubscribe'] ==
                                                            true)
                                                        ? 0.000
                                                        : deleveryValue ?? 1,
                                            Discount:
                                                (widget.discountValue == 0.0)
                                                    ? 0.0
                                                    // widget.DiscountPercent
                                                    : widget.discountValue,
                                            FinalValue: (FinalPrice == 0.0)
                                                ? (totalPrice >= 20
                                                    ? totalPrice // إذا كانت قيمة totalPrice أكبر من أو تساوي 20، لا يتم إضافة رسوم التوصيل
                                                    : (totalPrice +
                                                        widget.DeliveryValue))
                                                : FinalPrice,

                                            DiscountCardValue: 0,
                                            PayID: 2,
                                            OnlineStoreId: -1,
                                            orderList: widget.newmyList,
                                            Image: listItemOrderImage
                                                .orderListImage,
                                            CustomerAddress: widget
                                                .customerAdressMap, // UPDATED HERE
                                          );
                                        }
                                      } else {
                                        log("Failed to get invoice ID");
                                      }
                                    })
                                    .then((value) =>
                                        log("Payment successful: $value"))
                                    .catchError((error) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PaymentErrorPage()),
                                      );
                                      log("Payment failed: ${error.message}");
                                    });
                              } catch (error) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PaymentErrorPage()),
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
                                        if (widget.PaymentMethod == 1 ||
                                            widget.PaymentMethod == 2 ||
                                            widget.PaymentMethod == null) {
                                          selectedOption = value!;
                                          selectedOptionPaymentId = 26;
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
                                                      : 'This area has cash payment methods available',
                                                ),
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
                                                          : 'OK',
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      });
                                    },
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
                                  ),
                                  Text(
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'جوجل باى'
                                        : 'Google Pay ',
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
                      }),
                 
                    ///Tabby Pay
                      //  Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: [
                      //             // 50.horizontalSpace,
                      //             Radio(
                      //               value: 4,
                      //               groupValue: selectedOption,
                      //               onChanged: (value) {
                      //                 setState(() {
                      //                   if (widget.PaymentMethod == 1) {
                      //                     selectedOption = value!;
                      //                     selectedOptionPaymentId = 4;
                      //                     print(selectedOption);
                      //                   } else if (widget.PaymentMethod ==
                      //                       2) {
                      //                     selectedOption = value!;
                      //                     selectedOptionPaymentId = 4;
                      //                     print(selectedOption);
                      //                   } else if (widget.PaymentMethod ==
                      //                       null) {
                      //                     selectedOption = value!;
                      //                     selectedOptionPaymentId = 4;
                      //                     print(selectedOption);
                      //                   } else {
                      //                     showDialog(
                      //                       context: context,
                      //                       builder: (BuildContext context) {
                      //                         return AlertDialog(
                      //                           content: Text((lang
                      //                                       .activeLanguage
                      //                                       .languageCode ==
                      //                                   'ar')
                      //                               ? 'هذه المنطقه طرق الدفع المتاحه فيها الدفع كاش'
                      //                               : 'This area has cash payment methods available'),
                      //                           actions: <Widget>[
                      //                             TextButton(
                      //                               onPressed: () {
                      //                                 Navigator.of(context)
                      //                                     .pop();
                      //                               },
                      //                               child: Text((lang
                      //                                           .activeLanguage
                      //                                           .languageCode ==
                      //                                       'ar')
                      //                                   ? 'موافق'
                      //                                   : 'OK'),
                      //                             ),
                      //                           ],
                      //                         );
                      //                       },
                      //                     );
                      //                   }
                      //                 });
                      //               },
                      //               visualDensity: VisualDensity(
                      //                   horizontal: -4, vertical: -4),
                      //             ),
                      //             SizedBox(width: 0),
                      //             Text(
                      //               (lang.activeLanguage.languageCode == 'ar')
                      //                   ? 'تابي باى'
                      //                   : 'Tappy Pay (KWD)',
                      //               textAlign: TextAlign.center,
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.w500,
                      //                 fontSize: 16.sp,
                      //                 fontFamily: 'Monadi',
                      //                 color: AppColors.black,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Image.network(
                      //             'https://cdn.salla.sa/RdVVV/oqCDlISc8Sri2l3PUfW2yyqkcyeINqKdoVnG2ZOJ.png',
                      //             width: 30,
                      //             height: 30,
                      //             fit: BoxFit.contain)
                      //       ],
                      //     ),
                          
                 
                    10.verticalSpace,
                    divider(),
                
                  ],
                );
  }

  Divider divider() {
    return const Divider(
                thickness: 1,
                height: 1,
                color: Colors.black,
                endIndent: 20,
                indent: 20,
              );
  }

  Consumer payUsingWallet(AppModel lang, GetDataAddressFromApi listAddressUser, WalletPoints walletPoints) {
    return Consumer(builder: (context, ref, child) {
                final getAmount = ref.watch(getWalletApiProvider);
                final orderItemFun = ref.watch(orderItemProvider);
                final listItemOrderImage = ref.watch(orderProviderListImage);
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
                              ? '${getAmount.amountValueList[0]['Balance'].toStringAsFixed(3)}'
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
                            selectedCardIndex! >= 0&& DeliveryId != null) {
                          if (totalPrice + widget.discountValue <=
                              ((UserPhone == null)
                                  ? widget.BilleValue
                                  : num.parse(BillValue ?? '3.5'))) {
                          } else {
                            if (getAmount.amountValueList[0].isNotEmpty) {
                              discountCardValue = (FinalPrice == 0.0)
                                  ? (totalPrice +
                                      (double.parse(deleveryValue ?? '1.00')))
                                  : FinalPrice;

                              if (getAmount.amountValueList[0]['Balance'] >=
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
                                        ["CustomerAddress"],
                                    regionName: listAddressUser
                                            .dataAddressList[selectAddress]
                                        ["GovernorateName"],
                                    CustomerPhone: listAddressUser
                                            .dataAddressList[selectAddress]
                                        ["CustomerPhone"],
                                    CustomerName: listAddressUser
                                            .dataAddressList[selectAddress]
                                        ["ArabicName"],
                                    Email: listAddressUser.dataAddressList[selectAddress]
                                        ["Email"],
                                    DeliveryID: DeliveryId!,
                                    DiscountCode: discountValueControllerCheckOutOnSystem.text,
                                    Details: widget.titleNotes,
                                    DeliveryDate: todayDate,
                                    DeliveryDay: todayName,
                                    OrderTime: selectedTime,
                                    TotalValue: totalPrice,
                                    Additions: (totalPrice >= 20) ? 0 : double.parse(deleveryValue ?? '1.00'),
                                    Discount: widget.discountValue,
                                    FinalValue: (FinalPrice == 0.0) ? ((totalPrice + double.parse(deleveryValue ?? '1.00')) - discountCardValue) : (FinalPrice - discountCardValue),
                                    DiscountCardValue: discountCardValue,
                                    PayID: 0,
                                    OnlineStoreId: -1,
                                    orderList: widget.newmyList,
                                    Image: listItemOrderImage.orderListImage,
                                    paymentMethodeWalet: 1,
                                    discountPointsValue: walletPoints.walletPointsList[0]['PointsValue']);

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
                                              style: GoogleFonts.cairo(
                                                fontSize: 16.sp,
                                                color:
                                                    const Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      (lang.activeLanguage
                                                                  .languageCode ==
                                                              'ar')
                                                          ? 'رصيد المحفظه'
                                                          : 'Wallet Balance',
                                                      style:
                                                          GoogleFonts.cairo(
                                                        fontSize: 16.sp,
                                                        color: const Color(
                                                            0xff000000),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    12.horizontalSpace,
                                                    Row(
                                                      children: [
                                                        Text(
                                                          (getAmount
                                                                  .amountValueList
                                                                  .isNotEmpty)
                                                              ? '${getAmount.amountValueList[0]['Balance'].toStringAsFixed(3)}'
                                                              : '0.0',
                                                          style: GoogleFonts
                                                              .cairo(
                                                            fontSize: 16.sp,
                                                            color:
                                                                Colors.orange,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          (lang.activeLanguage
                                                                      .languageCode ==
                                                                  'ar')
                                                              ? 'د.ك '
                                                              : 'K.D',
                                                          style: GoogleFonts
                                                              .cairo(
                                                            fontSize: 16.sp,
                                                            color: AppColors
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
                                                      (lang.activeLanguage
                                                                  .languageCode ==
                                                              'ar')
                                                          ? 'اجمالى الفاتوره '
                                                          : 'Total Invoice',
                                                      style:
                                                          GoogleFonts.cairo(
                                                        fontSize: 16.sp,
                                                        color:
                                                            AppColors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    12.horizontalSpace,
                                                    Row(
                                                      children: [
                                                        Text(
                                                          (FinalPrice == 0.0)
                                                              ? ' ${(totalPrice + ((UserPhone == null) ? widget.DeliveryValue : double.parse(deleveryValue ?? '1.00'))).toStringAsFixed(3)} '
                                                              : ' ${(FinalPrice).toStringAsFixed(3)} ',
                                                          style: GoogleFonts
                                                              .cairo(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            fontSize: 16.sp,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                        ),
                                                        Text(
                                                          (lang.activeLanguage
                                                                      .languageCode ==
                                                                  'ar')
                                                              ? 'د.ك '
                                                              : 'K.D',
                                                          style: GoogleFonts
                                                              .cairo(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            fontSize: 16.sp,
                                                            color: AppColors
                                                                .black,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  "اختار احدى طرق الدفع لدفع ما تبقى من الفاتوره",
                                                  style: GoogleFonts.cairo(
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    fontSize: 16.sp,
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    50.horizontalSpace,
                                                    Radio(
                                                      value: 1,
                                                      groupValue:
                                                          selectedOptionWallet,
                                                      onChanged: (value) {
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
                                                    const SizedBox(width: 0),
                                                    Text(
                                                      (lang.activeLanguage
                                                                  .languageCode ==
                                                              'ar')
                                                          ? 'الدفع كى نت اونلاين'
                                                          : 'KNET Online Payment (Online)',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.cairo(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp,
                                                        color:
                                                            AppColors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    50.horizontalSpace,
                                                    Radio(
                                                      value: 2,
                                                      groupValue:
                                                          selectedOptionWallet,
                                                      onChanged: (value) {
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
                                                    const SizedBox(width: 0),
                                                    Text(
                                                      (lang.activeLanguage
                                                                  .languageCode ==
                                                              'ar')
                                                          ? 'فيزا / ماستر'
                                                          : "VISA/MASTER",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.cairo(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp,
                                                        color:
                                                            AppColors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    50.horizontalSpace,
                                                    Radio(
                                                      value: 24,
                                                      groupValue:
                                                          selectedOptionWallet,
                                                      onChanged: (value) {
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
                                                    const SizedBox(width: 0),
                                                    Text(
                                                      (lang.activeLanguage
                                                                  .languageCode ==
                                                              'ar')
                                                          ? 'ابل باى'
                                                          : 'Apple Pay (KWD)',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.cairo(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp,
                                                        color:
                                                            AppColors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    50.horizontalSpace,
                                                    Radio(
                                                      value: 26,
                                                      groupValue:
                                                          selectedOptionWallet,
                                                      onChanged: (value) {
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
                                                    const SizedBox(width: 0),
                                                    Text(
                                                      (lang.activeLanguage
                                                                  .languageCode ==
                                                              'ar')
                                                          ? 'جوجل باى'
                                                          : 'Google Pay (KWD(Online)',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.cairo(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp,
                                                        color:
                                                            AppColors.black,
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
                                                                getAmount.amountValueList[
                                                                        0][
                                                                    'Balance']),
                                                      );
                                                      request.displayCurrencyIso =
                                                          MFCurrencyISO
                                                              .KUWAIT_KWD;

                                                      await MFSDK
                                                          .executePayment(
                                                              request,
                                                              MFLanguage
                                                                  .ARABIC,
                                                              (invoiceId) {
                                                            log(invoiceId);
                                                            setState(() {
                                                              paymentSuccess =
                                                                  true;
                                                            });
                                                          })
                                                          .then((value) => {
                                                                log(value),
                                                                orderItemFun.orderItemFu(
                                                                    context:
                                                                        context,
                                                                    OrderDate: DateFormat('yyyy-MM-dd')
                                                                        .format(
                                                                            _timeData)
                                                                        .toString(),
                                                                    CustomerAddress:
                                                                        listAddressUser.dataAddressList[selectAddress][
                                                                            "CustomerAddress"],
                                                                    CustomerPhone:
                                                                        listAddressUser.dataAddressList[selectAddress][
                                                                            "CustomerPhone"],
                                                                    regionName:
                                                                        listAddressUser.dataAddressList[selectAddress][
                                                                            "RegionName"],
                                                                    CustomerName:
                                                                        listAddressUser.dataAddressList[selectAddress][
                                                                            "ArabicName"],
                                                                    Email: listAddressUser
                                                                            .dataAddressList[selectAddress]
                                                                        ["Email"],
                                                                    DeliveryID: DeliveryId!,
                                                                    DiscountCode: discountValueControllerCheckOutOnSystem.text,
                                                                    Details: widget.titleNotes,
                                                                    DeliveryDate: todayDate,
                                                                    DeliveryDay: todayName,
                                                                    OrderTime: selectedTime,
                                                                    TotalValue: totalPrice,
                                                                    Additions: double.parse(deleveryValue ?? '1.00'),
                                                                    Discount: widget.discountValue,
                                                                    FinalValue: (FinalPrice == 0.0) ? ((totalPrice + double.parse(deleveryValue ?? '1.00')) - discountCardValue) : (FinalPrice - discountCardValue),
                                                                    DiscountCardValue: getAmount.amountValueList[0]['Balance'],
                                                                    PayID: 2,
                                                                    OnlineStoreId: -1,
                                                                    orderList: widget.newmyList,
                                                                    Image: listItemOrderImage.orderListImage,
                                                                    discountPointsValue: walletPoints.walletPointsList[0]['PointsValue']),
                                                              })
                                                          .catchError(
                                                              (error) => {
                                                                    log(error
                                                                        .message),
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            PaymentErrorPage(),
                                                                      ),
                                                                    )
                                                                  });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets
                                                              .all(7.0),
                                                      decoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                          color:
                                                              Colors.orange,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'موافق',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.orange,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets
                                                              .all(8.0),
                                                      decoration:
                                                          BoxDecoration(
                                                        color: Colors.orange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    5.0),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        'الغاء',
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                builder: (_) => AlertDialog(
                                    title: Text(
                                      'لايوجد رصيد بالمحفظه',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: const Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Monadi',
                                      ),
                                    ),
                                    content: Text(
                                      "يرجى عمل ايداع بالمحفظه او استخدام وسيله دفع اخرى ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: const Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Monadi',
                                      ),
                                    ),
                                    actions: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'موافق',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                        ),
                                      )
                                    ]),
                              );
                            }
                          }
                        } else {
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
                    Image.asset(
                      AppAssets.wallet,
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ],
                );
              });
  }

  Consumer item4(AppModel lang) {
    return Consumer(
                builder: (context, ref, child) {
                  final codeDiscount = ref.watch(discountCodeFromApiProvider);

                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(
                          25), // Adjust the border radius as needed
                      color: Colors.white,
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
                            if (discountValueControllerCheckOutOnSystem
                                .text.isNotEmpty) {
                              setState(() {
                                codeDiscount.isLoading = true;
                              });

                              codeDiscount
                                  .getDiscountCode(
                                context: context,
                                orderList: widget.newmyList,
                                discountCode:
                                    discountValueControllerCheckOutOnSystem
                                        .text,
                                customerPhone: (UserPhone != null)
                                    ? UserPhone
                                    : '${widget.mobileNumberControllerCheckOutOnSystem}',
                              )
                                  .then((_) {
                                setState(() {
                                  codeDiscount.isLoading =
                                      false; // إيقاف التحميل بعد اكتمال العملية

                                  if (codeDiscount
                                          .discountCodeList.isNotEmpty &&
                                      codeDiscount.discountCodeList[0]
                                              ["DiscountValue"] ==
                                          0) {
                                    // خصم كنسبة مئوية
                                    // widget.DiscountPercent = codeDiscount.discountCodeList[0]["DiscountPercent"];
                                    // widget.discountValue = ((widget.DiscountPercent / 100) * totalPrice);
                                    widget.DiscountPercent = codeDiscount
                                        .discountCodeList[0]["DiscountValue"];
                                    widget.discountValue =
                                        (codeDiscount.discountCodeList[0]
                                            ["DiscountValue"]);
                                  } else {
                                    // خصم بقيمة ثابتة
                                    widget.discountValue = codeDiscount
                                        .discountCodeList[0]["DiscountValue"];
                                  }

                                  roundedFinalPrice = ((totalPrice -
                                          widget.discountValue) +
                                      ((totalPrice >= 20)
                                          ? 0
                                          : ((UserPhone == null)
                                              ? widget.DeliveryValue
                                              : double.parse(
                                                  deleveryValue ?? '1.00'))));

                                  FinalPrice = double.parse(
                                      roundedFinalPrice.toStringAsFixed(3));

                                  print(
                                      'Updated discount list: ${codeDiscount.discountCodeList}');
                                });
                              }).catchError((error) {
                                setState(() {
                                  codeDiscount.isLoading =
                                      false; // إيقاف التحميل في حالة الخطأ
                                });
                              });
                            }
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5),
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
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'تفعيل'
                                        : 'Apply',
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
              );
  }

  Column item3(AppModel lang) {
    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isTodayActive = 1;
                                    todayName =
                                        DateFormat.EEEE().format(today);
                                    todayDate = DateFormat('yyyy-MM-dd')
                                        .format(today);
                                    selectedCardIndex = 100;
                                    DeliveryId = 100;
                                    checkTimeNotFound = true;
                                  });
                                  print('$todayName, التاريخ: $todayDate');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: isTodayActive == 1
                                        ? Colors.orange
                                        : Colors.white,
                                    border: Border.all(
                                      color: Colors.orange,
                                      width: 1.5,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Center(
                                    child: Text(
                                      (lang.activeLanguage.languageCode ==
                                              'ar')
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
                                    todayName =
                                        DateFormat.EEEE().format(tomorrow);
                                    todayDate = DateFormat('yyyy-MM-dd')
                                        .format(tomorrow);
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
                                    color: isTodayActive == 2
                                        ? Colors.orange
                                        : Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Center(
                                    child: Text(
                                      (lang.activeLanguage.languageCode ==
                                              'ar')
                                          ? '${Day[DateFormat.EEEE().format(tomorrow)]}'
                                          : DateFormat.EEEE()
                                              .format(tomorrow),
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

                                return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: listTimeDelivery
                                        .dataTimeDeliveryList.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 3.7,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 5,
                                    ),
                                    itemBuilder: (context, index) {
                                      final startTime = DateTime.parse(
                                          listTimeDelivery
                                                  .dataTimeDeliveryList[index]
                                              ["StartTime"]);
                                      final endTime = DateTime.parse(
                                          listTimeDelivery
                                                  .dataTimeDeliveryList[index]
                                              ["EndTime"]);
                                      final formattedStartTime =
                                          DateFormat('hh:mm a')
                                              .format(startTime)
                                              .replaceAll('AM', 'ص')
                                              .replaceAll('PM', 'م');
                                      final formattedEndTime =
                                          DateFormat('hh:mm a')
                                              .format(endTime)
                                              .replaceAll('AM', 'ص')
                                              .replaceAll('PM', 'م');

                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            DeliveryId = listTimeDelivery
                                                    .dataTimeDeliveryList[
                                                index]["ID"];

                                            print(
                                                "Delivery ID =>>>>>>>> $selectedTime");

                                            selectedTime =
                                                '${DateFormat('hh:mm a').format(DateTime.parse(listTimeDelivery.dataTimeDeliveryList[index]["StartTime"]))} \u00B7 ${DateFormat('hh:mm a').format(DateTime.parse(listTimeDelivery.dataTimeDeliveryList[index]["EndTime"]))}';
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: selectedCardIndex == index
                                                ? Colors.orange
                                                : Colors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '$formattedStartTime \u00B7 $formattedEndTime',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Monadi',
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              })
                            : Consumer(builder: (context, ref, child) {
                                final listTimeTomorowDelivery = ref.watch(
                                    getDataTimeDeliveryTomorowProvider);
                                //  selectedDistrict ??= listAddress.dataAddressList.first;
                                print(
                                    "listTimeTomorowDelivery.dataTimeDeliveryTomorowList${listTimeTomorowDelivery.dataTimeDeliveryTomorowList}");
                                return GridView.builder(
                                    itemCount: listTimeTomorowDelivery
                                        .dataTimeDeliveryTomorowList.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 3.7,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 5,
                                    ),
                                    itemBuilder: (context, index) {
                                      final startTime = DateTime.parse(
                                          listTimeTomorowDelivery
                                                  .dataTimeDeliveryTomorowList[
                                              index]["StartTime"]);
                                      final endTime = DateTime.parse(
                                          listTimeTomorowDelivery
                                                  .dataTimeDeliveryTomorowList[
                                              index]["EndTime"]);
                                      final formattedStartTime =
                                          DateFormat('hh:mm a')
                                              .format(startTime)
                                              .replaceAll('AM', 'ص')
                                              .replaceAll('PM', 'م');
                                      final formattedEndTime =
                                          DateFormat('hh:mm a')
                                              .format(endTime)
                                              .replaceAll('AM', 'ص')
                                              .replaceAll('PM', 'م');

                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            DeliveryId = listTimeTomorowDelivery
                                                    .dataTimeDeliveryTomorowList[
                                                index]["ID"];

                                            selectedTime =
                                                '${DateFormat('hh:mm a').format(DateTime.parse(listTimeTomorowDelivery.dataTimeDeliveryTomorowList[index]["StartTime"]))} \u00B7 ${DateFormat('hh:mm a').format(DateTime.parse(listTimeTomorowDelivery.dataTimeDeliveryTomorowList[index]["EndTime"]))}';
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: selectedCardIndex == index
                                                ? Colors.orange
                                                : Colors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '$formattedStartTime \u00B7 $formattedEndTime',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Monadi',
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                      ],
                    );
  }

  Row item2(AppModel lang) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
//now deliverytime
                  Radio<String>(
                    value: "1",
                    groupValue: selcetoption,
                    onChanged: (value) {
                      setState(() {
                        selcetoption = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 0),
                  Text(
                    (lang.activeLanguage.languageCode == 'ar')
                        ? 'التوصيل لاحقا'
                        : 'Delivery later',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              );
  }

  Column item1(AppModel lang) {
    return Column(
                children: [
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      final isNowInDeliveryTime = ref
                          .watch(getDataTimeDeliverynowProvider)
                          .isNowInDeliveryTime;

                      if (!isNowInDeliveryTime) {
                        return const SizedBox();
                      }

                      return Row(
                        children: [
                          Radio<String>(
                            value: "2",
                            groupValue: selcetoption,
                            onChanged: (value) {
                              setState(() {
                                final now = DateTime.now();
                                final formattedNow = DateFormat('hh:mm a')
                                    .format(now)
                                    .replaceAll('AM', 'ص')
                                    .replaceAll('PM', 'م');
                                final formattedEnd = DateFormat('hh:mm a')
                                    .format(now.add(Duration(
                                        hours:
                                            0))) // تقدر تغير المدة هنا لو حبيت
                                    .replaceAll('AM', 'ص')
                                    .replaceAll('PM', 'م');

                                selectedTime =
                                    '$formattedNow \u00B7 $formattedEnd';
                                checkTimeNotFound = true;
                                DeliveryId = 100;
                                selcetoption = value!;
                                isTodayActive = 1;
                                selectedCardIndex = 100;
                                todayName = DateFormat.EEEE().format(today);
                                todayDate =
                                    DateFormat('yyyy-MM-dd').format(now);
                                print("checkTimeNotFound$checkTimeNotFound");
                                print('$todayName, التاريخ: $todayDate');
                              });
                            },
                          ),
                          Text(
                            (lang.activeLanguage.languageCode == 'ar')
                                ? 'التوصيل الان'
                                : 'Delivery Now',
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
              );
  }


}


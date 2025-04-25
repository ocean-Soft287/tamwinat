import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import '../../../../../../../main.dart';
import '../../../../../../riverpod/gh.dart';
import '../../../../../components/buttons/main_confirm_button.dart';
import '../../../../../theme/app_colors.dart';
import '../../wallet/view/wallet_screen.dart';
import '../../../shop/cart/checkout/oneSystem/checkoutOneSystem.dart';
import '../manager/get_subscribtions_riverpod.dart';
import '../manager/tamwenat_pro_riveverpod.dart';

class TamwenateProView extends ConsumerStatefulWidget  {
  final dynamic dataUser; // قم بإضافة البارامتر هنا

  TamwenateProView({Key? key, required this.dataUser}) : super(key: key);
  @override
  _TamwenateProViewState createState() => _TamwenateProViewState();
}

class _TamwenateProViewState extends ConsumerState<TamwenateProView> {
  int selectedOption = 1;
  int selectedCardIndex = 0;
  int selectedOptionPaymentId = 4;
  String? _response = '';
  MFInitiateSessionResponse? session;
  bool agreedToTerms = false;
  List<MFPaymentMethod> paymentMethods = [];
  List<bool> isSelected = [];
  int selectedPaymentMethodIndex = -1;
  bool paymentSuccess = false;
  bool isSelectValue = false;
  String amount = '5.00';

  late MFCardPaymentView mfCardView;
  late MFApplePayButton mfApplePayButton;

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
    });
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
        invoiceAmount: double.parse(amount.toString()),
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
  } // initiate();

  void initState() {
    super.initState();
    initiate(); ref.read(getTmwenatProProvider.notifier).getTamwenatProProduct();
    ref.read(getSubscriptionProvider).getSubscription();

  }

  String getTitle(int id) {
    switch (id) {
      case 1:
        return 'شهر';
      case 2:
        return 'شهرين';
      case 3:
        return 'ثلاث شهور';
      case 4:
        return 'اربع شهور';
      case 5:
        return 'خمس شهور';
      case 6:
        return 'ست شهور';
      case 7:
        return 'سبع شهور';
      case 8:
        return 'تمان شهور';
      case 9:
        return 'تسع شهور';
      case 10:
        return 'عشر شهور';
      case 11:
        return 'حداشر شهر';
      case 12:
        return 'اتناشر شهر';
      default:
        return 'غير معروف';
    }
  }
  String getDescription(int id,String lang) {
    int days = id * 30;
    bool isArabic =lang  == 'ar';

    return isArabic
        ? 'سيتم التوصيل لمدة $days يوم مجانًا'
        : 'Delivery will be free for $days days';
  }
  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
  }
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        final itemList = ref.watch(getTmwenatProProvider);
        final appModel = ref.watch(appModelProvider);
      final getSubscriptionDelivery = ref.watch(getSubscriptionProvider);
        return Scaffold(
          backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: ClipRRect(
                child: AppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  elevation: 0.0,
                  title: InkWell(
                    onTap: (){
                      print(getSubscriptionDelivery.subscriptionList);
                    },
                    child: const Text(
                      'اختر الاشتراك الانسب لك',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Monadi',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  centerTitle: true,
                ),
              ),
            ),
            body:

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // لون خلفية خفيف
                        borderRadius: BorderRadius.circular(10), // زوايا دائرية
                      ),
                      child: getSubscriptionDelivery.subscriptionList.isNotEmpty
                          ? Text(
                        getSubscriptionDelivery.subscriptionList.first['IsSubscribe'] == true
                            ? '👋 أهلاً ${getSubscriptionDelivery.subscriptionList.first['CustomerName']}\n'
                            'ينتهي اشتراكك في **تموينات برو** بتاريخ ${formatDate(getSubscriptionDelivery.subscriptionList.first['EndDate'])}.'
                            : '👋 أهلاً ${getSubscriptionDelivery.subscriptionList.first['CustomerName']}\n'
                            'أنت لست مشتركًا في **خدمة تموينات برو**.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Monadi',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      )
                          : Text(

                        '👋 أهلاً ${widget.dataUser['ArabicName']}\n'
                      'أنت لست مشتركًا في **خدمة تموينات برو**.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Monadi',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),


                20.verticalSpace,
                GridView.builder(
                  itemCount: itemList.TamwenatProList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedCardIndex = index;
                          isSelectValue=true;
                        });
                        itemList.changeSelect(index);

                        print( itemList.TamwenatProList);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: itemList.SelectIndex == index
                              ? Colors.green
                              : Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                getTitle(itemList.TamwenatProList[index]['ID']),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monadi',
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                itemList.TamwenatProList[index]['Value']
                                    .toStringAsFixed(3),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Monadi',
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                20.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    getDescription( itemList.TamwenatProList[selectedCardIndex]['ID'],( appModel.activeLanguage
                              .languageCode ==
                          'ar')?'ar':'En'),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                      color: Colors.black,
                    ),
                  ),
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: agreedToTerms,
                      onChanged: (value) {
                        setState(() {
                          agreedToTerms = value ?? false;
                        });
                      },
                    ),
                    Text((appModel.activeLanguage.languageCode == 'ar')
                        ? 'أوافق على الشروط والأحكام'
                        : 'I agree to the terms and conditions'
                    ,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        fontFamily: 'Monadi',
                        color: AppColors.black,
                      ),

                    ),
                  ],
                ),
                20.verticalSpace,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 1,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                  });
                                },
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                              ),
                              5.horizontalSpace,
                              Text(
                                (appModel.activeLanguage.languageCode == 'ar')
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
                            width: 40,
                          )
                        ],
                      ),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 2,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                  });
                                },
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                              ),
                              const SizedBox(width: 0),
                              5.horizontalSpace,
                              Text(
                                (appModel.activeLanguage.languageCode == 'ar')
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
                            width: 40,
                          )
                        ],
                      ),
                      10.verticalSpace,
                      if(Platform.isIOS)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 24,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                  });
                                },
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                              ),
                              5.horizontalSpace,
                              Text(
                                (appModel.activeLanguage.languageCode == 'ar')
                                    ? 'ابل باى'
                                    : 'Apple Pay (KWD)',
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
                            'https://portal.myfatoorah.com/imgs/payment-methods/ap.png',
                            width: 40,
                          )
                        ],
                      ),
                      10.verticalSpace,
                      if(Platform.isAndroid)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: 26,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                  });
                                },
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                              ),
                              5.horizontalSpace,
                              Text(
                                (appModel.activeLanguage.languageCode == 'ar')
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
                            width: 40,
                          )
                        ],
                      ),
                      40.verticalSpace,
                      Consumer(builder: (context, ref, child) {
                        return MainConfirmButton(
                            background: Colors.orange,
                            title:
                                (appModel.activeLanguage.languageCode == 'ar')
                                    ? 'دفع '
                                    : 'Pay',
                            onTap: () async {
                              if (agreedToTerms==true && isSelectValue==true) {

        var request = MFExecutePaymentRequest(
        customerMobile: UserPhone,
        paymentMethodId: selectedOption,
        invoiceValue:  itemList.Amount);
        request.displayCurrencyIso =
        MFCurrencyISO.KUWAIT_KWD;
        await MFSDK.executePayment(
        request, MFLanguage.ARABIC, (invoiceId) {
        log(invoiceId);
        }).then((value) {
          itemList.createDeliverySubscription(valueAmount:itemList.Amount,period: itemList.TamwenatProList[selectedCardIndex]["Perioud"]);
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) =>
        DepositSuccessScreen(),
        ),
        );
        }).catchError((error) => {
        log(error.message),
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) =>
        DepositErrorScreen(
        title: 'العودة الى تنفيذ الطلب',
        ),
        ),
        )
        });
        }


                              else {

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor:
                                  Colors.red,
                                    content: Text(
                                      (isSelectValue)?'يرجى اختيار باقه الاشتراك':
                                      'يرجى الموافقه على الشروط والاحكام',
                                    )));
                              }
                            }

                            );
                      })
                    ],
                  ),
                )
              ],
            ));
      }),
    );
  }
}

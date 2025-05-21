
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/wallet/view/previous_transaction_wallet_screen.dart';

import '../../../../../../../main.dart';
import '../../../../../../riverpod/gh.dart';
import '../../../../../components/buttons/main_confirm_button.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../pages.dart';
import '../../../shop/cart/checkout/oneSystem/checkoutOneSystem.dart';
import '../manager/wallet_riverpod.dart';

class WalletScreen extends ConsumerStatefulWidget {

  var PaymentMethod;
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  bool button = false;
  int selectedOption = 1;
  var amountController = TextEditingController();
  var keyForm = GlobalKey<FormState>();
  int selectedOptionPaymentId = 4;
  MFInitiateSessionResponse? session;

  List<MFPaymentMethod> paymentMethods = [];
  List<bool> isSelected = [];
  int selectedPaymentMethodIndex = -1;
  bool paymentSuccess = false;

  String amount = '5.00';
  int? selectedCardIndex;
  late MFCardPaymentView mfCardView;
  // late MFApplePayButton mfApplePayButton;

  initiate() async {
    if (liveAPIKey.isEmpty) {
      setState(() {
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
    initiate();
    ref.read(getWalletApiProvider.notifier).getWalletAmount();
  }
  List <Map<String,dynamic>> moneyRechargeCards=[
    {
     'money_AR':'5 د.ك' ,
      'money_EN':'5 K.D' ,
      'amount':'5',
    }, {
      'money_AR':'10 د.ك' ,
      'money_EN':'10 K.D' ,
      'amount':'10',
    },
    {
      'money_AR':'20 د.ك' ,
      'money_EN':'20 K.D' ,
      'amount':'20',
    },
    {
      'money_AR':'50 د.ك' ,
      'money_EN':'50 K.D' ,
      'amount':'50',
    },
    {
      'money_AR':'75 د.ك' ,
      'money_EN':'75 K.D' ,
      'amount':'75',
    },
    {
      'money_AR':'100 د.ك' ,
      'money_EN':'100 K.D' ,
      'amount':'100',
    },
    {
      'money_AR':'150 د.ك' ,
      'money_EN':'150 K.D' ,
      'amount':'150',
    },
    {
      'money_AR':'200 د.ك' ,
      'money_EN':'200 K.D' ,
      'amount':'200',
    }, {
      'money_AR':'250 د.ك' ,
      'money_EN':'250 K.D' ,
      'amount':'250',
    }

  ];
  @override
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.orange,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.white,
          ),
        ),
        actions: [IconButton(onPressed:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PreviousTransactionWallet()),
            );

        }, icon:const Icon( Icons.add_card_outlined,color: Colors.white,))],
        elevation: 0.0,
        title: Text(
          (appModel.activeLanguage.languageCode == 'ar') ? "المحفظة" : "Wallet",
          style: TextStyle(
              fontFamily: 'Monadi',
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
        
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                20.verticalSpace,
                Consumer(builder: (context, ref, child) {
                  final getAmount = ref.watch(getWalletApiProvider);
                  return
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
        
                    children: [
                      Text(
                        (getAmount.amountValueList.isNotEmpty)
                            ? '${getAmount.amountValueList[0]['Balance'].toStringAsFixed(3)}'
                            : '0.000',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 5.0.w),
        
                      Text(
                        (appModel.activeLanguage.languageCode == 'ar')
                            ? 'د.ك'
                            : 'K.D',
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.white,
                          fontFamily: 'Monadi',
                        ),
                      ),
                    ],
                  );
                }),
                Text(
                  (appModel.activeLanguage.languageCode == 'ar')
                      ? 'الرصيد المتوفر'
                      : 'Available balance',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    fontFamily: 'Monadi',
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (appModel.activeLanguage.languageCode == 'ar')
                          ? '  يرجى اختيار من بطاقات تعبئه الرصيد '
                          : 'Please choose from the available recharge cards',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Monadi',
                          color: Colors.black
                      ),
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.arrow_drop_down, size: 28),
                    //   onPressed: () {
                    //     setState(() {button = !button;
                    //     });
                    //   },
                    // ),
                    20.verticalSpace,
                    SizedBox(
                      height: 220.h,
                      child: GridView.builder(
                          itemCount: moneyRechargeCards.length,

                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  selectedCardIndex = index;
                                  amountController.text= moneyRechargeCards[index]["amount"];
                                });

                              },
                              child: Container(

                                padding: const EdgeInsetsDirectional.all(5),

                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width:1,
                                  ),

                                  borderRadius: BorderRadius.circular(15),
                                  color:selectedCardIndex == index ? Colors.green :Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    (appModel.activeLanguage.languageCode == 'ar')
                                        ? moneyRechargeCards[index]["money_AR"]
                                        :moneyRechargeCards[index]["money_EN"],
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Monadi',
                                        color:Colors.black
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),




                    Form(
                      key: keyForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (appModel.activeLanguage.languageCode == 'ar')
                                ? 'او ادخل المبلغ المراد ايداعه'
                                : ' ادخل المبلغ المراد ايداعه',
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Monadi',
                                color: Colors.black
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (appModel
                                      .activeLanguage.languageCode ==
                                      'ar')
                                      ? 'هذا الحقل مطلوب'
                                      : 'This field is required';
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                // fontFamily: 'Monadi',
                                // color: AppColors.black,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(

                                hintText: ' ادخل المبلغ المراد ايداعه  ',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14.sp,
                                  fontFamily: 'Monadi',
                                  color: Colors.grey,
                                ),

                                border:
                                OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                  fontFamily: 'Monadi',
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                          40.verticalSpace,
                          Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    visualDensity: const VisualDensity(
                                        horizontal: -4, vertical: -4),
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
                              Image.network('https://portal.myfatoorah.com/imgs/payment-methods/kn.png',width: 40,)
                            ],
                          ),
                          10.verticalSpace,
                          Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    visualDensity: const VisualDensity(
                                        horizontal: -4, vertical: -4),
                                  ),
                                  SizedBox(width: 0),
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
                              Image.network('https://portal.myfatoorah.com/imgs/payment-methods/vm.png',width: 40,)
                            ],
                          ),
                          10.verticalSpace,
                          if(Platform.isIOS)
                          Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    visualDensity: const VisualDensity(
                                        horizontal: -4, vertical: -4),
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
                              Image.network('https://portal.myfatoorah.com/imgs/payment-methods/ap.png',width: 40,)
                            ],
                          ),
                          10.verticalSpace,
                          if(Platform.isAndroid)
                          Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
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
                              Image.network('https://portal.myfatoorah.com/imgs/payment-methods/gp.png',width: 40,)
                            ],
                          ),
                        ],
                      ),
                    ),


                    40.verticalSpace,

                    Consumer(builder: (context, ref, child) {
                      final getAmountDeposit =
                      ref.watch(getWalletApiProvider);
                      return MainConfirmButton(
                          background: Colors.orange,
                          title:
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'دفع '
                              : 'Pay',
                          onTap: () async {
                            if (keyForm.currentState!.validate()) {
                              var request = MFExecutePaymentRequest(
                                  customerMobile: UserPhone,
                                  paymentMethodId: selectedOption,
                                  invoiceValue:
                                  double.parse(amountController.text));
                              request.displayCurrencyIso =
                                  MFCurrencyISO.KUWAIT_KWD;
                              await MFSDK.executePayment(
                                  request, MFLanguage.ARABIC, (invoiceId) {
                                log(invoiceId);
                              }).then((value) {
                                getAmountDeposit.depositValue(
                                    deposit_value: amountController.text,
                                    context: context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DepositSuccessScreen(),
                                  ),
                                );
                              }).catchError((error) {
                                log(error.message);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DepositErrorScreen(title: 'العودة الى المحفظة'),
                                  ),
                                );
                              });

                            }
                          });
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DepositSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('عملية ايداع ناجحه',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Monadi',
                fontSize: 16.sp,
              )),
          20.verticalSpace,
          Image.asset(width: 60, 'assets/images/all/Success.jpg'),
          20.verticalSpace,
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Text('لقد تمت عملية الايداع بنجاح',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Monadi',
                      )),
                  5.verticalSpace,
                  Text(' ناجحه',
                      style: TextStyle(
                        color: Colors.green,
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
            );
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
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Text(
                        'العودة الى الصفحه الرئسية',
                        style: TextStyle(
                            fontSize: 18.sp,
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

class DepositErrorScreen extends StatelessWidget {
  String? title;
  DepositErrorScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('عملية لم تنجح',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Monadi',
                fontSize: 16,
              )),
          20.verticalSpace,
          Image.asset(width: 60, 'assets/images/all/paymentField.jpg'),
          20.verticalSpace,
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Text('لقد تم رفض عملية الدفع ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Monadi',
                      )),
                  5.verticalSpace,
                  Text('ليست ناجحه',
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
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Text(
                        '${title}',
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

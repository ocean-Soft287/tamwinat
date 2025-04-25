
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../riverpod/gh.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../pages.dart';
import '../manager/wallet_poinets_reiverpod.dart';

class WalletMyPointsView extends ConsumerStatefulWidget {
  const WalletMyPointsView({super.key});

  @override
  _WalletMyPointsViewState createState() => _WalletMyPointsViewState();
}

class _WalletMyPointsViewState extends ConsumerState<WalletMyPointsView> {

  void initState() {

    ref.read(walletPointsProvider.notifier).getWalletPoints();
  }
  @override
  Widget build(BuildContext context) {
    final appLang = ref.watch(appModelProvider);
    final walletPoints = ref.watch(walletPointsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        elevation: 0.0,
        // title: Column(
        //   children: [
        //     InkWell(
        //       onTap: () {
        //         print(walletPoints.walletPointsList[0]);
        //       },
        //       child: Text(
        //         (walletPoints.walletPointsList[0].isNotEmpty)
        //             ? '${walletPoints.walletPointsList[0]['PointsBalance'].toStringAsFixed(3)}'
        //             : '',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontFamily: 'Monadi',
        //           fontWeight: FontWeight.bold,
        //           fontSize: 20.sp,
        //         ),
        //       ),
        //     ),
        //     Text(
        //       (appLang.activeLanguage.languageCode == 'ar') ? 'نقاطى' : 'My Points',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontFamily: 'Monadi',
        //         fontWeight: FontWeight.bold,
        //         fontSize: 20.sp,
        //       ),
        //     ),
        //   ],
        // ),
        centerTitle: true,
      ),
      body:
      (walletPoints.walletPointsList.isEmpty)
          ? FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)), // Loading لمدة 3 ثوانٍ
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const CircularProgressIndicator(
                color: Colors.orange,
                 backgroundColor: Colors.white,
                 ),
                  const SizedBox(height: 20),
                  Text(
                    (appLang.activeLanguage.languageCode == 'ar')
                        ? 'جاري التحميل...'
                        : 'Loading...',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontFamily: 'Monadi',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            // عرض رسالة الخطأ بعد انتهاء مدة التحميل
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/lottie/error.json', // ملف Lottie للخطأ
                    height: 300,
                    repeat: true,
                    animate: true,
                  ),
                ),
                Text(
                  (appLang.activeLanguage.languageCode == 'ar')
                      ? 'حدثت مشكلة، حاول في وقت لاحق'
                      : 'An error occurred, please try again later',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    fontFamily: 'Monadi',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }
        },
      )
      :
      Column(
        children: [
          10.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: Row(
                children: [
                  Text(
                    (appLang.activeLanguage.languageCode == 'ar')
                        ? 'رصيد النقاط'
                        : 'Transfer cash to the wallet',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                    ),
                  ),
                  const Spacer(),
                  Text(
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                    ),
                    (walletPoints.walletPointsList[0].isNotEmpty)
                        ? '${walletPoints.walletPointsList[0]['PointsBalance'].toStringAsFixed(3)}'
                        : '',
                  )
                ],
              ),
            ),
          ),
          20.verticalSpace,
          InkWell(
            onTap: () {
              if (walletPoints.walletPointsList[0]['PointsValue'] > 0) {

                walletPoints.updateCustomerWalletValue(context: context);


                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const MainPage(),
                //   ),
                // );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('رصيد نقاطك لا يكفى '),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    (appLang.activeLanguage.languageCode == 'ar')
                        ? 'تحويل للمحفظة'
                        : 'Transfer cash to the wallet',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Monadi',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ButtonComponet extends StatelessWidget {
  String text;
  int selectIndex;
  int itemIndex;
   ButtonComponet({super.key,required this.text,required this.selectIndex,required this.itemIndex});



  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(20),
        color: (selectIndex==itemIndex)?  Colors.orange:Colors.white ,
        border: Border.all(
          color:Colors.orange,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical:2),
      child: Text(text,style: TextStyle(
        fontSize: 13.sp,
color:(selectIndex==itemIndex)?Colors.white: Colors.black,
        fontWeight: FontWeight.w300,
        fontFamily: 'Monadi',
      ),
        textAlign:TextAlign.center,
        maxLines: 2,),
    );
  }
}
Widget getWidgetBasedOnCondition(int condition) {
  switch (condition) {
    case 1:
      return const Text(
        'This is a Text Widget',
        style: TextStyle(fontSize: 24),
      );
    case 2:
      return Icon(
        Icons.star,
        size: 50,
        color: Colors.yellow,
      );
    case 3:
      return ElevatedButton(
        onPressed: () {},
        child: Text('This is a Button'),
      );
    default:
      return Text(
        'Default Widget',
        style: TextStyle(fontSize: 24),
      );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../riverpod/gh.dart';
import '../../../../../components/app_bars/common_appbar.dart';
import '../../../../../theme/app_colors.dart';
import '../manager/previous_transactions_wallet_riverpod.dart';
class PreviousTransactionWallet extends StatelessWidget {
  const PreviousTransactionWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer(builder: (context, ref, child) {
      final getPreviousTransaction =
      ref.watch(getPreviousTransactionWalletProvider);

      final lang = ref.watch(appModelProvider);  return Scaffold(

          backgroundColor: AppColors.white.withOpacity(0.9),
          appBar: CommonAppBar(
            title:    (lang.activeLanguage.languageCode == 'ar') ? "المعاملات السابقه" :  "Previous Transactions",
            onLeadingPressed: () => context.popRoute(),
          ),

          body:
         //  InkWell(onTap: (){
         //
         // print(   getPreviousTransaction.previousTransactionList);
         //
         //  },child:
         //
         //
         //  Row(
         //    children: [
         //      Column(
         //        children: [
         //          Text('${getPreviousTransaction.startDate}'),
         //          ElevatedButton(
         //            onPressed: () => getPreviousTransaction.getStartDate(context),
         //            child: const Text(
         //              'تاريخ البدايه',
         //              style: TextStyle(color: Colors.white),
         //            ),
         //          ),
         //        ],
         //      ),
         //
         //      Column(
         //        children: [
         //          Text('${getPreviousTransaction.endDate}'),
         //          ElevatedButton(
         //            onPressed: () => getPreviousTransaction.getEndDate(context),
         //            child: const Text(
         //              'تاريخ النهايه',
         //              style: TextStyle(color: Colors.white),
         //            ),
         //          ),
         //        ],
         //      ),
         //
         //      InkWell(onTap: (){
         //        getPreviousTransaction.getPreviousTransaction(startDate: getPreviousTransaction.startDate, endDate:getPreviousTransaction.endDate);
         //
         //      },child: Text('Apply'))
         //    ],
         //  )
         //
         //
         //
         //
         //  ),
          Container(

            child: Column(children: [
              Flexible(
                child: ConditionalBuilder(
                    condition:getPreviousTransaction.previousTransactionList.isNotEmpty ,
                    builder: (context){
                      return  ListView.builder(
                          itemCount: getPreviousTransaction.previousTransactionList.length,

                          itemBuilder:(context,index)
                          {
                            return
                              Container(
                                margin: const EdgeInsetsDirectional.all(2),
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(

                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                height: 80.h,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                              
                                    Stack(
                              
                                      children: [
                                        Container(margin: const EdgeInsets.symmetric(horizontal: 5),decoration: BoxDecoration(color: Colors.orange.withOpacity(.2),borderRadius: BorderRadius.circular(15)),padding: const EdgeInsets.all(10),child: const Icon( Icons.add_card_outlined,color: Colors.orange,)),
                                       Container(
                                        padding: const EdgeInsetsDirectional.all(1),
                                         decoration: BoxDecoration(
                                             color: Colors.blue,borderRadius: BorderRadius.circular(15)
                                         ),
                                          child: RotatedBox(
                                         quarterTurns:(getPreviousTransaction.previousTransactionList[index]['Credit']==0.0)? 3:1,
                                         child: const Icon(
                                           Icons.arrow_back_sharp,
                                           size: 18,
                                           color: Colors.white,
                                         ),
                                       ))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          Text(
                              
                                                '${getPreviousTransaction.previousTransactionList[index]['Debit'].toStringAsFixed(3)}',
                                            style: GoogleFonts.tajawal(
                                              fontSize:
                                              15.sp,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),),
                                          5.horizontalSpace,
                                          Text(
                                            (lang.activeLanguage.languageCode == 'ar')
                                                ? 'د.ك'
                                                : 'K.D',
                                            style: GoogleFonts.tajawal(
                                              fontSize:
                                              15.sp,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),),
                              
                              
                              
                                        ],),
                                        Text(
                                          (lang.activeLanguage.languageCode == 'ar')
                                              ? '${getPreviousTransaction.previousTransactionList[index]['InvoiceNumber']}'
                                              : '${getPreviousTransaction.previousTransactionList[index]['InvoiceNumber']}',
                                          style: GoogleFonts.tajawal(
                                            fontSize:
                                            12.sp,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),),
                                        5.verticalSpace,
                                        Expanded(
                                          child: Text(
                              
                                            DateFormat('d/M/yyyy').format(DateTime.parse(getPreviousTransaction.previousTransactionList[index]['Date'])),
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Monadi',
                                            ),
                                          )
                              
                                        ),
                              
                                      ],
                                    ),
                                  ],
                                ),
                              
                              );
                          }

                      );
                    },
                    fallback: (context){
                      return const Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.orange,),

                          ],
                        ),
                      );
                    }),
              )
            ],),
          )
        );
      }
    );
  }
}

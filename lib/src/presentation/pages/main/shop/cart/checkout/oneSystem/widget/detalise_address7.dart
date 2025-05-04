import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../main.dart';
import '../../../../../../../../riverpod/gh.dart';
import '../../../../../../../components/app_bars/common_appbar.dart';
import '../../../../../../../components/buttons/main_confirm_button.dart';
import '../../../../../../../theme/app_colors.dart';
import '../Controller/basct_shop_contrroller.dart';
import '../checkoutOneSystem.dart';
import 'add_address.dart';

class DetaliseAddress extends ConsumerStatefulWidget {
  const DetaliseAddress({super.key});

  @override
  _DetaliseAddressState createState() => _DetaliseAddressState();
}

class _DetaliseAddressState extends ConsumerState<DetaliseAddress> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref
        .read(getAddressFromApiProvider.notifier).getAddresss();
  }
  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(appModelProvider);

    final listAddressUser=ref.watch(getAddressFromApiProvider);
    final listItemOrder = ref.watch(orderProviderList);
    final listItemOrderImage = ref.watch(orderProviderListImage);


    return Scaffold(
      backgroundColor: AppColors.white.withOpacity(0.9),
      appBar: CommonAppBar(
        title: (lang.activeLanguage.languageCode == 'ar')? 'العنوان':'Address',
        onLeadingPressed: ()=> Navigator.pop(context),
      ),
      body:Column(
        children: [

      Expanded(
        child:
        ListView.builder(
        itemCount: listAddressUser.dataAddressList.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context,index)

              {
                final item=listAddressUser.dataAddressList[index];
                return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
              borderRadius: BorderRadius.circular(5),


            ),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text(
                      (lang.activeLanguage.languageCode == 'ar')
                          ? '${item["DistrictName"]}'
                          : 'K.D',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        fontFamily: 'Monadi',
                        color: AppColors.black,
                      )),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                          (lang.activeLanguage.languageCode == 'ar')?
                          ' الشارع ':
                          'Street:' ,
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),


                        ),
                        TextSpan(
                          text:
                          '${item["StreetName"]}',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                          (lang.activeLanguage.languageCode == 'ar')?
                          ' الجاده ':
                          'Gada:' ,
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),


                        ),
                        TextSpan(
                          text:
                          '${item["Gada"]}',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                          (lang.activeLanguage.languageCode == 'ar')?
                          ' المنزل ':
                          'House' ,
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),


                        ),
                        TextSpan(
                          text:
                          '${item["HouseNo"]}',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                          (lang.activeLanguage.languageCode == 'ar')?
                          ' القطعه ':
                          'Block:' ,
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),


                        ),
                        TextSpan(
                          text:
                          '${item["Gada"]}',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                          (lang.activeLanguage.languageCode == 'ar')?
                          'الدور ':
                          'Floor' ,
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),


                        ),
                        TextSpan(
                          text:
                          '${item["Floor"]}',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                          (lang.activeLanguage.languageCode == 'ar')?
                          ' الشقه ':
                          'Apartment' ,
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),


                        ),
                        TextSpan(
                          text:
                          '${item["Apartment"]}',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );}

        ),
      ),



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MainConfirmButton(background: Colors.orange,onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          CheckoutPageOne(
                        gada:listAddressUser.dataAddressList[0]["Gada"] ,
                        nameControllerCheckOutOnSystem:listAddressUser.dataAddressList[0]["ArabicName"] ,
                        mobileNumberControllerCheckOutOnSystem:listAddressUser.dataAddressList[0]["CustomerPhone"],
                        emailControllerCheckOutOnSystem:listAddressUser.dataAddressList[0]["Email"] ,
                        StreetControllerCheckOutOnSystem:listAddressUser.dataAddressList[0]["StreetName"]  ,
                        floorControllerCheckOutOnSystem:listAddressUser.dataAddressList[0]["Floor"]  ,
                        HouseControllerCheckOutOnSystem:listAddressUser.dataAddressList[0]["HouseNo"] ,
                        BlockNumberControllerCheckOutOnSystem:listAddressUser.dataAddressList[0]["Block"] ,

                        titleNotes:listAddressUser.dataAddressList[0]["AddressNotes"]  ,
                        apartmentControllerCheckOutOnSystem:listAddressUser.dataAddressList[0]["Apartment"]  ,

                        DeliveryValue: double.parse(DeliveryValue),


                        newmyList: listItemOrder.orderList,

                        ValueselectedDistrict: listAddressUser.dataAddressList[0]["DistrictName"],

                      )),

                    );

                  },title:(lang.activeLanguage.languageCode == 'ar')? 'تاكيد العنوان الحالى':'Confirm current address' ),

                  MainConfirmButton(background: Colors.orange,onTap: (){
                    Navigator.push(
                      context,

                      MaterialPageRoute(builder: (context) => AddAddress(newmyList: listItemOrder.orderList,imageList: listItemOrderImage.orderListImage,)),
                    );

                  },title:(lang.activeLanguage.languageCode == 'ar')? 'دخل عنوان جديد':'Enter New Address', ),
                ],
              ),
            ),

        ],
      ) ,
    );
  }
}

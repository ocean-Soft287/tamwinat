  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sundaymart/src/core/constants/app_assets.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/favorite/controler/favorite_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/home/on_system/controller/home_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/text_form_field_onsystem.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/details/banner_details/banner_details_page.dart';
import 'package:sundaymart/src/presentation/pages/pages.dart';
import 'package:sundaymart/src/presentation/theme/app_colors.dart';
import 'package:sundaymart/src/riverpod/gh.dart';

// ignore: must_be_immutable
class OfferItems extends ConsumerStatefulWidget  {
  List<List<bool>> isSecondContainerVisibleList2 ;
  TextEditingController customPhoneGuestController;
  dynamic UserPhoneAll;
  dynamic  UserPhone;
  GlobalKey<FormState> keyFormCheckOutOnSystem ;

   OfferItems({super.key,required this.UserPhone,required this.UserPhoneAll,required this.customPhoneGuestController,required this.isSecondContainerVisibleList2 ,required this.keyFormCheckOutOnSystem});

  @override
  ConsumerState<OfferItems> createState() => _OfferItemsState();
}

class _OfferItemsState extends ConsumerState<OfferItems> {

  @override

  Widget build(BuildContext context) {
          final appModel = ref.watch(appModelProvider);

    return Consumer(builder: (context, ref, child) {
            final getDataOferTwoFromApi =
            ref.watch(getDataOverTwoFromApiProvider);
            final listItemOrder = ref.watch(orderProviderList);
            final listItemOrderImage = ref.watch(orderProviderListImage);
            final getDataFavoriteFromApi = ref.watch(addItemFavoriteProvider);
            final deletFavorite = ref.watch(deleteItemFavoriteProvider);


              return


             ListView.separated(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context,index)
                    {
                      return const SizedBox(height: 5,);
                    },
                    itemCount: getDataOferTwoFromApi.overTwoList.length,
                    itemBuilder: (context,indexOne)
                    {
                      return   (getDataOferTwoFromApi.overTwoList.isEmpty||getDataOferTwoFromApi.overTwoList[indexOne]["ShowOffer"]==1)?
                          const SizedBox():
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              (appModel.activeLanguage.languageCode == 'ar')
                                  ? '${getDataOferTwoFromApi.overTwoList[indexOne]["OfferName"]??''}'
                                  : '${getDataOferTwoFromApi.overTwoList[indexOne]["OfferName"]??''}',
                              style: GoogleFonts.tajawal(
                                fontSize:
                                16.sp,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 230.h,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: getDataOferTwoFromApi.overTwoList[indexOne]["_OfferItems"].length,
                              itemBuilder: (context, index) {
                                final item =getDataOferTwoFromApi.overTwoList[indexOne]["_OfferItems"][index];
                                num q1 = listItemOrder.getQuantity(
                                    itemID: item['BarCode']??1);
                                num y = listItemOrder.getYGiftQty(itemID: item["BarCode"]??1);
                                return Card(
                                  color: Colors.white,
                                  child: Container(
                                    color: Colors.white,
                                    width: 200.w,
                                    child: InkWell(
                                      onTap: () {

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BannerDetailsPage(
                                                productId: item["ProductID"],
                                                CategoryId: item['CategoryId'],
                                                name: (appModel.activeLanguage
                                                    .languageCode ==
                                                    'ar')
                                                    ? item["ProductArName"]
                                                    : item['ProductEnName'],
                                                image: item['ProductcImage'],
                                                specification:
                                                item['Specification'],
                                              )),
                                        );
                                      },
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: REdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Stack(
                                                      alignment:
                                                      Alignment.bottomRight,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          height: 130,
                                                          child: Center(
                                                            child: Image.network(
                                                              '${item['ProductcImage']}',
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if((widget. UserPhoneAll??widget. UserPhone)==null)
                                                            {

                                                              showDialog(
                                                                context: context,
                                                                barrierDismissible: false,
                                                                builder: (_) => AlertDialog(

                                                                    content: Text(
                                                                      "يرجى ادخال رقم الهاتف",
                                                                      style: TextStyle(
                                                                        fontSize: 14.sp,
                                                                        color: const Color(0xff000000),
                                                                        fontWeight: FontWeight.w500,
                                                                        fontFamily: 'Monadi',
                                                                      ),
                                                                    ),
                                                                    actions: [

                                                                      Form(
                                                                        key:widget. keyFormCheckOutOnSystem,
                                                                        child: MyStyledTextField(
                                                                          maxLength: 8,
                                                                          keyboardType: TextInputType.phone,
                                                                          label:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',
                                                                          hintText:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',

                                                                          controller:widget. customPhoneGuestController,
                                                                          validator: (value) {
                                                                            if (value!.isEmpty) {
                                                                              return (appModel.activeLanguage.languageCode == 'ar')
                                                                                  ? 'هذا الحقل مطلوب'
                                                                                  : 'This field is required';
                                                                            } else if (value.length != 8 ||
                                                                                !(value.startsWith('4') ||
                                                                                    value.startsWith('5') ||
                                                                                    value.startsWith('6') ||
                                                                                    value.startsWith('9'))) {
                                                                              return (appModel.activeLanguage.languageCode == 'ar')
                                                                                  ? '  رقم الهاتف غير صحيح او الارقام لا تحتوي علي ارقام انجليزية يرجي التأكد   ا'
                                                                                  : 'The Mobile Number not correct please check the mobile number';
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                      20.verticalSpace,

                                                                      TextButton(
                                                                        style: ButtonStyle(
                                                                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                                            EdgeInsets.zero,
                                                                          ),
                                                                        ),
                                                                        onPressed: ()  {



                                                                          if(widget. keyFormCheckOutOnSystem.currentState!.validate()) {

                                                                          }
                                                                          if(widget. UserPhone==null)
                                                                          {
                                                                           widget. UserPhoneAll=widget. customPhoneGuestController.text;
                                                                          }
                                                                          else
                                                                          {
                                                                         widget.   UserPhoneAll=widget. UserPhone;
                                                                          }




                                                                          Navigator.pushReplacement(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => const MainPage(

                                                                              ),
                                                                            ),
                                                                          );

                                                                        },
                                                                        child: Container(
                                                                          width: 1.sw - 30,
                                                                          height: 40.r,
                                                                          alignment: Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                            color: Colors.orange,
                                                                            borderRadius: BorderRadius.circular(30),

                                                                          ),
                                                                          child:false
                                                                              ? SizedBox(
                                                                            height: 20.r,
                                                                            width: 20.r,
                                                                            child: CircularProgressIndicator(
                                                                              strokeWidth: 3.r,
                                                                              color: AppColors.white,
                                                                            ),
                                                                          )
                                                                              : Text(
                                                                            (appModel.activeLanguage.languageCode == 'ar')?

                                                                            "استمرار":'Continue ',
                                                                            style: GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12.sp,
                                                                              color: AppColors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              );

                                                            }
                                                            else
                                                            {
                                                              setState(() {
                                                              widget.  isSecondContainerVisibleList2[indexOne][
                                                                index] =
                                                              !widget.  isSecondContainerVisibleList2[indexOne][
                                                                index];
                                                                // isSecondContainerVisible =
                                                                // !isSecondContainerVisible;
                                                              });

                                                              setState(() {
                                                                if (q1 == 0) {
                                                                  q1++;

                                                                }
                                                                listItemOrder.addItem({
                                                                  "ItemID": item["ProductID"],
                                                                  "Quantity": q1,
                                                                  "Price": item[
                                                                  "PriceAfterDiscount"],
                                                                  "StockQuantity":
                                                                  item["StockQuantity"],
                                                                  "BarCode": item["BarCode"],
                                                                  "Colors_ID": '',
                                                                  "Size_ID": '',
                                                                  "RequiredQTY":item['RequiredQTY'],
                                                                  "GiftQTY":item['GiftQTY'],
                                                                  "Y_Gift_Qty":y,
                                                                });
                                                                listItemOrderImage.addItem({
                                                                  "image":
                                                                  item["ProductcImage"],
                                                                  "ItemID": item["ProductID"],
                                                                  "Quantity": q1,
                                                                  "Price": item[
                                                                  "PriceAfterDiscount"],
                                                                  "ProductArName":
                                                                  item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                  "ProductEnName":
                                                                  item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                  "StockQuantity":
                                                                  item["StockQuantity"],
                                                                  "CustomerQuantity":(item["CustomerQuantity"]> 0.0)?
                                                                  item["CustomerQuantity"]:item["CustomerQtyFree"],
                                                                  "BarCode": item["BarCode"],
                                                                  "Colors_ID": '',
                                                                  "Size_ID": '',
                                                                  "RequiredQTY":item['RequiredQTY'],
                                                                  "GiftQTY":item['GiftQTY'],
                                                                  "Y_Gift_Qty":y,
                                                                });
                                                              });

                                                              if ( widget. isSecondContainerVisibleList2[indexOne][
                                                              index]) {
                                                                Future.delayed(
                                                                    const Duration(
                                                                        milliseconds: 10000),
                                                                        () {
                                                                      setState(() {
                                                                       widget. isSecondContainerVisibleList2[indexOne][
                                                                        index] = false;
                                                                      });
                                                                    });
                                                              }
                                                            }


                                                          },
                                                          child:
                                                          !widget. isSecondContainerVisibleList2[indexOne][
                                                          index]
                                                              ? Card(
                                                            child: Container(
                                                              height: 40.h,
                                                              width: 35.w,
                                                              color: (q1 >= 1)
                                                                  ? Colors.green
                                                                  : Colors.white,
                                                              child: Center(
                                                                child: Text(
                                                                    (q1 >= 1)
                                                                        ? '$q1'
                                                                        : '+',
                                                                    style:
                                                                    TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontFamily: 'Monadi',
                                                                      fontSize:
                                                                      20.sp,
                                                                      color: (q1 >=
                                                                          1)
                                                                          ? Colors
                                                                          .white
                                                                          : Colors
                                                                          .orange,
                                                                    )),
                                                              ),
                                                            ),
                                                          )
                                                              : Container(
                                                              height: 40,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                        0.5),
                                                                    spreadRadius: 5,
                                                                    blurRadius: 7,
                                                                    offset: const Offset(
                                                                        0, 3),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      if (item["CustomerQuantity"] > 0.0)
                                                                      {
                                                                        if (item["CustomerQuantity"] >= item["StockQuantity"]) {
                                                                          if (q1 < item["StockQuantity"]) {
                                                                            setState(
                                                                                    () {
                                                                                  q1++;
                                                                                  if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                  {
                                                                                    if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                      q1 += item['GiftQTY'];
                                                                                      item["Y_Gift_Qty"]++;

                                                                                      y++;


                                                                                    }


                                                                                  }









                                                                                });
                                                                            listItemOrder
                                                                                .addItem({
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "StockQuantity":
                                                                              item["StockQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                            listItemOrderImage
                                                                                .addItem({
                                                                              "image":
                                                                              item["ProductcImage"],
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "ProductArName":
                                                                              item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                              "ProductEnName":
                                                                              item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                              "StockQuantity":
                                                                              item["StockQuantity"],
                                                                              "CustomerQuantity":
                                                                              item["CustomerQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                          }
                                                                        } else {
                                                                          if (q1 < item["CustomerQuantity"]) {
                                                                            setState(
                                                                                    () {
                                                                                  q1++;

                                                                                  if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                  {
                                                                                    if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                      q1 += item['GiftQTY'];
                                                                                      item["Y_Gift_Qty"]++;

                                                                                      y++;


                                                                                    }


                                                                                  }
                                                                                });
                                                                            listItemOrder
                                                                                .addItem({
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "StockQuantity":
                                                                              item["CustomerQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                            listItemOrderImage
                                                                                .addItem({
                                                                              "image":
                                                                              item["ProductcImage"],
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "ProductArName":
                                                                              item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                              "ProductEnName":
                                                                              item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                              "StockQuantity":
                                                                              item["CustomerQuantity"],
                                                                              "CustomerQuantity":
                                                                              item["CustomerQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                          }
                                                                        }
                                                                      }

                                                                      else  if (item["CustomerQtyFree"] > 0.0)
                                                                      {
                                                                        print('----------------------------------');
                                                                        print(item["CustomerQtyFree"]);
                                                                        print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');

                                                                        if (item["CustomerQtyFree"] >= item["StockQuantity"]) {
                                                                          if (q1 < item["StockQuantity"]) {
                                                                            setState(
                                                                                    () {
                                                                                  q1++;
                                                                                  if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                  {
                                                                                    if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                      q1 += item['GiftQTY'];
                                                                                      item["Y_Gift_Qty"]++;

                                                                                      y++;


                                                                                    }


                                                                                  }









                                                                                });
                                                                            listItemOrder
                                                                                .addItem({
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "StockQuantity":
                                                                              item["StockQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                            listItemOrderImage
                                                                                .addItem({
                                                                              "image":
                                                                              item["ProductcImage"],
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "ProductArName":
                                                                              item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                              "ProductEnName":
                                                                              item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                              "StockQuantity":
                                                                              item["StockQuantity"],
                                                                              "CustomerQuantity":
                                                                              item["CustomerQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                          }
                                                                        } else {
                                                                          if (q1 < item["CustomerQtyFree"]) {
                                                                            setState(
                                                                                    () {
                                                                                  q1++;

                                                                                  if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                  {
                                                                                    if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                      q1 += item['GiftQTY'];
                                                                                      item["Y_Gift_Qty"]++;

                                                                                      y++;


                                                                                    }


                                                                                  }
                                                                                });
                                                                            listItemOrder
                                                                                .addItem({
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "StockQuantity":
                                                                              item["CustomerQtyFree"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                            listItemOrderImage
                                                                                .addItem({
                                                                              "image":
                                                                              item["ProductcImage"],
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "ProductArName":
                                                                              item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                              "ProductEnName":
                                                                              item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                              "StockQuantity":
                                                                              item["CustomerQtyFree"],
                                                                              "CustomerQuantity":
                                                                              item["CustomerQtyFree"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                          }
                                                                        }
                                                                      }


                                                                      else {


                                                                        if (q1 < item["StockQuantity"]) {
                                                                          setState(
                                                                                  () {

                                                                                q1++;
                                                                                // print('Q1 $q1');


                                                                                if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                {
                                                                                  if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                    q1 += item['GiftQTY'];
                                                                                    item["Y_Gift_Qty"]++;

                                                                                    y++;


                                                                                  }


                                                                                }











                                                                              });
                                                                          listItemOrder
                                                                              .addItem({
                                                                            "ItemID":
                                                                            item["ProductID"],
                                                                            "Quantity":
                                                                            q1,
                                                                            "Price":
                                                                            item["PriceAfterDiscount"],
                                                                            "StockQuantity":
                                                                            item["StockQuantity"],
                                                                            "BarCode":
                                                                            item["BarCode"],
                                                                            "Colors_ID":
                                                                            '',
                                                                            "Size_ID":
                                                                            '',
                                                                            "RequiredQTY":item['RequiredQTY'],
                                                                            "GiftQTY":item['GiftQTY'],
                                                                            "Y_Gift_Qty":y,
                                                                          });
                                                                          listItemOrderImage
                                                                              .addItem({
                                                                            "image":
                                                                            item["ProductcImage"],
                                                                            "ItemID":
                                                                            item["ProductID"],
                                                                            "Quantity":
                                                                            q1,
                                                                            "Price":
                                                                            item["PriceAfterDiscount"],
                                                                            "ProductArName":
                                                                            item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                            "ProductEnName":
                                                                            item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                            "StockQuantity":
                                                                            item["StockQuantity"],
                                                                            "CustomerQuantity":
                                                                            item["CustomerQuantity"],
                                                                            "BarCode":
                                                                            item["BarCode"],
                                                                            "Colors_ID":
                                                                            '',
                                                                            "Size_ID":
                                                                            '',
                                                                            "RequiredQTY":item['RequiredQTY'],
                                                                            "GiftQTY":item['GiftQTY'],
                                                                            "Y_Gift_Qty":y,
                                                                          });
                                                                        }
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      '+',
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                        20.sp,
                                                                        color: Colors
                                                                            .orange,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontFamily:
                                                                        'Monadi',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Center(
                                                                    child: Text(
                                                                      '$q1',
                                                                      maxLines: 2,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                        16.sp,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                        fontFamily:
                                                                        'Monadi',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      if (q1 > 0) {
                                                                        setState(
                                                                                () {
                                                                              q1--;




                                                                            });
                                                                      }
                                                                      if (q1 ==
                                                                          0) {}
                                                                      listItemOrder
                                                                          .decreaseQuantity(
                                                                          item[
                                                                          "BarCode"]);
                                                                      listItemOrderImage
                                                                          .decreaseQuantity(
                                                                          item[
                                                                          "BarCode"]);
                                                                    },
                                                                    child: Text(
                                                                      '-',
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                        20.sp,
                                                                        color: Colors
                                                                            .orange,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontFamily:
                                                                        'Monadi',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        )
                                                      ]),
                                                ),
                                                4.verticalSpace,
                                                (item["DiscountPercent"] == 0)
                                                    ? Row(
                                                  children: [
                                                    Text(
                                                      ' ${item["PriceAfterDiscount"]??0000.toStringAsFixed(3)} ',
                                                      style: TextStyle(
                                                        fontSize:16.sp,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                    Text(
                                                      (appModel.activeLanguage
                                                          .languageCode ==
                                                          'ar')
                                                          ? 'د.ك'
                                                          : 'K.D',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                    : Row(
                                                  children: [
                                                    Text(
                                                      '${(item["PriceAfterDiscount"]).toStringAsFixed(3)}',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                    Text(
                                                      (appModel.activeLanguage
                                                          .languageCode ==
                                                          'ar')
                                                          ? 'د.ك'
                                                          : 'K.D',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                    10.horizontalSpace,
                                                    Text(
                                                      ' ${item["Price"].toStringAsFixed(3)}',
                                                      style: TextStyle(
                                                        decoration: TextDecoration
                                                            .lineThrough,
                                                        color: Colors.red,
                                                        decorationThickness: 12.0,
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                    Text(
                                                      'د.ك',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w600,
                                                        decoration: TextDecoration
                                                            .lineThrough,
                                                        color: Colors.red,
                                                        decorationThickness: 12.0,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                2.verticalSpace,
                                                Expanded(
                                                  child: Text(
                                                    (appModel.activeLanguage.languageCode ==
                                                        'ar')
                                                        ? '${item["ProductName"]} * ${item['UnitValue'].toString()}'
                                                        : '${item["ProductEnName"]} * ${item['UnitValue'].toString()}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Monadi',

                                                    ),

                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (item["DiscountPercent"] != 0)
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(

                                                color: Colors.red,
                                                child:
                                                Center(
                                                  child: Text(
                                                    '%${item["DiscountPercent"]}خصم',
                                                    style: GoogleFonts.tajawal(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),

                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (item['GiftQTY']!=0.0)
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(

                                                color: Colors.orange,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '${item['RequiredQTY']}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      ' + ${item['GiftQTY']} ',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Text(
                                                      'مجانا',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (item["StockQuantity"] == 0)
                                            Image.asset(AppAssets.OutOfStock),
                                          Positioned(
                                              top: 0,
                                              left: 0,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: item["IsFavorite"] == 1
                                                      ? Colors.red
                                                      : const Color.fromRGBO(
                                                      200, 200, 200, 1.0),
                                                ),
                                                onPressed: () {
                                                  if (item["IsFavorite"] == 0) {
                                                    getDataFavoriteFromApi
                                                        .AddItemFavoritePost(
                                                        CustomerPhone:
                                                        '${widget. UserPhone}',
                                                        ProductID:
                                                        item["ProductID"]
                                                            .toString());
                                                  } else {
                                                    deletFavorite
                                                        .DeleteItemFavoritePost(
                                                        ProductId:
                                                        item["ProductID"]
                                                            .toString());
                                                  }
                                                  setState(() {
                                                    item["IsFavorite"] =
                                                    item["IsFavorite"] == 1
                                                        ? 0
                                                        : 1;
                                                  });
                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },

                  )    ;

          });
  }


  }

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/text_form_field_onsystem.dart';
import '../../../../../../../../riverpod/gh.dart';
import '../../../../../../../components/app_bars/common_appbar.dart';
import '../../../../../../../theme/app_colors.dart';

import '../../../../../../pages.dart';
import '../Controller/basct_shop_contrroller.dart';

import '../checkoutOneSystem.dart';
import 'add_address.dart';
import 'detalise_address7.dart';

class BactShop extends ConsumerStatefulWidget {
  @override
  _BactShopState createState() => _BactShopState();
}

class _BactShopState extends ConsumerState<BactShop> {
  double totalPrice = 0.0;
  // var customPhoneGuestController = TextEditingController();
  // var keyFormCheckOutOnSystem = GlobalKey<FormState>();
  double calculateTotalPrice(List<Map<String, dynamic>> items) {
    double total = 0.0;

    for (var item in items) {
      if (item.containsKey('Quantity') && item.containsKey('Price')) {
        num quantity;
        if(item['RequiredQTY']>0.0&&item['GiftQTY']>0.0&&item['Quantity']>=item['RequiredQTY'])
        {
           quantity = item['Quantity']-item['Y_Gift_Qty'];
        }
        else
          {
             quantity = item['Quantity'];
          }
        double price = item['Price'];

        total += quantity * price;
      }
    }

    return total;


  }

  void calculateTotal(List<Map<String, dynamic>> newList) {
    setState(() {
      totalPrice = calculateTotalPrice(newList);
    });
  }

  @override
  void initState() {
    super.initState();
    ref.read(getAddressFromApiProvider.notifier).getAddresss();

    calculateTotal(ref.read(orderProviderListImage).orderListImage);


  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(appModelProvider);
    return Scaffold(
      backgroundColor: AppColors.white.withOpacity(0.9),
      appBar: CommonAppBar(
        title: (lang.activeLanguage.languageCode == 'ar')
            ? 'سله المشتريات'
            : 'Shopping basket',
        onLeadingPressed: context.popRoute,
        actions: [
          if ((totalPrice / 10).floor() > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center, // محاذاة العناصر إلى الوسط
                  children: [
                    Text(
                      'ياهلا',
                      style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w600, // جعل الخط أكثر سماكة
                        fontSize: 14.sp, // زيادة حجم النص قليلاً
                        color: AppColors.iconAndTextColor(),
                        letterSpacing: -0.2, // تقليل التباعد بين الحروف
                      ),
                    ),
                const SizedBox(height: 4,),
                  // إضافة مسافة بين النصوص
                    Text(
                      '${(totalPrice / 10).floor()}', // عرض النص مع شرح
                      style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: AppColors.iconAndTextColor(),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
            )

        ],
      ),
      body:
      Consumer(
        builder: (context, ref, child) {
          final listItemOrder = ref.watch(orderProviderList);
          final listItemOrderImage = ref.watch(orderProviderListImage);

          print(listItemOrder.orderList.length);

          return ListView.builder(
              itemCount: listItemOrderImage.orderListImage.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                dynamic q1 = listItemOrder.getQuantity(
                    itemID: listItemOrder.orderList[index]["BarCode"]);
                num y = listItemOrder.getYGiftQty(itemID: listItemOrder.orderList[index]["BarCode"]);
                var item=listItemOrderImage.orderListImage[index];
                return
                  Stack(
                    alignment: Alignment.centerLeft,

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              print(listItemOrder.orderList);

                              print(listItemOrderImage.orderListImage);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => BannerDetailsPage(
                              //       productId: listItemOrder.orderList[index]["ProductId"],
                              //     ),
                              //   ),
                              // );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(child:

                                CachedNetworkImage(

                                  imageUrl: listItemOrderImage.orderListImage[index]['image'] ?? "",
                                  placeholder: (context, url) => const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child:Icon(Icons.error),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  fadeInDuration: const Duration(seconds: 1),
                                  fit: BoxFit.cover,
                                ),

                                ),


                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (lang.activeLanguage.languageCode == 'ar')
                                            ? '${listItemOrderImage.orderListImage[index]["ProductArName"]}'
                                            : '${listItemOrderImage.orderListImage[index]["ProductEnName"]}',

                                        style: GoogleFonts.tajawal(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.sp,
                                          color: Colors.black,
                                          letterSpacing: -0.4,
                                        ),

                                      ),
                                      Row(
                                        children: [

                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: (lang.activeLanguage
                                                          .languageCode ==
                                                          'ar')
                                                          ? 'السعر: '
                                                          : 'Price : ',
                                                      style: GoogleFonts.tajawal(
                                                        fontSize: 14.sp,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: -0.4,
                                                      ),

                                                    ),
                                                    TextSpan(
                                                      text:
                                                      '${listItemOrderImage.orderListImage[index]["Price"].toStringAsFixed(3)}',
                                                      style: GoogleFonts.tajawal(
                                                        fontSize: 14.sp,
                                                        color: Colors.indigo,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: -0.4,
                                                      ),


                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),

                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    if (item[
                                                    "CustomerQuantity"] >
                                                        0.0) {
                                                      if (item[
                                                      "CustomerQuantity"] >=
                                                          item[
                                                          "StockQuantity"]) {
                                                        if (q1 <
                                                            item[
                                                            "StockQuantity"]) {
                                                          setState(
                                                                  () {







                                                                q1++;
                                                                if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                {
                                                                  if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                    q1 += item['GiftQTY'];
                                                                    item["Y_Gift_Qty"]++;

                                                                    y++;
                                                                    print('ysssssss${y}');

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
                                                            item["ProductArName"],
                                                            "ProductEnName":
                                                            item["ProductEnName"],
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
                                                        if (q1 <
                                                            item[
                                                            "CustomerQuantity"]) {
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
                                                            item["ProductArName"],
                                                            "ProductEnName":
                                                            item["ProductEnName"],
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
                                                    } else {
                                                      if (q1 <
                                                          item[
                                                          "StockQuantity"]) {
                                                        setState(
                                                                () {

                                                              q1++;
                                                              // print('Q1 $q1');
                                                              // if(q1==item['RequiredQTY'])
                                                              // { print('Q1==RQqired');
                                                              // print('Q $q1');
                                                              // q1++;
                                                              //
                                                              // print('QQ $q1');
                                                              // print('i $i');
                                                              // i++;
                                                              // print('i $i');
                                                              //
                                                              // }
                                                              // else{
                                                              //   if(
                                                              //   ((q1) % item['RequiredQTY']) == 0)
                                                              //   {
                                                              //     print('Q $q1');
                                                              //     q1++;
                                                              //
                                                              //     print('QQ $q1');
                                                              //     print('i $i');
                                                              //     i++;
                                                              //     print('i $i');
                                                              //   }
                                                              //   else
                                                              //   {
                                                              //
                                                              //     print('Q1 Not $q1');
                                                              //   }
                                                              // }


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
                                                          item["ProductArName"],
                                                          "ProductEnName":
                                                          item["ProductEnName"],
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

                                                    setState(() {
                                                      calculateTotal(ref
                                                          .read(
                                                          orderProviderListImage)
                                                          .orderListImage);
                                                    });

                                                  },
                                                  child: Text(
                                                    '+',
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      color: Colors.orange,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'Monadi',
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    //   (item['RequiredQTY']>0.0&&item['GiftQTY']>0.0&&item['Quantity']>=item['RequiredQTY'])?
                                                    //   (q1%(item['RequiredQTY']*item['GiftQTY'])==0.0)?
                                                    //
                                                    // '${((item['Quantity']~/item['RequiredQTY'])*item['GiftQTY'])+q1}':
                                                    //       '${q1}'
                                                    //
                                                    //
                                                    //   :
                                                    '$q1',
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Monadi',
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    if (q1 > 1) {
                                                      setState(() {
                                                        q1--;
                                                      });

                                                      listItemOrder.decreaseQuantity(
                                                          listItemOrder
                                                              .orderList[index]
                                                          ["BarCode"]);
                                                      listItemOrderImage
                                                          .decreaseQuantity(
                                                          listItemOrder.orderList[
                                                          index]["BarCode"]);
                                                      setState(() {
                                                        calculateTotal(ref
                                                            .read(
                                                            orderProviderListImage)
                                                            .orderListImage);
                                                      });
                                                    } else {
                                                      showDialog(
                                                        context: context,
                                                        builder:
                                                            (BuildContext context) {
                                                          return Dialog(
                                                            shape:
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(10.0),
                                                            ),
                                                            child: Container(
                                                              padding: const EdgeInsets.all(
                                                                  16.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                MainAxisSize.min,
                                                                children: [
                                                                  Text(
                                                                    (lang.activeLanguage
                                                                        .languageCode ==
                                                                        'ar')
                                                                        ? 'حذف الصنف'
                                                                        : 'Confirm Deletion',
                                                                    style: const TextStyle(
                                                                      fontSize: 18.0,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height: 16.0),
                                                                  Text(
                                                                    (lang.activeLanguage
                                                                        .languageCode ==
                                                                        'ar')
                                                                        ? 'هل أنت متأكد من رغبتك في حذف الصنف؟'
                                                                        : 'Are you sure you want to delete the item?',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                        16.0),
                                                                  ),
                                                                  const SizedBox(
                                                                      height: 16.0),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                    children: [
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          listItemOrder
                                                                              .deleteItem(
                                                                              index);
                                                                          listItemOrderImage
                                                                              .deleteItem(
                                                                              index);
                                                                          print(listItemOrder
                                                                              .orderList
                                                                              .length);
                                                                          print(listItemOrder
                                                                              .orderList);
                                                                          setState(
                                                                                  () {
                                                                                calculateTotal(ref
                                                                                    .read(
                                                                                    orderProviderListImage)
                                                                                    .orderListImage);
                                                                              });

                                                                          Navigator.of(
                                                                              context)
                                                                              .pop();
                                                                        },
                                                                        child: Text((lang
                                                                            .activeLanguage
                                                                            .languageCode ==
                                                                            'ar')
                                                                            ? 'موافق'
                                                                            : 'Delete'),
                                                                      ),
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(
                                                                              context)
                                                                              .pop();
                                                                        },
                                                                        child: Text((lang
                                                                            .activeLanguage
                                                                            .languageCode ==
                                                                            'ar')
                                                                            ? 'إلغاء'
                                                                            : 'Cancel'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }

                                                    print(q1);
                                                  },
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      color: Colors.orange,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'Monadi',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: (lang.activeLanguage
                                                      .languageCode ==
                                                      'ar')
                                                      ? 'الاجمالى : '
                                                      : 'Total : ',

                                                  style: GoogleFonts.tajawal(
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: -0.4,
                                                  ),

                                                ),
                                                TextSpan(
                                                  text:


                                                 (listItemOrderImage.orderListImage[index]['RequiredQTY']>0.0&&listItemOrderImage.orderListImage[index]['GiftQTY']>0.0&&listItemOrderImage.orderListImage[index]['Quantity']>=listItemOrderImage.orderListImage[index]['RequiredQTY'])?
                                                  '${((item['Quantity']-item['Y_Gift_Qty'])*item["Price"]).toStringAsFixed(3)}'
                                                 :

                                                  '${(item["Quantity"] * item["Price"]).toStringAsFixed(3)}',
                                                  style: GoogleFonts.tajawal(
                                                    fontSize: 14.sp,
                                                    color: Colors.indigo,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: -0.4,
                                                  ),


                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          if (listItemOrderImage.orderListImage[index]['RequiredQTY']>0.0&&listItemOrderImage.orderListImage[index]['GiftQTY']>0.0&&listItemOrderImage.orderListImage[index]['Quantity']>=listItemOrderImage.orderListImage[index]['RequiredQTY'])
                                            Text(
                                              '${(item["Quantity"] * item["Price"]).toStringAsFixed(3)}',

                                              style: GoogleFonts.tajawal(
                                                fontSize: 14.sp,

                                                fontWeight: FontWeight.bold,
                                                letterSpacing: -0.4,
                                                decoration: TextDecoration
                                                    .lineThrough,
                                                color: Colors.red,
                                                decorationThickness: 12.0,
                                              ),


                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (listItemOrderImage.orderListImage[index]['RequiredQTY']>0.0&&listItemOrderImage.orderListImage[index]['GiftQTY']>0.0&&listItemOrderImage.orderListImage[index]['Quantity']>=listItemOrderImage.orderListImage[index]['RequiredQTY'])
                        Container(
                          margin: const EdgeInsets.all(8),

                            width: 30.w,
                            height: 30.h,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: Colors.red,
                            ),child: Center(
                              child: Text(
                                '${item['Y_Gift_Qty']} ',
                                style: const TextStyle(color: Colors.white),),
                            ))
                    ],
                  );
              });
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: REdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
        child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [


//        if (totalPrice % 10 != 0)
    //       SizedBox(
    //       width: MediaQuery.sizeOf(context).width,
    //   child: Material(
    //     elevation: 2,
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(5),
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 5),
    //       child: Row(
    //         children: [
    //           const Icon(
    //             Icons.card_giftcard,
    //             color: Colors.orange,
    //             size: 20,
    //           ),
    //           5.horizontalSpace,
    //           Text(
    //             'متبقي ${(10 - (totalPrice % 10)).toStringAsFixed(3)} د.ك للحصول على كوبون يا هلا', // نص يعرض المبلغ المتبقي
    //             style: GoogleFonts.tajawal(
    //               fontWeight: FontWeight.w500,
    //               fontSize: 16.sp,
    //               color: AppColors.iconAndTextColor(),
    //               letterSpacing: -0.4,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ),

5.verticalSpace,
    if (totalPrice < 20&&totalPrice>10)
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Material(
                  elevation: 2,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add_shopping_cart_outlined,
                          color: Colors.orange,
                          size: 20,
                        ),
                        5.horizontalSpace,
                        Text(

                          'اضف ${(20 - totalPrice).toStringAsFixed(3)} د.ك واحصل على توصيل مجانى',

                          style: GoogleFonts.tajawal(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: AppColors.iconAndTextColor(),
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
           if(totalPrice>=20)
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Material(
                  elevation: 2,
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 20,
                        ),
                        5.horizontalSpace,
                        Text((lang.activeLanguage.languageCode == 'ar')?
                          'لقد حصلت على توصيل مجانى'
                          :
                          'You have received free delivery',
                          style: GoogleFonts.tajawal(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: Colors.green.shade800,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            10.verticalSpace,
            Container(
              height: 45.h,
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10),
                      child: Text(
                        (lang.activeLanguage.languageCode == 'ar') ? 'الاجمالى ' : 'Total',
                        style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: AppColors.iconAndTextColor(),
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${totalPrice.toStringAsFixed(3)} ',
                            style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                              color: AppColors.iconAndTextColor(),
                              letterSpacing: -0.4,
                            ),
                          ),
                          TextSpan(
                            text: (lang.activeLanguage.languageCode == 'ar') ? 'د.ك ' : 'K.D',
                            style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                              color: AppColors.iconAndTextColor(),
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final listItemOrder = ref.watch(orderProviderList);
                        final listItemOrderImage = ref.watch(orderProviderListImage);
                        final listAddressUser = ref.watch(getAddressFromApiProvider);
                        return ElevatedButton(
                          onPressed: () {



                            // if(UserPhoneAll==null)
                            //   {
                            //     WidgetsBinding.instance.addPostFrameCallback((_) {
                            //       Future.delayed(Duration.zero, () {
                            //         showDialog(
                            //           context: context,
                            //           barrierDismissible: false,
                            //           builder: (_) => AlertDialog(
                            //               title: Text(
                            //                 'الرقم غير مسجل ',
                            //                 style: TextStyle(
                            //                   fontSize: 16.sp,
                            //                   color: const Color(0xff000000),
                            //                   fontWeight: FontWeight.w500,
                            //                   fontFamily: 'Monadi',
                            //                 ),
                            //               ),
                            //               content: Text(
                            //                 "يرجى ادخال رقم الهاتف",
                            //                 style: TextStyle(
                            //                   fontSize: 14.sp,
                            //                   color: Color(0xff000000),
                            //                   fontWeight: FontWeight.w500,
                            //                   fontFamily: 'Monadi',
                            //                 ),
                            //               ),
                            //               actions: [
                            //
                            //                 Form(
                            //                   key:keyFormCheckOutOnSystem,
                            //                   child: MyStyledTextField(
                            //                     maxLength: 8,
                            //                     keyboardType: TextInputType.phone,
                            //                     label:  (true)?'رقم الموبيل':'Mobial Number',
                            //                     hintText:  (true)?'رقم الموبيل':'Mobial Number',
                            //
                            //                     controller: customPhoneGuestController,
                            //                     validator: (value) {
                            //                       if (value!.isEmpty) {
                            //                         return   (true)? 'هذا الحقل مطلوب' : 'This field is required';
                            //                       }
                            //
                            //                       else if       ((value.startsWith('٩')|| value.startsWith('٤')|| value.startsWith('٥')||  value.startsWith('٦'))) {
                            //                         return   (true)
                            //                             ? 'يرجى كتابه الارقام بالانجليزى '
                            //                             : "Please write the numbers in English.";
                            //                       }
                            //                       else if       (value.length != 8 || !(value.startsWith('4') || value.startsWith('5')|| value.startsWith('6') ||  value.startsWith('9'))) {
                            //                         return   (true)
                            //                             ? ' رقم الهاتف غير صحيح يرجي التأكد من رقم الهاتف'
                            //                             : 'The Mobile Number not correct please check the mobile number';
                            //                       }
                            //
                            //
                            //                       else {
                            //                         return null;
                            //                       }
                            //                     },
                            //                   ),
                            //                 ),
                            //                 20.verticalSpace,
                            //
                            //                 TextButton(
                            //                   style: ButtonStyle(
                            //                     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            //                       EdgeInsets.zero,
                            //                     ),
                            //                   ),
                            //                   onPressed: ()  {
                            //
                            //
                            //
                            //                     if(keyFormCheckOutOnSystem.currentState!.validate()) {
                            //
                            //                     }
                            //                     if(UserPhone==null)
                            //                     {
                            //                       UserPhoneAll=customPhoneGuestController.text;
                            //                     }
                            //                     else
                            //                     {
                            //                       UserPhoneAll=UserPhone;
                            //                     }
                            //
                            //                     print('UserPhone All  ${UserPhoneAll}');
                            //
                            //                     print('UserPhone   ${UserPhone}');
                            //
                            //                     // Navigator.push(context, MaterialPageRoute(builder: (context) {
                            //                     //   return MainPage();
                            //                     // }));
                            //                     Navigator.pushReplacement(
                            //                       context,
                            //                       MaterialPageRoute(
                            //                         builder: (context) => MainPage(
                            //
                            //                         ),
                            //                       ),
                            //                     );
                            //
                            //                   },
                            //                   child: Container(
                            //                     width: 1.sw - 30,
                            //                     height: 40.r,
                            //                     alignment: Alignment.center,
                            //                     decoration: BoxDecoration(
                            //                       color: Colors.orange,
                            //                       borderRadius: BorderRadius.circular(30),
                            //
                            //                     ),
                            //                     child:false
                            //                         ? SizedBox(
                            //                       height: 20.r,
                            //                       width: 20.r,
                            //                       child: CircularProgressIndicator(
                            //                         strokeWidth: 3.r,
                            //                         color: AppColors.white,
                            //                       ),
                            //                     )
                            //                         : Text(
                            //                       (true)?
                            //
                            //                       "استمرار":'Continue ',
                            //                       style: GoogleFonts.inter(
                            //                         fontWeight: FontWeight.w600,
                            //                         fontSize: 12.sp,
                            //                         color: AppColors.white,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ]),
                            //         );
                            //       });
                            //     });
                            //   }


                           if(listItemOrderImage.orderListImage.isNotEmpty&&listItemOrder.orderList.isNotEmpty) {
                             (UserPhone == null)
                                 ? Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) =>
                                     AddAddress(
                                       newmyList: listItemOrder.orderList,
                                       imageList: listItemOrderImage.orderListImage,
                                     ),
                               ),
                             )
                                 : Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) =>
                                     CheckoutPageOne(
                                       gada: listAddressUser
                                           .dataAddressList[0]["Gada"] ?? 2,
                                       nameControllerCheckOutOnSystem: listAddressUser
                                           .dataAddressList[0]["ArabicName"],
                                       mobileNumberControllerCheckOutOnSystem: listAddressUser
                                           .dataAddressList[0]["CustomerPhone"],
                                       emailControllerCheckOutOnSystem: listAddressUser
                                           .dataAddressList[0]["Email"],
                                       StreetControllerCheckOutOnSystem: listAddressUser
                                           .dataAddressList[0]["StreetName"],
                                       floorControllerCheckOutOnSystem: listAddressUser
                                           .dataAddressList[0]["Floor"],
                                       HouseControllerCheckOutOnSystem: listAddressUser
                                           .dataAddressList[0]["HouseNo"],
                                       BlockNumberControllerCheckOutOnSystem: listAddressUser
                                           .dataAddressList[0]["Block"],
                                       titleNotes: listAddressUser
                                           .dataAddressList[0]["AddressNotes"],
                                       apartmentControllerCheckOutOnSystem: listAddressUser
                                           .dataAddressList[0]["Apartment"],
                                       DeliveryValue: double.parse(
                                           DeliveryValue ?? '15.0'),
                                       newmyList: listItemOrder.orderList,
                                       ValueselectedDistrict: listAddressUser
                                           .dataAddressList[0]["RegionName"],
                                     ),
                               ),
                             );
                           }

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Text(
                            (lang.activeLanguage.languageCode == 'ar') ? 'الدفع' : 'CheckOut',
                            style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                              color: AppColors.iconAndTextColor(),
                              letterSpacing: -0.4,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}

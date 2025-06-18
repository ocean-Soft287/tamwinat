import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/core/constants/app_assets.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/favorite/controler/favorite_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/home/on_system/controller/home_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/text_form_field_onsystem.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/details/banner_details/banner_details_page.dart';
import 'package:sundaymart/src/presentation/theme/app_colors.dart';
import 'package:sundaymart/src/riverpod/gh.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ProductVersionList extends ConsumerStatefulWidget {
    List<bool> isSecondContainerProductVersion;
  
  dynamic UserPhoneAll;
  dynamic  UserPhone;

   ProductVersionList({super.key,required this.UserPhone,
   required this.UserPhoneAll
   ,required this.isSecondContainerProductVersion });

  @override
  ConsumerState<ProductVersionList> createState() => _ProductVersionListState();
}

class _ProductVersionListState extends ConsumerState<ProductVersionList> {
  final  GlobalKey<FormState>   keyFormCheckOutOnSystem=   GlobalKey<FormState> () ;
      TextEditingController customPhoneGuestController = TextEditingController();


  @override
  Widget build(BuildContext context) {
                final appModel = ref.watch(appModelProvider);

    return Consumer(builder: (context, ref, child) {
            final getDataFavoriteFromApi = ref.watch(addItemFavoriteProvider);
            final getDataProductVersiontFromApi =
            ref.watch(getDataProductVersionFromApiProvider);
            final deletFavorite = ref.watch(deleteItemFavoriteProvider);
            final listItemOrder = ref.watch(orderProviderList);
            final listItemOrderImage = ref.watch(orderProviderListImage);

            return
              (getDataProductVersiontFromApi.productVersionList.isEmpty||getDataProductVersiontFromApi.productVersionList[0]["ShowGroup"]==0)?const SizedBox():
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'وصل حديثا'
                        : 'Recently Arrived',
                    style: GoogleFonts.tajawal(
                      fontSize:
                      16.sp,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
                5.verticalSpace,
                SizedBox(
                  height: 230.h,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount:
                    getDataProductVersiontFromApi.productVersionList.length,
                    itemBuilder: (context, index) {
                      final item =
                      getDataProductVersiontFromApi.productVersionList[index];
                     num q1 = listItemOrder.getQuantity(itemID: item['BarCode']);
                      num y = listItemOrder.getYGiftQty(itemID: item["BarCode"]);
                      return
                        Card(
                          color: Colors.white,
                          child: Container(
                            color: Colors.white,
                            width: 200.w,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  //getDataFromApi.dataCategoryAllList[index]["productId"]
                                  MaterialPageRoute(
                                      builder: (context) => BannerDetailsPage(
                                        productId: item["ProductID"],
                                        CategoryId: item['CategoryId'],
                                        name: (appModel.activeLanguage
                                            .languageCode ==
                                            'ar')
                                            ? item['ProductArName']
                                            : item['ProductEnName'],
                                        image: item['ProductcImage'],
                                        specification: item['Specification'],
                                      )),
                                );
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: REdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 130,
                                                  child: Center(

                                                    child:   
CachedNetworkImage(
  imageUrl:   '${item['ProductcImage']}',
  width: MediaQuery.of(context).size.width,
  fit: BoxFit.fill,
  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
  errorWidget: (context, url, error) => Icon(Icons.error),
),
                                                  
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                  if(UserPhoneAll==null || UserPhone == null)
                                                    {

  q1 = phoneAlertDialog(context, appModel, q1, index, listItemOrder, item, y, listItemOrderImage);
  

                                                    }
                                                    else
                                                    {
                                                      q1 = addItemToCart(index, q1, listItemOrder, item, y, listItemOrderImage);
                                                   
                                                   
                                                    }


                                                  },
                                                  child:
                                                  !widget. isSecondContainerProductVersion[
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
                                                                      item["ProductArName"] +' * '+item['UnitValue'].toString(),
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
                                                                      item["ProductArName"] +' * '+item['UnitValue'].toString(),
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
                                                                    item["ProductArName"] +' * '+item['UnitValue'].toString(),
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
                                                ? '${item["ProductArName"]} * ${item['UnitValue'].toString()}'
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
                                  if (item["StockQuantity"] == 0.0)
                                    Image.asset(AppAssets.OutOfStock),
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: item["IsFavorite"] == 1
                                              ? Colors.red
                                              : const Color.fromRGBO(200, 200, 200, 1.0),
                                        ),
                                        onPressed: () {
                                          if (item["IsFavorite"] == 0) {
                                            getDataFavoriteFromApi
                                                .AddItemFavoritePost(
                                                CustomerPhone: '${widget. UserPhone}',
                                                ProductID: item["ProductID"]
                                                    .toString());
                                          } else {
                                            deletFavorite.DeleteItemFavoritePost(
                                                ProductId:
                                                item["ProductID"].toString());
                                          }
                                          setState(() {
                                            item["IsFavorite"] =
                                            item["IsFavorite"] == 1 ? 0 : 1;
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
          });
  

  }

  num phoneAlertDialog(BuildContext context, AppModel appModel, num q1, int index, ListItemOrder listItemOrder, Map<String, dynamic> item, num y, ListItemOrderImage listItemOrderImage) {
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
                                                                key:keyFormCheckOutOnSystem,
                                                                child: MyStyledTextField(
                                                                  maxLength: 8,
                                                                  keyboardType: TextInputType.phone,
                                                                  label:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',
                                                                  hintText:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',
    
                                                                  controller: customPhoneGuestController,
                                                                validator: (value) {
    return mobilevalidation(appModel, value);
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
                                                                
    
    
                                                                  if(keyFormCheckOutOnSystem.currentState!.validate()) {
             setState(() {
                                                                      UserPhoneAll = UserPhone= customPhoneGuestController.text;
      
    });
                                                        q1 = addItemToCart(index, q1, listItemOrder, item, y, listItemOrderImage);
    
    Navigator.pop(context);
   
                                                                  }
                                                                  // if(widget. UserPhone==null)
                                                                  // {
                                                                  //  widget. UserPhoneAll= customPhoneGuestController.text;
                                                                  // }
                                                                  // else
                                                                  // {
                                                                  //  widget. UserPhoneAll=widget. UserPhone;
                                                                  // }
    
    
    
    
                                                                  // Navigator.pushReplacement(
                                                                  //   context,
                                                                  //   MaterialPageRoute(
                                                                  //     builder: (context) => const MainPage(
    
                                                                  //     ),
                                                                  //   ),
                                                                  // );
    
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
    
    return q1;
  }

  num addItemToCart(int index, num q1, ListItemOrder listItemOrder, Map<String, dynamic> item, num y, ListItemOrderImage listItemOrderImage) {
       setState(() {
                                                         widget.   isSecondContainerProductVersion[
      index] =
      !widget. isSecondContainerProductVersion[
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
        item["ProductArName"] +' * '+item['UnitValue'].toString(),
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
    
    if (widget. isSecondContainerProductVersion[
    index]) {
      Future.delayed(
          const Duration(
              milliseconds: 10000),
              () {
            setState(() {
             widget. isSecondContainerProductVersion[
              index] = false;
            });
          });
    }
                                                       
                                                       
    return q1;
  }

  

  String? mobilevalidation(AppModel appModel, String? value) {
    final isArabic = appModel.activeLanguage.languageCode == 'ar';
    if (value == null || value.isEmpty) {
      return isArabic ? 'هذا الحقل مطلوب' : 'This field is required';
    }
    
    final isValidPrefix = value.startsWith('4') || value.startsWith('5') ||
                          value.startsWith('6') || value.startsWith('9');
    final isNumeric = RegExp(r'^\d+$').hasMatch(value);
    
    if (value.length != 8 || !isValidPrefix || !isNumeric) {
      return isArabic
        ? 'رقم الهاتف غير صحيح. تأكد أن الرقم مكون من 8 أرقام إنجليزية ويبدأ بـ 4، 5، 6 أو 9'
        : 'The mobile number is incorrect. It should be 8 English digits starting with 4, 5, 6, or 9';
    }
    
    return null;
  }
}
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sundaymart/src/riverpod/gh.dart';

import '../../../../../core/constants/app_assets.dart';

import '../../../../components/app_bars/common_appbar.dart';
import '../../../../components/components.dart';
import '../../../../theme/app_colors.dart';

import '../../shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import '../../shop/details/banner_details/banner_details_page.dart';
import '../on_system/controller/home_riverpod.dart';

class DeliveryCategory extends ConsumerStatefulWidget {
  final dynamic? categoryId;
  final dynamic? CategoryArName;

  DeliveryCategory(
      {super.key, required this.categoryId, required this.CategoryArName});

  @override
  _DeliveryCategoryState createState() => _DeliveryCategoryState();
}

class _DeliveryCategoryState extends ConsumerState<DeliveryCategory> {
  int counterQuntati = 0;
  bool checkButton = false;
  bool isSecondContainerVisible = false;
  bool isLoading = true;
  List<bool> itemLoveStates = List.generate(20, (index) => false);
  List<bool> isSecondContainerVisibleList = List.generate(20, (index) => false);
  @override
  void initState() {
    super.initState();
    ref.read(getProductsFromApi.notifier).getProducsts(
        categoryId: widget.categoryId, brandId: null); // Erro Here
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    print(widget.categoryId);
    return KeyboardDismisser(
        child: Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(
        title: ' ${widget.CategoryArName}',
        onLeadingPressed: context.popRoute,
      ),
      body: isLoading
          ? GridListShimmer(
              itemCount: 10,
              isScrollable: true,
              onlyBottomPadding: 10,
              verticalPadding: 10,
            )
          : Container(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  32.verticalSpace,
                  Consumer(
                    builder: (context, ref, child) {
                      final getDataCategoryItemFromApi =
                          ref.watch(getProductsFromApi);

                      final listItemOrder = ref.watch(orderProviderList);
                      final listItemOrderImage =
                          ref.watch(orderProviderListImage);

                      int _getCrossAxisCount(BuildContext context) {
                        final screenWidth = MediaQuery.of(context).size.width;
                        // Adjust the values as per your needs
                        if (screenWidth >= 1200) {
                          return 4; // 4 items per row for large screens
                        } else if (screenWidth >= 800) {
                          return 3; // 3 items per row for medium screens
                        } else {
                          return 2; // 2 items per row for small screens
                        }
                      }

                      double _getAspectRatio(BuildContext context) {
                        final crossAxisCount = _getCrossAxisCount(context);
                        // Adjust the values as per your needs
                        if (crossAxisCount == 4) {
                          return 0.75; // Wider aspect ratio for large screens
                        } else {
                          return 0.8; // Regular aspect ratio for medium and small screens
                        }
                      }

                      return Expanded(
                          child: Padding(
                        padding: REdgeInsets.symmetric(horizontal: 8.0),
                        child: getDataCategoryItemFromApi.productsList.isEmpty
                            ? const GridListShimmer(
                                itemCount: 10,
                                isScrollable: true,
                                onlyBottomPadding: 10,
                                verticalPadding: 10,
                              )
                            : GridView.builder(
                                itemCount: getDataCategoryItemFromApi
                                    .productsList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: _getCrossAxisCount(context),
                                  childAspectRatio: _getAspectRatio(context),
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 5,
                                ),
                                itemBuilder: (context, index) {
                                  final item = getDataCategoryItemFromApi
                                      .productsList[index];
                                  num q1 = listItemOrder.getQuantity(
                                      itemID: item['ProductID']);
                                  // int quantity =
                                  // listItemOrder.getQuantityByItemID(
                                  //     getDataCategoryItemFromApi.categoryAllList[index]['ItemID']);
                                  return Card(
                                    color: Colors.white,
                                    child: Container(
                                      color: Colors.white,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              //getDataFromApi.dataCategoryAllList[index]["productId"]
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BannerDetailsPage(
                                                        productId:
                                                            item["ProductID"],
                                                        CategoryId:
                                                            widget.categoryId,
                                                        name: (appModel
                                                                    .activeLanguage
                                                                    .languageCode ==
                                                                'ar')
                                                            ? item[
                                                                'ProductArName']
                                                            : item[
                                                                'ProductEnName'],
                                                        image: item[
                                                            'ProductcImage'],
                                                        specification: item[
                                                            'Specification'],
                                                      )));
                                        },
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: REdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Stack(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        children: [
                                                          Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 130,
                                                            child:
                                                                Image.network(
                                                              '${item['ProductcImage']}',
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                isSecondContainerVisibleList[
                                                                        index] =
                                                                    !isSecondContainerVisibleList[
                                                                        index];
                                                                // isSecondContainerVisible =
                                                                // !isSecondContainerVisible;
                                                              });

                                                              setState(() {
                                                                if (q1 == 0) {
                                                                  q1++;
                                                                  print(q1);
                                                                }
                                                                listItemOrder
                                                                    .addItem({
                                                                  "ItemID": item[
                                                                      "ProductID"],
                                                                  "Quantity":
                                                                      q1,
                                                                  "Price": item[
                                                                      "Price"]
                                                                });
                                                                listItemOrderImage
                                                                    .addItem({
                                                                  "image": item[
                                                                      "ProductcImage"],
                                                                  "ItemID": item[
                                                                      "ProductID"],
                                                                  "Quantity":
                                                                      q1,
                                                                  "Price": item[
                                                                      "Price"],
                                                                  "ProductArName":
                                                                      item[
                                                                          "ProductArName"]
                                                                });
                                                              });

                                                              if (isSecondContainerVisibleList[
                                                                  index]) {
                                                                Future.delayed(
                                                                    Duration(
                                                                        milliseconds:
                                                                            10000),
                                                                    () {
                                                                  setState(() {
                                                                    isSecondContainerVisibleList[
                                                                            index] =
                                                                        false;
                                                                  });
                                                                });
                                                              }
                                                            },
                                                            child: !isSecondContainerVisibleList[
                                                                    index]
                                                                ? Card(
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          40.h,
                                                                      width:
                                                                          35.w,
                                                                      color: (q1 >=
                                                                              1)
                                                                          ? Colors
                                                                              .green
                                                                          : Colors
                                                                              .white,
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            (q1 >= 1)
                                                                                ? '${q1}'
                                                                                : '+',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 20.sp,
                                                                              color: (q1 >= 1) ? Colors.white : Colors.orange,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    height: 40,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
                                                                          spreadRadius:
                                                                              5,
                                                                          blurRadius:
                                                                              7,
                                                                          offset: Offset(
                                                                              0,
                                                                              3),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (q1 >
                                                                                0) {
                                                                              setState(() {
                                                                                q1--;
                                                                              });
                                                                            }
                                                                            if (q1 ==
                                                                                0) {}
                                                                            listItemOrder.decreaseQuantity(item["ProductID"]);
                                                                            listItemOrderImage.decreaseQuantity(item["ProductID"]);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            '-',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 20.sp,
                                                                              color: Colors.orange,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontFamily: 'Monadi',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Center(
                                                                          child:
                                                                              Text(
                                                                            '${q1}',
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16.sp,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'Monadi',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (q1 <
                                                                                item["StockQuantity"]) {
                                                                              setState(() {
                                                                                q1++;
                                                                              });
                                                                              listItemOrder.addItem({
                                                                                "ItemID": item["ProductID"],
                                                                                "Quantity": q1,
                                                                                "Price": item["Price"]
                                                                              });
                                                                              listItemOrderImage.addItem({
                                                                                "image": item["ProductcImage"],
                                                                                "ItemID": item["ProductID"],
                                                                                "Quantity": q1,
                                                                                "Price": item["Price"],
                                                                                "ProductArName": item["ProductArName"]
                                                                              });
                                                                            }
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            '+',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 20.sp,
                                                                              color: Colors.orange,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontFamily: 'Monadi',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )),
                                                          )
                                                        ]),
                                                  ),
                                                  4.verticalSpace,
                                                  (item["DiscountPercent"] ==
                                                          0.0)
                                                      ? Row(
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          children: [
                                                            Text(
                                                              ' ${item["Price"].toStringAsFixed(3)}',
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontFamily:
                                                                    'Monadi',
                                                              ),
                                                            ),
                                                            Text(
                                                              'د.ك',
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontFamily:
                                                                    'Monadi',
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Row(
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          children: [
                                                            Text(
                                                              '${item["PriceAfterDiscount"].toStringAsFixed(3)}',
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontFamily:
                                                                    'Monadi',
                                                              ),
                                                            ),
                                                            Text(
                                                              'د.ك',
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontFamily:
                                                                    'Monadi',
                                                              ),
                                                            ),
                                                            10.horizontalSpace,
                                                            Text(
                                                              ' ${item["Price"].toStringAsFixed(3)}',
                                                              style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontFamily:
                                                                    'Monadi',
                                                              ),
                                                            ),
                                                            Text(
                                                              'د.ك',
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                color:
                                                                    Colors.red,
                                                                fontFamily:
                                                                    'Monadi',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                  2.verticalSpace,
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      '${item["ProductArName"]}',
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (item["DiscountPercent"] != null)
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  color: Colors.red,
                                                  child: Text(
                                                    '%${item["DiscountPercent"]}خصم',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (item["StockQuantity"] == 0.0)
                                              Image.asset(AppAssets.OutOfStock),
                                            Positioned(
                                              child: IconButton(
                                                icon: itemLoveStates[index]
                                                    ? Icon(Icons.favorite,
                                                        color: Colors
                                                            .red) // Love Active
                                                    : Icon(Icons
                                                        .favorite_border), // Love Inactive
                                                onPressed: () {
                                                  setState(() {
                                                    itemLoveStates[index] =
                                                        !itemLoveStates[
                                                            index]; // Toggle Love state
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ));
                    },
                  ),
                ],
              ),
            ),
    ));
  }
}

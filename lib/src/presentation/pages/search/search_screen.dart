import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/src/presentation/pages/search/search_bar_code.dart';
import 'package:sundaymart/src/presentation/pages/search/search_riverpod.dart';

import '../../../core/constants/app_assets.dart';
import '../../../riverpod/gh.dart';
import '../main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import '../main/shop/details/banner_details/banner_details_page.dart';

class SearchScrean extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  SearchScrean({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchScanBarCodeScreen()),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Consumer(builder: (context, ref, child) {
        final getDataFavoriteFromApi = ref.watch(getDataSearchApiProvider);

        final appModel = ref.watch(appModelProvider);

        final listItemOrder = ref.watch(orderProviderList);
        final listItemOrderImage = ref.watch(orderProviderListImage);
        int getCrossAxisCount(BuildContext context) {
          final screenWidth = MediaQuery.of(context).size.width;

          if (screenWidth >= 1200) {
            return 4;
          } else if (screenWidth >= 800) {
            return 3;
          } else {
            return 2;
          }
        }

        double getAspectRatio(BuildContext context) {
          final crossAxisCount = getCrossAxisCount(context);

          if (crossAxisCount == 4) {
            return 0.75; // Wider aspect ratio for large screens
          } else {
            return 0.8; // Regular aspect ratio for medium and small screens
          }
        }

        return Column(
          children: [
            // InkWell(
            //   onTap: (){
            //     getDataFavoriteFromApi.getSearch(search: 'كوكتيل');
            //   },
            //   child: Text('ddd'),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (text) {
                  if(text.isEmpty)
                    {
                      getDataFavoriteFromApi.getSearch(search: ' ');
                    }
                 if(text.length>=3)
                   {
                     getDataFavoriteFromApi.getSearch(search: text);
                   }


                },
                decoration: InputDecoration(
                  hintText: 'ابحث...',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(20.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 16),
                ),
              ),
            ),
            Expanded(
              child: getDataFavoriteFromApi.searchList.isEmpty
                  ? const Center(
                      child: Text('لا توجد نتائج بحث'),
                    )
                  :


              GridView.builder(
                      controller: _scrollController,
                      itemCount: getDataFavoriteFromApi.searchList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: getCrossAxisCount(context),
                        childAspectRatio: getAspectRatio(context),
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        final item = getDataFavoriteFromApi.searchList[index];
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
                                  // getDataFromApi.dataCategoryAllList[index]["productId"]
                                  MaterialPageRoute(
                                      builder: (context) => BannerDetailsPage(
                                            productId: item["ProductID"],
                                            CategoryId: item["CategoryId"],
                                            name: (appModel.activeLanguage
                                                        .languageCode ==
                                                    'ar')
                                                ? item['ProductArName']
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
                                    padding:
                                        REdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  child: Image.network(
                                                    '${item['ProductcImage']}',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                // GestureDetector(
                                                //   onTap: () {
                                                //
                                                //
                                                //
                                                //     setState(() {
                                                //       isSecondContainerVisibleList[index] = !isSecondContainerVisibleList[index];
                                                //       // isSecondContainerVisible =
                                                //       // !isSecondContainerVisible;
                                                //
                                                //     });
                                                //
                                                //     setState(() {
                                                //       if(q1==0)
                                                //       {
                                                //         q1++;
                                                //         print(q1);
                                                //       }
                                                //       listItemOrder
                                                //           .addItem({
                                                //         "ItemID":
                                                //         item["ProductID"],
                                                //         "Quantity":
                                                //         q1,
                                                //         "Price":
                                                //         item["Price"],
                                                //         "StockQuantity":
                                                //         item ["StockQuantity"]
                                                //       });
                                                //       listItemOrderImage
                                                //           .addItem({
                                                //         "image":
                                                //         item["ProductcImage"],
                                                //         "ItemID":
                                                //         item["ProductID"],
                                                //         "Quantity":
                                                //         q1,
                                                //         "Price":
                                                //         item["Price"],
                                                //         "ProductArName":
                                                //         item["ProductArName"],
                                                //         "ProductEnName":
                                                //         item["ProductEnName"],
                                                //         "StockQuantity":
                                                //         item["StockQuantity"]
                                                //       });
                                                //     });
                                                //
                                                //     if (isSecondContainerVisibleList[index]) {
                                                //       Future.delayed(
                                                //           Duration(
                                                //               milliseconds:
                                                //               10000), () {
                                                //         setState(() {
                                                //           isSecondContainerVisibleList[index] =
                                                //           false;
                                                //         });
                                                //       });
                                                //     }
                                                //   },
                                                //   child:
                                                //   !isSecondContainerVisibleList[index]
                                                //       ? Card(
                                                //     child: Container(
                                                //       height: 40.h,
                                                //       width: 35.w,
                                                //
                                                //       color: (q1>=1)?Colors.green:Colors.white,
                                                //
                                                //       child: Center(
                                                //         child: Text(    (q1>=1)?'${q1}':'+',
                                                //             style:
                                                //             TextStyle(
                                                //               fontWeight: FontWeight.w500,
                                                //               fontSize:
                                                //               20.sp,
                                                //               color:(q1>=1)?Colors.white:Colors.orange,
                                                //
                                                //             )),
                                                //       ),
                                                //     ),
                                                //   )
                                                //       : Container(
                                                //       height: 40,
                                                //       decoration: BoxDecoration(
                                                //         color: Colors.white,
                                                //         borderRadius: BorderRadius.circular(10),
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color: Colors.grey.withOpacity(0.5),
                                                //             spreadRadius: 5,
                                                //             blurRadius: 7,
                                                //             offset: Offset(0, 3),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //       child:
                                                //       Row(
                                                //         children: [
                                                //           TextButton(
                                                //             onPressed:
                                                //                 () {
                                                //               if (q1 <
                                                //                   item
                                                //                   ["StockQuantity"])
                                                //               {
                                                //                 setState(
                                                //                         () {
                                                //                       q1++;
                                                //                     });
                                                //                 listItemOrder
                                                //                     .addItem({
                                                //                   "ItemID":
                                                //                   item["ProductID"],
                                                //                   "Quantity":
                                                //                   q1,
                                                //                   "Price":
                                                //                   item["Price"],
                                                //                   "StockQuantity":
                                                //                   item
                                                //                   ["StockQuantity"]
                                                //
                                                //                 });
                                                //                 listItemOrderImage
                                                //                     .addItem({
                                                //                   "image":
                                                //                   item["ProductcImage"],
                                                //                   "ItemID":
                                                //                   item["ProductID"],
                                                //                   "Quantity":
                                                //                   q1,
                                                //                   "Price":
                                                //                   item["Price"],
                                                //                   "ProductArName":
                                                //                   item["ProductArName"],
                                                //                   "ProductEnName":
                                                //                   item["ProductEnName"],
                                                //                   "StockQuantity":
                                                //                   item
                                                //                   ["StockQuantity"]
                                                //                 });
                                                //
                                                //               }
                                                //
                                                //
                                                //
                                                //             },
                                                //             child: Text(
                                                //               '+',
                                                //               style:
                                                //               TextStyle(
                                                //                 fontSize:
                                                //                 20.sp,
                                                //                 color: Colors.orange,
                                                //                 fontWeight:
                                                //                 FontWeight.w500,
                                                //                 fontFamily:
                                                //                 'Monadi',
                                                //               ),
                                                //             ),
                                                //           ),
                                                //
                                                //           Center(
                                                //             child: Text(
                                                //               '${q1}',
                                                //               maxLines:
                                                //               2,
                                                //               overflow:
                                                //               TextOverflow
                                                //                   .ellipsis,
                                                //               style:
                                                //               TextStyle(
                                                //                 fontSize:
                                                //                 16.sp,
                                                //                 color: Colors
                                                //                     .black,
                                                //                 fontWeight:
                                                //                 FontWeight.bold,
                                                //                 fontFamily:
                                                //                 'Monadi',
                                                //               ),
                                                //             ),
                                                //           ),
                                                //           TextButton(
                                                //             onPressed:
                                                //                 () {
                                                //               if (q1 >
                                                //                   0) {
                                                //                 setState(
                                                //                         () {
                                                //                       q1--;
                                                //                     });
                                                //               }
                                                //               if (q1 ==
                                                //                   0) {}
                                                //               listItemOrder
                                                //                   .decreaseQuantity(
                                                //                   item["ProductID"]);
                                                //               listItemOrderImage
                                                //                   .decreaseQuantity(
                                                //                   item["ProductID"]);
                                                //             },
                                                //             child: Text(
                                                //               '-',
                                                //               style:
                                                //               TextStyle(
                                                //                 fontSize:
                                                //                 20.sp,
                                                //                 color: Colors.orange,
                                                //                 fontWeight: FontWeight.w500,
                                                //                 fontFamily:
                                                //                 'Monadi',
                                                //               ),
                                                //             ),
                                                //           ),
                                                //         ],
                                                //       )),
                                                // )
                                              ]),
                                        ),
                                        4.verticalSpace,
                                        (item["DiscountPercent"] == 0)
                                            ? Row(
                                                children: [
                                                  Text(
                                                    ' ${item["PriceAfterDiscount"]} ',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
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
                                                      fontWeight:
                                                          FontWeight.w300,
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
                                                      fontWeight:
                                                          FontWeight.w300,
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
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Monadi',
                                                    ),
                                                  ),
                                                  10.horizontalSpace,
                                                  Text(
                                                    ' ${item["Price"]}',
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.red,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Monadi',
                                                    ),
                                                  ),
                                                  Text(
                                                    'د.ك',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.red,
                                                      fontFamily: 'Monadi',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        2.verticalSpace,
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            (appModel.activeLanguage
                                                        .languageCode ==
                                                    'ar')
                                                ? '${item["ProductArName"]}'
                                                : '${item["ProductEnName"]}',
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w300,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 2),
                                        color: Colors.red,
                                        child: Text(
                                          '%${item["DiscountPercent"]}خصم',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (item["StockQuantity"] == 0.0)
                                    Image.asset(AppAssets.OutOfStock),
                                  // Positioned(
                                  //   top: 0,
                                  //
                                  //   left:0,
                                  //
                                  //
                                  //   child:
                                  //   IconButton(
                                  //     icon: itemLoveStates[index]
                                  //         ? Icon(Icons.favorite, color: Colors.red) // Love Active
                                  //         : Icon(Icons.favorite_border), // Love Inactive
                                  //     onPressed: () {
                                  //       setState(() {
                                  //         itemLoveStates[index] = !itemLoveStates[index]; // Toggle Love state
                                  //       });
                                  //       getDataFavoriteFromApi.AddItemFavoritePost(CustomerPhone:'${UserPhone}', ProductID: item["ProductID"].toString());
                                  //
                                  //       if (itemLoveStates[index]) {
                                  //
                                  //         getDataFavoriteFromApi.AddItemFavoritePost(CustomerPhone: '${UserPhone}', ProductID: item["ProductID"].toString());
                                  //       } else {
                                  //
                                  //         print('delet');
                                  //       }
                                  //
                                  //
                                  //     },
                                  //   ),
                                  //
                                  // )
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
      }),
    );
  }
}

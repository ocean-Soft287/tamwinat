// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/riverpodOneSystem/notifierOneSystem.dart';
// import '../../../../core/constants/constants.dart';
// import '../../../../core/routes/app_router.gr.dart';
// import '../../../../core/utils/utils.dart';
// import '../../../components/components.dart';
// import '../../../theme/theme.dart';
// import '../../pages.dart';
// import '../riverpod/provider/main_bottom_provider.dart';
// import '../shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
// import 'riverpod/provider/filtered_shops_in_pickup_provider.dart';
// import 'riverpod/provider/saved_shops_in_pickup_provider.dart';
// import 'riverpod/provider/shop_groups_in_pickup_provider.dart';
//
// class PickupPage extends ConsumerStatefulWidget {
//   const PickupPage({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<PickupPage> createState() => _PickupPageState();
// }
//
// class _PickupPageState extends ConsumerState<PickupPage> {
//   late ScrollController _scrollController;
//   int counterQuntati = 0;
//   bool isSecondContainerVisible = false;
//   List<bool> itemLoveStates = List.generate(10, (index) => false);
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(
//       () {
//         if (_scrollController.position.userScrollDirection ==
//             ScrollDirection.reverse) {
//           ref.read(mainBottomProvider.notifier).setVisible(false);
//         }
//         if (_scrollController.position.userScrollDirection ==
//             ScrollDirection.forward) {
//           ref.read(mainBottomProvider.notifier).setVisible(true);
//         }
//       },
//     );
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) {
//         // ref.read(savedShopsInPickupProvider.notifier).fetchSavedShops(
//         //   checkYourNetwork: () {
//         //     AppHelpers.showCheckFlash(
//         //       context,
//         //       AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
//         //     );
//         //   },
//         // );
//         // ref.read(filteredShopsInPickupProvider.notifier).fetchFilteredShops(
//         //   checkYourNetwork: () {
//         //     AppHelpers.showCheckFlash(
//         //       context,
//         //       AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
//         //     );
//         //   },
//         // );
//         // ref.read(shopGroupsInPickupProvider.notifier).fetchShopGroups(
//         //   checkYourNetwork: () {
//         //     AppHelpers.showCheckFlash(
//         //       context,
//         //       AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
//         //     );
//         //   },
//         // );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColors.white,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Consumer(
//             builder: (context, ref, child) {
//               final savedShopsInDeliveryState =
//                   ref.watch(savedShopsInPickupProvider);
//               return SavedShopsBody(
//                 fromDelivery: false,
//                 isLoading: savedShopsInDeliveryState.isSavedShopsLoading,
//                 shops: savedShopsInDeliveryState.savedShops,
//               );
//             },
//           ),
//
//           Padding(
//             padding: REdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'كل المنتجات',
//                   //  AppHelpers.getTranslation(TrKeys.allShops),
//                   style: GoogleFonts.inter(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 20.sp,
//                     color: AppColors.iconAndTextColor(),
//                     letterSpacing: -1,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () => context.pushRoute(const ViewOnMapRoute()),
//                   child: Text(
//                     AppHelpers.getTranslation(TrKeys.viewOnMap),
//                     style: GoogleFonts.inter(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14.sp,
//                       color: AppColors.blue,
//                       letterSpacing: -0.5,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//
//           Consumer(
//             builder: (context, ref, child) {
//               final groupsState = ref.watch(shopGroupsInPickupProvider);
//               final groupsNotifier =
//                   ref.read(shopGroupsInPickupProvider.notifier);
//               return SizedBox(
//                 height: 34.r,
//                 child: groupsState.isLoading
//                     ? const HorizontalListShimmer(
//                         horizontalPadding: 16,
//                         itemBorderRadius: 100,
//                         itemWidth: 100,
//                         spacing: 8,
//                       )
//                     : ListView.builder(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         padding: REdgeInsets.symmetric(horizontal: 16),
//                         itemCount: groupsState.groups.length + 1,
//                         itemBuilder: (context, index) {
//                           return index == 0
//                               ? ShopGroupItem(
//                                   title: AppHelpers.getTranslation(TrKeys.all),
//                                   onTap: () {
//                                     groupsNotifier.setActiveIndex(0);
//                                     ref
//                                         .read(filteredShopsInPickupProvider
//                                             .notifier)
//                                         .updateFilteredShops(context,
//                                             groupId: null);
//                                   },
//                                   isSelected:
//                                       groupsState.activeGroupIndex == index,
//                                 )
//                               : ShopGroupItem(
//                                   title: groupsState
//                                       .groups[index - 1].translation?.title,
//                                   onTap: () {
//                                     groupsNotifier.setActiveIndex(index);
//                                     ref
//                                         .read(filteredShopsInPickupProvider
//                                             .notifier)
//                                         .updateFilteredShops(context,
//                                             groupId: groupsState
//                                                 .groups[index - 1].id);
//                                   },
//                                   isSelected:
//                                       groupsState.activeGroupIndex == index,
//                                 );
//                         },
//                       ),
//               );
//             },
//           ),
//
//           4.verticalSpace,
//
//           Consumer(
//             builder: (context, ref, child) {
//               final listItemOrder = ref.watch(orderProviderList);
//               final listItemOrderImage = ref.watch(orderProviderListImage);
//               final getDataFromApi = ref.watch(getDataFromApiProvider);
//
//               int _getCrossAxisCount(BuildContext context) {
//                 final screenWidth = MediaQuery.of(context).size.width;
//                 // Adjust the values as per your needs
//                 if (screenWidth >= 1200) {
//                   return 4; // 4 items per row for large screens
//                 } else if (screenWidth >= 800) {
//                   return 3; // 3 items per row for medium screens
//                 } else {
//                   return 2; // 2 items per row for small screens
//                 }
//               }
//
//               double _getAspectRatio(BuildContext context) {
//                 final crossAxisCount = _getCrossAxisCount(context);
//                 // Adjust the values as per your needs
//                 if (crossAxisCount == 4) {
//                   return 0.75; // Wider aspect ratio for large screens
//                 } else {
//                   return 0.8; // Regular aspect ratio for medium and small screens
//                 }
//               }
//
//               return Expanded(
//                   child: Padding(
//                 padding: REdgeInsets.symmetric(horizontal: 8.0),
//                 child: getDataFromApi.dataCategoryAllList.isEmpty
//                     ? const GridListShimmer(
//                         itemCount: 10,
//                         isScrollable: true,
//                         onlyBottomPadding: 10,
//                         verticalPadding: 10,
//                       )
//                     : GridView.builder(
//                         itemCount: getDataFromApi.dataCategoryAllList.length,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: _getCrossAxisCount(context),
//                           childAspectRatio: _getAspectRatio(context),
//                           crossAxisSpacing: 2,
//                           mainAxisSpacing: 5,
//                         ),
//                         itemBuilder: (context, index) {
//                           final item =
//                               getDataFromApi.dataCategoryAllList[index];
//                           int q1 = listItemOrder.getQuantity(
//                               itemID: getDataFromApi.dataCategoryAllList[index]
//                                   ['ProductID']);
//                           return Card(
//                             color: Colors.white,
//                             child:
//                             Container(
//                               color: Colors.white,
//                               child: InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     //getDataFromApi.dataCategoryAllList[index]["productId"]
//                                     MaterialPageRoute(
//                                         builder: (context) => BannerDetailsPage(
//                                               productId: getDataFromApi
//                                                       .dataCategoryAllList[index]
//                                                   ["ProductID"],
//                                             )),
//                                   );
//                                 },
//                                 child: Stack(
//
//                                   children: [
//                                     Padding(
//                                       padding:
//                                           REdgeInsets.symmetric(horizontal: 8.0),
//                                       child: Column(
//                                         children: [
//                                           Stack(
//                                               alignment: Alignment.bottomRight,
//                                               children: [
//                                                 Container(
//                                                   width: MediaQuery.of(context)
//                                                       .size
//                                                       .width,
//                                                   height: 130,
//                                                   child: Image.network(
//                                                     '${item['ProductcImage']}',
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     setState(() {
//
//                                                       isSecondContainerVisible =
//                                                           !isSecondContainerVisible;
//
//                                                     });
//
//                                                     setState(() {
//                                                       if(q1==0)
//                                                         {
//                                                           q1++;
//                                                           print(q1);
//                                                         }
//                                                       listItemOrder
//                                                           .addItem({
//                                                         "ItemID":
//                                                         item["ProductID"],
//                                                         "Quantity":
//                                                         q1,
//                                                         "Price":
//                                                         item["Price"]
//                                                       });
//                                                       listItemOrderImage
//                                                           .addItem({
//                                                         "image":
//                                                         item["ProductcImage"],
//                                                         "ItemID":
//                                                         item["ProductID"],
//                                                         "Quantity":
//                                                         q1,
//                                                         "Price":
//                                                         item["Price"],
//                                                         "ProductArName":
//                                                         item["ProductArName"]
//                                                       });
//                                                     });
//
//                                                     if (isSecondContainerVisible) {
//                                                       Future.delayed(
//                                                           Duration(
//                                                               milliseconds:
//                                                                   10000), () {
//                                                         setState(() {
//                                                           isSecondContainerVisible =
//                                                               false;
//                                                         });
//                                                       });
//                                                     }
//                                                   },
//                                                   child:
//                                                       !isSecondContainerVisible
//                                                           ? Card(
//                                                             child: Container(
//                                                                 height: 40.h,
//                                                                 width: 35.w,
//
//                                                             color: (q1>=1)?Colors.green:Colors.white,
//
//                                                                 child: Center(
//                                                                   child: Text(    (q1>=1)?'${q1}':'+',
//                                                                       style:
//                                                                           TextStyle(
//                                                                             fontWeight: FontWeight.w500,
//                                                                         fontSize:
//                                                                             20.sp,
//                                                                         color:(q1>=1)?Colors.white:Colors.orange,
//
//                                                                       )),
//                                                                 ),
//                                                               ),
//                                                           )
//                                                           : Container(
//                                                               height: 40,
//                                                           decoration: BoxDecoration(
//                                                             color: Colors.white,
//                                                             borderRadius: BorderRadius.circular(10),
//                                                             boxShadow: [
//                                                               BoxShadow(
//                                                                 color: Colors.grey.withOpacity(0.5),
//                                                                 spreadRadius: 5,
//                                                                 blurRadius: 7,
//                                                                 offset: Offset(0, 3),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                               child: Row(
//                                                                 children: [
//                                                                   TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       if (q1 >
//                                                                           0) {
//                                                                         setState(
//                                                                             () {
//                                                                               q1--;
//                                                                         });
//                                                                       }
//                                                                       if (q1 ==
//                                                                           0) {}
//                                                                       listItemOrder
//                                                                           .decreaseQuantity(
//                                                                               item["ProductID"]);
//                                                                       listItemOrderImage
//                                                                           .decreaseQuantity(
//                                                                               item["ProductID"]);
//                                                                     },
//                                                                     child: Text(
//                                                                       '-',
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontSize:
//                                                                             20.sp,
//                                                                         color: Colors.orange,
//                                                                             fontWeight: FontWeight.w500,
//                                                                         fontFamily:
//                                                                             'Monadi',
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Center(
//                                                                     child: Text(
//                                                                       '${q1}',
//                                                                       maxLines:
//                                                                           2,
//                                                                       overflow:
//                                                                           TextOverflow
//                                                                               .ellipsis,
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontSize:
//                                                                             16.sp,
//                                                                         color: Colors
//                                                                             .black,
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         fontFamily:
//                                                                             'Monadi',
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                           if (q1 <
//                                                                               item
//                                                                               ["StockQuantity"])
//                                                                             {
//                                                                               setState(
//                                                                                       () {
//                                                                                     q1++;
//                                                                                   });
//                                                                               listItemOrder
//                                                                                   .addItem({
//                                                                                 "ItemID":
//                                                                                 item["ProductID"],
//                                                                                 "Quantity":
//                                                                                 q1,
//                                                                                 "Price":
//                                                                                 item["Price"]
//                                                                               });
//                                                                               listItemOrderImage
//                                                                                   .addItem({
//                                                                                 "image":
//                                                                                 item["ProductcImage"],
//                                                                                 "ItemID":
//                                                                                 item["ProductID"],
//                                                                                 "Quantity":
//                                                                                 q1,
//                                                                                 "Price":
//                                                                                 item["Price"],
//                                                                                 "ProductArName":
//                                                                                 item["ProductArName"]
//                                                                               });
//
//                                                                             }
//
//
//                                                                     },
//                                                                     child: Text(
//                                                                       '+',
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontSize:
//                                                                             20.sp,
//                                                                         color: Colors.orange,
//                                                                         fontWeight:
//                                                                             FontWeight.w500,
//                                                                         fontFamily:
//                                                                             'Monadi',
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               )),
//                                                 )
//                                               ]),
//
//
//                                           4.verticalSpace,
//                                           (item["DiscountPercent"]==null)?
//                                           Row(
//                                             textDirection: TextDirection.rtl,
//                                             children: [
//
//
//
//                                               Text(
//                                                 ' ${item["Price"]}',
//                                                 style: TextStyle(
//
//                                                   fontSize: 16.sp,
//                                                   fontWeight: FontWeight.w300,
//                                                   fontFamily: 'Monadi',
//                                                 ),
//                                               ),
//
//                                               Text(
//                                                 'د.ك',
//                                                 style: TextStyle(
//                                                   fontSize: 16.sp,
//                                                   fontWeight: FontWeight.w300,
//
//                                                   fontFamily: 'Monadi',
//                                                 ),
//                                               ),
//
//                                             ],
//
//                                           ):
//
//                                           Row(
//                                             textDirection: TextDirection.rtl,
//                                             children: [
//
//
//
//                                               Text(
//                                                 '${((item["DiscountPercent"]/100)*item["Price"]).toStringAsFixed(3)}',
//                                                 style: TextStyle(
//
//                                                   fontSize: 16.sp,
//                                                   fontWeight: FontWeight.w300,
//                                                   fontFamily: 'Monadi',
//                                                 ),
//                                               ),
//
//                                               Text(
//                                                 'د.ك',
//                                                 style: TextStyle(
//                                                   fontSize: 16.sp,
//                                                   fontWeight: FontWeight.w300,
//
//                                                   fontFamily: 'Monadi',
//                                                 ),
//                                               ),
//                                               10.horizontalSpace,
//                                               Text(
//                                                 ' ${item["Price"]}',
//                                                 style: TextStyle(
//                                                   decoration: TextDecoration.lineThrough,
//                                                   color: Colors.red,
//                                                   fontSize: 16.sp,
//                                                   fontWeight: FontWeight.w300,
//                                                   fontFamily: 'Monadi',
//                                                 ),
//                                               ),
//
//                                               Text(
//                                                 'د.ك',
//                                                 style: TextStyle(
//                                                   fontSize: 16.sp,
//                                                   fontWeight: FontWeight.w300,
//                                                   decoration: TextDecoration.lineThrough,
//                                                   color: Colors.red,
//                                                   fontFamily: 'Monadi',
//                                                 ),
//                                               ),
//
//                                             ],
//
//                                           ),
//
//                                           2.verticalSpace,
//                                           Expanded(
//                                             child: Text(
//                                               '${item["ProductArName"]}',
//                                               textDirection: TextDirection.rtl,
//                                               style: TextStyle(
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w300,
//                                                 fontFamily: 'Monadi',
//                                               ),
//                                             ),
//                                           ),
//
//
//
//                                         ],
//                                       ),
//                                     ),
//
//                                     // Container(
//                                     //   width: 40,
//                                     //   color: Colors.indigo,
//                                     //   child: Column(
//                                     //     mainAxisSize: MainAxisSize.min,
//                                     //     children: [
//                                     //       TextButton(
//                                     //         onPressed: () {
//                                     //           if (counterQuntati > 0) {
//                                     //             setState(() {
//                                     //               counterQuntati--;
//                                     //             });
//                                     //           }
//                                     //           if (counterQuntati == 0) {
//                                     //
//                                     //           }
//                                     //           listItemOrder.decreaseQuantity(item
//                                     //           ["ProductID"]);
//                                     //           listItemOrderImage.decreaseQuantity(item
//                                     //           ["ProductID"]);
//                                     //
//                                     //
//                                     //         },
//                                     //         child: Text(
//                                     //           '-',
//                                     //           style: TextStyle(
//                                     //             fontSize: 20.sp,
//                                     //             color: Colors.white,
//                                     //             fontWeight: FontWeight.normal,
//                                     //             fontFamily: 'Monadi',
//                                     //           ),
//                                     //         ),
//                                     //       ),
//                                     //       Center(
//                                     //         child: Text(
//                                     //           '${q1}',
//                                     //           maxLines: 2,
//                                     //           overflow: TextOverflow.ellipsis,
//                                     //           style: TextStyle(
//                                     //             fontSize: 20.sp,
//                                     //             color: Colors.white,
//                                     //             fontWeight: FontWeight.bold,
//                                     //             fontFamily: 'Monadi',
//                                     //           ),
//                                     //         ),
//                                     //       ),
//                                     //       TextButton(
//                                     //         onPressed: () {
//                                     //           setState(() {
//                                     //             counterQuntati++;
//                                     //
//                                     //           });
//                                     //           listItemOrder.addItem({
//                                     //             "ItemID": item
//                                     //
//                                     //             ["ProductID"],
//                                     //             "Quantity": counterQuntati,
//                                     //             "Price": item
//                                     //
//                                     //             ["Price"]
//                                     //           });
//                                     //           listItemOrderImage.addItem({
//                                     //             "image": item
//                                     //
//                                     //             ["ProductcImage"],
//                                     //             "ItemID": item
//                                     //
//                                     //             ["ProductID"],
//                                     //             "Quantity": counterQuntati,
//                                     //             "Price": item
//                                     //
//                                     //             ["Price"],
//                                     //             "ProductArName": item
//                                     //
//                                     //             ["ProductArName"]
//                                     //           });
//                                     //
//                                     //
//                                     //         },
//                                     //         child: Text(
//                                     //           '+',
//                                     //           style: TextStyle(
//                                     //             fontSize: 22.sp,
//                                     //             color: Colors.white,
//                                     //             fontWeight: FontWeight.normal,
//                                     //             fontFamily: 'Monadi',
//                                     //           ),
//                                     //         ),
//                                     //       ),
//                                     //     ],
//                                     //   ),
//                                     //   // Text(
//                                     //   //   '${20}% OFF',
//                                     //   //   style: TextStyle(
//                                     //   //     color: Colors.white,
//                                     //   //     fontWeight: FontWeight.bold,
//                                     //   //   ),
//                                     //   // ),
//                                     // ),
//                                     if(item["DiscountPercent"]!=null)
//                                     Positioned(
//                                       top: 0,
//                                       right: 0,
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 8, vertical: 4),
//                                         color: Colors.red,
//                                         child: Text(
//                                           '${20}% OFF',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     if(item["StockQuantity"]==0.0)
//                                     Image.asset(AppAssets.OutOfStock),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//               ));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Fatora extends StatelessWidget {
//   Fatora({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0.0,
//           title: Text(
//             'الفاتوره',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w300,
//               fontFamily: 'Monadi',
//               letterSpacing: 1.1,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             20.verticalSpace,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: ' التاريخ : ',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.black,
//                           fontWeight: FontWeight.normal,
//                           fontFamily: 'Monadi',
//                         ),
//                       ),
//                       TextSpan(
//                         text: '18/12/20214',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.indigo,
//                           fontWeight: FontWeight.w300,
//                           fontFamily: 'Monadi',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'رقم الفاتوره : ',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.black,
//                           fontWeight: FontWeight.normal,
//                           fontFamily: 'Monadi',
//                         ),
//                       ),
//                       TextSpan(
//                         text: '34',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.indigo,
//                           fontWeight: FontWeight.w300,
//                           fontFamily: 'Monadi',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             10.verticalSpace,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: ' وقت الطباعه ',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.black,
//                           fontWeight: FontWeight.normal,
//                           fontFamily: 'Monadi',
//                         ),
//                       ),
//                       TextSpan(
//                         text: '18/12/20214',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.indigo,
//                           fontWeight: FontWeight.w300,
//                           fontFamily: 'Monadi',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'البائع : ',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.black,
//                           fontWeight: FontWeight.normal,
//                           fontFamily: 'Monadi',
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'الكوبيل',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.indigo,
//                           fontWeight: FontWeight.w300,
//                           fontFamily: 'Monadi',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             10.verticalSpace,
//             RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: '  الزبون : ',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.black,
//                       fontWeight: FontWeight.normal,
//                       fontFamily: 'Monadi',
//                     ),
//                   ),
//                   TextSpan(
//                     text: 'نقدا',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.indigo,
//                       fontWeight: FontWeight.w300,
//                       fontFamily: 'Monadi',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             10.verticalSpace,
//             Text(
//               '9.0',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w300,
//                 fontFamily: 'Monadi',
//                 letterSpacing: 1.1,
//               ),
//             ),
//             20.verticalSpace,
//             Container(
//               color: Colors.indigo,
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     'الاجمالى ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w300,
//                       fontFamily: 'Monadi',
//                       letterSpacing: 1.1,
//                     ),
//                   ),
//                   Text(
//                     'السعر',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w300,
//                       fontFamily: 'Monadi',
//                       letterSpacing: 1.1,
//                     ),
//                   ),
//                   Text(
//                     'الكميه',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w300,
//                       fontFamily: 'Monadi',
//                       letterSpacing: 1.1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 3,
//                 itemBuilder: (context, index) => Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text(
//                           'الاجمالى ',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'Monadi',
//                             letterSpacing: 1.1,
//                           ),
//                         ),
//                         Text(
//                           'السعر',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'Monadi',
//                             letterSpacing: 1.1,
//                           ),
//                         ),
//                         Text(
//                           'الكميه',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'Monadi',
//                             letterSpacing: 1.1,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Divider(thickness: 1),
//                   ],
//                 ),
//               ),
//             ),
//             10.verticalSpace,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: ' اجمالى الكميه : ',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.black,
//                           fontWeight: FontWeight.normal,
//                           fontFamily: 'Monadi',
//                         ),
//                       ),
//                       TextSpan(
//                         text: '3',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.indigo,
//                           fontWeight: FontWeight.w300,
//                           fontFamily: 'Monadi',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: ' الاجمالى  : ',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.black,
//                           fontWeight: FontWeight.normal,
//                           fontFamily: 'Monadi',
//                         ),
//                       ),
//                       TextSpan(
//                         text: '99',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.indigo,
//                           fontWeight: FontWeight.w300,
//                           fontFamily: 'Monadi',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             10.verticalSpace,
//             RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: ' الخصم : ',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.black,
//                       fontWeight: FontWeight.normal,
//                       fontFamily: 'Monadi',
//                     ),
//                   ),
//                   TextSpan(
//                     text: '3',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.indigo,
//                       fontWeight: FontWeight.w300,
//                       fontFamily: 'Monadi',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             10.verticalSpace,
//             RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: ' الصافى : ',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.black,
//                       fontWeight: FontWeight.normal,
//                       fontFamily: 'Monadi',
//                     ),
//                   ),
//                   TextSpan(
//                     text: '3',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.indigo,
//                       fontWeight: FontWeight.w300,
//                       fontFamily: 'Monadi',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }

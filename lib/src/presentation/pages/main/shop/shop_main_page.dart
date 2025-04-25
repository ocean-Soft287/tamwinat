// import 'dart:io';
// import 'dart:ui';
//
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_remix/flutter_remix.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../core/constants/constants.dart';
// import '../../../../core/routes/app_router.gr.dart';
// import '../../../../core/utils/utils.dart';
// import '../../../../riverpod/provider/app_provider.dart';
// import '../../../components/components.dart';
// import '../../../theme/theme.dart';
// import 'details/riverpod/provider/shop_category_products_provider.dart';
//
// import 'widgets/shop_bottom_navigation_item.dart';
//
// class ShopMainPage extends ConsumerStatefulWidget {
//   final int? shopId;
//   final bool fromDelivery;
//
//   const ShopMainPage({Key? key, this.shopId, required this.fromDelivery})
//       : super(key: key);
//
//   @override
//   ConsumerState<ShopMainPage> createState() => _ShopMainPageState();
// }
//
// class _ShopMainPageState extends ConsumerState<ShopMainPage> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) {
//
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ref.watch(appProvider);
//     return KeyboardDismisser(
//       child: AutoTabsScaffold(
//         backgroundColor: AppColors.mainBackground(),
//         appBarBuilder: (context, tabsRouter) {
//           return tabsRouter.activeIndex == 1
//               ? CommonAppBar(
//                   title: AppHelpers.getTranslation(TrKeys.recipes),
//                   hasBack: false,
//                   onLeadingPressed: context.popRoute,
//                 )
//               : (tabsRouter.activeIndex == 2
//                   ? CommonAppBar(
//                       title: AppHelpers.getTranslation(TrKeys.discounts),
//                       hasBack: false,
//                       onLeadingPressed: context.popRoute,
//                     )
//                   : const PreferredSize(
//                       preferredSize: Size.fromHeight(0),
//                       child: SizedBox.shrink(),
//                     ));
//         },
//         routes: [
//           ShopDetailsRoute(
//             shopId: widget.shopId,
//             fromDelivery: widget.fromDelivery,
//           ),
//           ShopRecipesRoute(shopId: widget.shopId),
//           SavedProductsRoute(shopId: widget.shopId),
//         ],
//         bottomNavigationBuilder: (context, tabRouter) {
//           return Consumer(
//             builder: (context, ref, child) {
//
//               return ClipRRect(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 1000),
//                     curve: Curves.fastLinearToSlowEaseIn,
//                     height: bottomState.isVisible
//                         ? (Platform.isAndroid ? 75.r : 97.r)
//                         : 0,
//                     decoration: BoxDecoration(
//                       color: AppColors.mainAppbarBack(),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.mainAppbarShadow(),
//                           spreadRadius: 25.r,
//                           blurRadius: 35.r,
//                           offset: Offset(0.r, 0.r),
//                         ),
//                       ],
//                     ),
//                     padding: REdgeInsets.only(
//                       bottom: Platform.isAndroid ? 0 : 12,
//                     ),
//                     alignment: Alignment.center,
//                     child: Consumer(
//                       builder: (context, ref, child) {
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             ShopBottomNavigationItem(
//                               iconData: FlutterRemix.home_fill,
//                               isSelected: tabRouter.activeIndex == 0,
//                               label: AppHelpers.getTranslation(TrKeys.home),
//                               onTap: () {
//                                 tabRouter.setActiveIndex(0);
//                               },
//                             ),
//                             ShopBottomNavigationItem(
//                               iconData: FlutterRemix.restaurant_fill,
//                               isSelected: tabRouter.activeIndex == 1,
//                               label: AppHelpers.getTranslation(TrKeys.recipes),
//                               onTap: () {
//                                 tabRouter.setActiveIndex(1);
//                               },
//                             ),
//                             ShopBottomNavigationItem(
//                               iconData: FlutterRemix.percent_fill,
//                               isSelected: tabRouter.activeIndex == 2,
//                               label:
//                                   AppHelpers.getTranslation(TrKeys.discounts),
//                               onTap: () {
//                                 tabRouter.setActiveIndex(2);
//                               },
//                             ),
//                             ShopBottomNavigationItem(
//                               iconData: FlutterRemix.shopping_bag_3_fill,
//                               isSelected: tabRouter.activeIndex == 3,
//                               label: AppHelpers.getTranslation(TrKeys.cart),
//                               onTap: () {
//                                 if (LocalStorage.instance.getUser() == null) {
//                                   context.router.popUntilRoot();
//                                   context.replaceRoute(const LoginRoute());
//                                   AppHelpers.showCheckFlash(
//                                     context,
//                                     AppHelpers.getTranslation(
//                                         TrKeys.youNeedToLoginFirst),
//                                   );
//                                 } else {
//                                   context.pushRoute(
//                                     CartRoute(shopId: widget.shopId),
//                                   );
//                                 }
//                               },
//                             ),
//                             GestureDetector(
//                               onTap: () => context.pushRoute(
//                                 ProfileRoute(shopId: widget.shopId),
//                               ),
//                               child: CommonImage(
//                                 imageUrl: LocalStorage.instance.getUser()?.img,
//                                 width: 40,
//                                 height: 40,
//                                 radius: 20,
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

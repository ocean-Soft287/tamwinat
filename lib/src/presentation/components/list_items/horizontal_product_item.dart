import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../../theme/theme.dart';
import '../buttons/common_material_button.dart';
import '../common_image.dart';
import '../increase_decrease_buttons.dart';
import '../small_dot.dart';

class HorizontalProductItem extends StatelessWidget {
  final ProductData product;
  final int? shopId;
  final Function() onLikePressed;
  final Function() onIncrease;
  final Function() onDecrease;

  const HorizontalProductItem({
    Key? key,
    required this.product,
    required this.onLikePressed,
    required this.onIncrease,
    required this.onDecrease,
    this.shopId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290.r,
      margin: EdgeInsetsDirectional.only(end: 8.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.mainAppbarBack(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pushRoute(
              ProductRoute(product: product, shopId: shopId ?? product.shopId),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    topLeft: Radius.circular(10.r),
                  ),
                  child: CommonImage(
                    imageUrl: product.product?.img,
                    height: 126,
                    width: 170,
                    radius: 0,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  right: 16.r,
                  top: 16.r,
                  child: GestureDetector(
                    onTap: onLikePressed,
                    child: Icon(
                      AppHelpers.isLikedProduct(product.id)
                          ? FlutterRemix.heart_fill
                          : FlutterRemix.heart_line,
                      size: 24.r,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context
                .pushRoute(ProductRoute(product: product, shopId: shopId)),
            child: Container(
              width: 170.r,
              padding: REdgeInsets.symmetric(horizontal: 16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  8.verticalSpace,
                  Text(
                    '${product.product?.translation?.title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: AppColors.iconAndTextColor(),
                      letterSpacing: -0.4,
                    ),
                  ),
                  6.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FlutterRemix.star_smile_fill,
                            color: AppColors.warning,
                            size: 17.r,
                          ),
                          8.horizontalSpace,
                          Text(
                            '${product.ratingAvg ?? 0.0}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: AppColors.secondaryIconTextColor(),
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                      if (product.bonus != null)
                        Row(
                          children: [
                            Icon(
                              FlutterRemix.gift_2_fill,
                              color: AppColors.red,
                              size: 17.r,
                            ),
                            8.horizontalSpace,
                            Text(
                              AppHelpers.getTranslation(TrKeys.bonus),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.red,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  if (product.discount != null && product.discount != 0)
                    Column(
                      children: [
                        8.verticalSpace,
                        Row(
                          children: [
                            Text(
                              NumberFormat.currency(
                                symbol: LocalStorage.instance
                                    .getSelectedCurrency()
                                    ?.symbol,
                              ).format(product.price),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.iconAndTextColor(),
                                letterSpacing: -0.4,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            8.horizontalSpace,
                            const SmallDot(),
                            8.horizontalSpace,
                            Text(
                              '${(((product.discount ?? 0) / (product.price ?? 1)) * 100).toStringAsFixed(1)}%',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.red,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  8.verticalSpace,
                  Text(
                    NumberFormat.currency(
                      symbol:
                          LocalStorage.instance.getSelectedCurrency()?.symbol,
                    ).format(
                      (product.discount != null && product.discount != 0)
                          ? product.discount
                          : product.price,
                    ),
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: AppColors.iconAndTextColor(),
                      letterSpacing: -0.4,
                    ),
                  ),
                  8.verticalSpace,
                ],
              ),
            ),
          ),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 10, vertical: 8),
            width: 170.r,
            decoration: BoxDecoration(
              color: AppColors.mainAppbarBack(),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            alignment: Alignment.center,
            child: ((product.quantity ?? 0) >= (product.minQty ?? 0))
                ? (((product.localCartCount ?? 0) > 0)
                    ? IncreaseDecreaseButtons(
                        onDecrease: onDecrease,
                        onIncrease: onIncrease,
                        cartCount: product.localCartCount,
                        unit: product.product?.unit,
                      )
                    : CommonMaterialButton(
                        text: AppHelpers.getTranslation(TrKeys.addToCart),
                        height: 36,
                        horizontalPadding: 0,
                        borderRadius: 10,
                        color: AppColors.secondaryBack(),
                        fontColor: AppColors.iconAndTextColor(),
                        fontWeight: FontWeight.w600,
                        onTap: () {
                          if (LocalStorage.instance.getUser() == null) {
                            context.router.popUntilRoot();
                            context.replaceRoute(const LoginRoute());
                            // AppHelpers.showCheckFlash(
                            //   context,
                            //   AppHelpers.getTranslation(
                            //       TrKeys.youNeedToLoginFirst),
                            // );
                            return;
                          }
                          onIncrease();
                        },
                      ))
                : SizedBox(
                    height: 40.r,
                    child: Center(
                      child: Text(
                        AppHelpers.getTranslation(TrKeys.outOfStock),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: AppColors.red,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                  ),
            // child: ((product.quantity ?? 0) >= (product.minQty ?? 0))
            //     ? Stack(
            //         children: [
            //           AnimatedSwitcher(
            //             duration: const Duration(milliseconds: 200),
            //             child: (product.isChoosing ?? false)
            //                 ? SizedBox(height: 40.r)
            //                 : Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Expanded(
            //                         child: Text(
            //                           NumberFormat.currency(
            //                             symbol: LocalStorage.instance
            //                                 .getSelectedCurrency()
            //                                 ?.symbol,
            //                           ).format(product.price),
            //                           style: GoogleFonts.inter(
            //                             fontWeight: FontWeight.w700,
            //                             fontSize: 16.sp,
            //                             color: AppColors.iconAndTextColor(),
            //                             letterSpacing: -0.4,
            //                           ),
            //                         ),
            //                       ),
            //                       CircleIconButton(
            //                         isLoading: product.isLoading,
            //                         onTap: () {
            //                           if (LocalStorage.instance.getUser() ==
            //                               null) {
            //                             context.router.popUntilRoot();
            //                             context
            //                                 .replaceRoute(const LoginRoute());
            //                             AppHelpers.showCheckFlash(
            //                               context,
            //                               AppHelpers.getTranslation(
            //                                   TrKeys.youNeedToLoginFirst),
            //                             );
            //                           }
            //                           setIsChoosing();
            //                         },
            //                         iconData: product.localCartCount != 0
            //                             ? FlutterRemix.shopping_bag_3_line
            //                             : FlutterRemix.add_line,
            //                         backgroundColor: AppColors.onBoardingDot(),
            //                         iconColor: product.localCartCount != 0
            //                             ? AppColors.green
            //                             : AppColors.iconAndTextColor(),
            //                         badgeCount: product.localCartCount != 0
            //                             ? product.localCartCount
            //                             : null,
            //                       ),
            //                     ],
            //                   ),
            //           ),
            //           AnimatedPositioned(
            //             right: (product.isChoosing ?? false) ? 0 : -160,
            //             duration: const Duration(milliseconds: 200),
            //             child: IncreaseDecreaseButtons(
            //               onDecrease: onDecrease,
            //               onIncrease: onIncrease,
            //               cartCount: product.localCartCount,
            //               unit: product.product?.unit,
            //             ),
            //           ),
            //         ],
            //       )
            //     : SizedBox(
            //         height: 40.r,
            //         child: Center(
            //           child: Text(
            //             AppHelpers.getTranslation(TrKeys.outOfStock),
            //             style: GoogleFonts.inter(
            //               fontWeight: FontWeight.w700,
            //               fontSize: 14.sp,
            //               color: AppColors.red,
            //               letterSpacing: -0.4,
            //             ),
            //           ),
            //         ),
            //       ),
          ),
        ],
      ),
    );
  }
}

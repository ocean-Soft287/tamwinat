import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../components.dart';
import '../../theme/theme.dart';

class SearchShopsBody extends StatelessWidget {
  final bool isSearchLoading;
  final List<ShopData> searchedShops;
  final bool fromDelivery;

  const SearchShopsBody({
    Key? key,
    required this.isSearchLoading,
    required this.searchedShops,
    required this.fromDelivery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSearchLoading
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Padding(
                padding: EdgeInsetsDirectional.only(start: 15.r),
                child: Text(
                  AppHelpers.getTranslation(TrKeys.searchResults),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    color: AppColors.iconAndTextColor(),
                    letterSpacing: -1,
                  ),
                ),
              ),
              16.verticalSpace,
              const HorizontalListShimmer(horizontalPadding: 16),
            ],
          )
        : searchedShops.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 15.r),
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.searchResults),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                        color: AppColors.iconAndTextColor(),
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  SizedBox(
                    height: 256.r,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: searchedShops.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => HorizontalShopItem(
                        shop: searchedShops[index],
                        fromDelivery: fromDelivery,
                      ),
                    ),
                  ),
                ],
              )
            : Align(
                alignment: Alignment.topCenter,
                child: Lottie.asset(
                  AppAssets.lottieSearchEmpty,
                  width: 200.r,
                  height: 168.r,
                ),
              );
  }
}

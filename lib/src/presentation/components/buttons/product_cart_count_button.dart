import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/models.dart';
import '../../theme/theme.dart';
import 'circle_icon_button.dart';

class ProductCartCountButton extends StatelessWidget {
  final Function()? onTap;
  final Function()? onIncrease;
  final Function()? onDecrease;
  final String title;
  final int? count;
  final Unit? unit;

  const ProductCartCountButton({
    Key? key,
    required this.title,
    this.onTap,
    this.onIncrease,
    this.onDecrease,
    this.count,
    this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100.r),
      color: (count != null && count! > 0)
          ? AppColors.mainAppbarBack()
          : AppColors.green,
      child: InkWell(
        borderRadius: BorderRadius.circular(100.r),
        onTap: (count != null && count! > 0) ? null : onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
          ),
          height: 60.r,
          alignment: Alignment.center,
          child: (count != null && count! > 0)
              ? Padding(
                  padding: REdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleIconButton(
                        onTap: () {
                          if (onDecrease != null) {
                            onDecrease!();
                          }
                        },
                        iconData: FlutterRemix.subtract_line,
                        backgroundColor: AppColors.onBoardingDot(),
                        iconColor: AppColors.iconAndTextColor(),
                      ),
                      8.horizontalSpace,
                      Text(
                        '${count ?? 0} ${unit?.translation?.title}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                          color: AppColors.iconAndTextColor(),
                          letterSpacing: -0.4,
                        ),
                      ),
                      9.horizontalSpace,
                      CircleIconButton(
                        onTap: () {
                          if (onIncrease != null) {
                            onIncrease!();
                          }
                        },
                        iconData: FlutterRemix.add_line,
                        backgroundColor: AppColors.onBoardingDot(),
                        iconColor: AppColors.iconAndTextColor(),
                      ),
                    ],
                  ),
                )
              : Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    letterSpacing: -0.4,
                  ),
                ),
        ),
      ),
    );
  }
}

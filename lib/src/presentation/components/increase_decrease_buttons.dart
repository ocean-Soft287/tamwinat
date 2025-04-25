import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/models.dart';
import '../theme/theme.dart';
import 'buttons/circle_icon_button.dart';

class IncreaseDecreaseButtons extends StatelessWidget {
  final Function() onDecrease;
  final Function() onIncrease;
  final int? buttonSize;
  final int? cartCount;
  final Unit? unit;

  const IncreaseDecreaseButtons({
    Key? key,
    required this.onDecrease,
    required this.onIncrease,
    this.buttonSize,
    this.cartCount,
    this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleIconButton(
          onTap: onDecrease,
          iconData: FlutterRemix.subtract_line,
          backgroundColor: AppColors.onBoardingDot(),
          iconColor: AppColors.iconAndTextColor(),
          width: buttonSize,
        ),
        8.horizontalSpace,
        RichText(
          text: TextSpan(
            text: '${cartCount ?? 0} ',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: AppColors.iconAndTextColor(),
              letterSpacing: -0.4,
            ),
            children: <TextSpan>[
              TextSpan(
                text:
                '${(unit != null ? unit?.translation?.title : '')?.toLowerCase()}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                  color: AppColors.iconAndTextColor(),
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
        ),
        9.horizontalSpace,
        CircleIconButton(
          onTap: onIncrease,
          iconData: FlutterRemix.add_line,
          backgroundColor: AppColors.onBoardingDot(),
          iconColor: AppColors.iconAndTextColor(),
          width: buttonSize,
        ),
      ],
    );
  }
}

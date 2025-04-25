import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class ShopGroupItem extends StatelessWidget {
  final String? title;
  final Function() onTap;
  final bool isSelected;

  const ShopGroupItem({
    Key? key,
    this.title,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.r),
      child: Material(
        borderRadius: BorderRadius.circular(100.r),
        color: isSelected ? AppColors.green : AppColors.onBoardingDot(),
        child: InkWell(
          borderRadius: BorderRadius.circular(100.r),
          onTap: onTap,
          child: Container(
            height: 40.r,
            alignment: Alignment.center,
            padding: REdgeInsets.symmetric(horizontal: 19),
            child: Text(
              '$title',

              style: GoogleFonts.tajawal(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,

                color: isSelected ? Colors.white : Colors.black,


              ),

              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

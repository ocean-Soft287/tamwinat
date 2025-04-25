import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class ViewMoreButton extends StatelessWidget {
  final String title;
  final Function() onTap;

  const ViewMoreButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100.r),
      color: AppColors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100.r),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(
              color: AppColors.iconAndTextColor(),
              width: 2.r,
            ),
          ),
          alignment: Alignment.center,
          height: 60.r,
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              color: AppColors.iconAndTextColor(),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

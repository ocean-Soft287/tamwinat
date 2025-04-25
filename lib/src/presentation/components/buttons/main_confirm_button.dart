import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class MainConfirmButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final bool? isLoading;
  final Color? background;
  final int? fontSize;

  const MainConfirmButton({
    Key? key,
    required this.title,
    this.onTap,
    this.isLoading,
    this.background,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100.r),
      color: onTap != null
          ? (background ?? AppColors.green)
          : AppColors.unratedIcon(),
      child: InkWell(
        borderRadius: BorderRadius.circular(100.r),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
          ),
          height: 35.r,
          alignment: Alignment.center,
          child: (isLoading ?? false)
              ? SizedBox(
                  height: 20.r,
                  width: 20.r,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: 3.r,
                  ),
                )
              : Text(
                  title,
                  style: GoogleFonts.inter(

                    fontSize: (fontSize ?? 18).sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

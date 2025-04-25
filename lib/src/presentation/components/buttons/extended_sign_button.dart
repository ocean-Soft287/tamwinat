import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';
import 'facebook_button.dart';
import 'google_button.dart';

class ExtendedSignButton extends StatelessWidget {
  final String? title;
  final Function()? onSignInWithGoogle;
  final Function()? onSignInWithFacebook;
  final Function(String, String, String, String)? onSignInWithApple;
  final bool? isIos;
  final bool? loading;

  const ExtendedSignButton({
    Key? key,
    this.title,
    this.onSignInWithGoogle,
    this.onSignInWithFacebook,
    this.onSignInWithApple,
    this.isIos,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        color: AppColors.mainBackground(),
      ),
      padding: EdgeInsetsDirectional.only(start: 20.r, end: 8.r),
      child: Row(
        children: [
          Text(
            '$title',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: (Platform.isIOS ? 14 : 12).sp,
              letterSpacing: -0.4,
              color: AppColors.secondaryIconTextColor(),
            ),
          ),
          6.horizontalSpace,
          GoogleButton(onSubmit: onSignInWithGoogle),
          6.horizontalSpace,
          FacebookButton(onSubmit: onSignInWithFacebook),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/utils.dart';
import '../../theme/theme.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBack;
  final Function() onLeadingPressed;
  final List<Widget>? actions;
  final Color? backgroundColor; // اللون الاختياري

  const CommonAppBar({
    Key? key,
    required this.title,
    required this.onLeadingPressed,
    this.hasBack = true,
    this.actions,
    this.backgroundColor, // إضافة اللون هنا
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.instance.getLangLtr();
    return AppBar(
      backgroundColor:backgroundColor?? AppColors.mainAppbarBack(),
      elevation: 0,
      scrolledUnderElevation: 0.0,
      shadowColor: backgroundColor?? AppColors.mainAppbarBack(),
      leadingWidth: hasBack ? 56.r : 0,

      titleSpacing: hasBack ? 0 : NavigationToolbar.kMiddleSpacing,
      leading: hasBack
          ? IconButton(
              splashRadius: 18.r,
              onPressed: onLeadingPressed,
              padding: EdgeInsets.zero,
              icon: Icon(
                isLtr
                    ? FlutterRemix.arrow_left_s_line
                    : FlutterRemix.arrow_right_s_line,
                size: 32.r,
                color: AppColors.iconAndTextColor(),
              ),
            )
          : const SizedBox.shrink(),
      title: Text(
        title,
        style: GoogleFonts.tajawal(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.4,
          color: AppColors.iconAndTextColor(),
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Widget get child => const Text('Common appbar');

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/utils.dart';

class CustomCheckBox extends StatelessWidget {
  final bool? isChecked;

  const CustomCheckBox({Key? key, this.isChecked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = LocalStorage.instance.getAppThemeMode();
    return Icon(
      isChecked!
          ? FlutterRemix.checkbox_circle_fill
          : FlutterRemix.checkbox_blank_circle_line,
      size: 24.sp,
      color: isChecked!
          ? Colors.orange
          : isDarkMode
              ? const Color.fromRGBO(255, 255, 255, 1)
              : Colors.grey,
    );
  }
}

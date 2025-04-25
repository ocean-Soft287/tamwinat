import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../components/components.dart';

class LanguageItemWidget extends StatelessWidget {
  final bool? isChecked;
  final String? text;
  final String? imageUrl;
  final Function()? onPress;

  const LanguageItemWidget({
    Key? key,
    this.isChecked,
    this.text,
    this.imageUrl,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = LocalStorage.instance.getAppThemeMode();
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 4,vertical: 4),
      child: TextButton(

        style: ButtonStyle(

          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
        ),
        onPressed: onPress,
        child: Container(

          width:MediaQuery.of(context).size.width,
          height: 60.r,
          padding: REdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: isDarkMode
                    ? const Color.fromRGBO(23, 27, 32, 0.13)
                    : const Color.fromRGBO(169, 169, 150, 0.13),
                offset: const Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              )
            ],
            color:Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Colors.black
            )
          ),
          child: Row(
            children: <Widget>[
              CustomCheckBox(isChecked: isChecked),
              10.horizontalSpace,
              // Container(
              //   height: 15.r,
              //   width: 20.r,
              //   margin: REdgeInsets.only(left: 20, right: 8),
              //   child: CommonImage(
              //     imageUrl: imageUrl,
              //     height: 15,
              //     width: 20,
              //     radius: 0,
              //   ),
              // ),
              Text(
                '$text',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  letterSpacing: -0.5,
                  color: Colors.orange
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

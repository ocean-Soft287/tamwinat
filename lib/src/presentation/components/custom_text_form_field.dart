import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final IconData? icon;
  final String? hintText;
  final String? labelText;
  bool obscureText;
  final bool? eyes;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Color? iconColor;
  final Color colorFocus;
  final Color? colorInitally;
  final bool readOnly;
  final void Function()? onTap;
  final double? height;
  final TextDirection? textDirection;
  final TextAlignVertical? textAlignVertical;
  Color? cursorColor;
  CustomTextFormField(
      {super.key,
      required this.icon,
      this.eyes,
      this.onTap,
      this.colorFocus = Colors.black,
      this.colorInitally = Colors.grey,
      this.initialValue,
      this.validator,
      this.height,
      this.cursorColor = Colors.black,
      this.textAlignVertical,
      this.textDirection,
      this.obscureText = false,
      this.onSaved,
      this.readOnly = false,
      this.iconColor,
      this.hintText,
      this.controller,
      this.labelText});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return SizedBox(
          height: height,
          child: TextFormField(
            textDirection: textDirection,
            controller: controller,
            obscureText: obscureText,
            onSaved: onSaved,
            onTap: onTap,
            initialValue: initialValue,
            validator: validator,
            textAlignVertical: textAlignVertical,
            readOnly: readOnly,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                // helperText: "         ",
                // errorStyle: const TextStyle(
                //   fontSize: 0.01,
                // ),

                hintText: hintText,
                floatingLabelBehavior: FloatingLabelBehavior
                    .always, // to show the label in above always
                hintStyle:
                    TextStyle(fontSize: 12.sp, color: const Color(0xff727272)),
                suffixIcon: eyes == null
                    ? icon == null
                        ? null
                        : Icon(
                            icon,
                            color: iconColor == null
                                ? Color(0xff616161)
                                : iconColor,
                          )
                    : getImage(
                        show: obscureText,
                        onTap: () {
                          setState(() => obscureText = !obscureText);
                        }),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: labelText,
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500)),
          ),
        );
      },
    );
  }

  Widget getImage({required bool show, required void Function()? onTap}) =>
      InkWell(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        child: Icon(
          !show ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: colorFocus,
        ),
        onTap: onTap,
      );
}

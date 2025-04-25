
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../../../theme/app_colors.dart';

class MyStyledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Widget? suffixIconData;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
 int ?maxLength;


  MyStyledTextField({super.key,

   required  this.label,
    required this.hintText,
     this.suffixIconData,
     this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureText = false,

     this.maxLength
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,

            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              fontFamily: 'Monadi',
              color: AppColors.black,
            ),

        ),
        5.verticalSpace,
        Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), // Adjust the border radius as needed
            color: Colors.white, // Change to your desired background color
          ),
          child:
          TextFormField(
            maxLength: maxLength,
            buildCounter: (context, {required currentLength, required maxLength, required isFocused}) => null,
            maxLines: 1,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: validator,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              fontFamily: 'Monadi',
              color: AppColors.black,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14.sp,
                fontFamily: 'Monadi',
                color: AppColors.gray,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              border: InputBorder.none,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                fontFamily: 'Monadi',
                color: AppColors.black,
              ),
              suffixIcon: suffixIconData
            ),
            // إزالة عرض طول النص

          ),
        ),



      ],
    );
  }
}

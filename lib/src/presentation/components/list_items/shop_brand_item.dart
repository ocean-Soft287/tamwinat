import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class ShopBrandItem extends StatelessWidget {
  final String? title;
  final Function() onTap;
  final bool isSelected;
  final String? imageUrl;
  const ShopBrandItem({
    Key? key,
    this.title,
    required this.onTap,
    required this.isSelected,
    this.imageUrl = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(

            height:60.h,
            width: 70.w,
            alignment: Alignment.center,


            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(12.r),
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.orange : AppColors.onBoardingDot(),
                width: isSelected ? 2 : 1,
              ),
            ),
            child:

            CachedNetworkImage(
              // maxHeightDiskCache: 10,
              width: 50.r,
              height: 50.h,
              imageUrl: imageUrl ?? "",
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fadeInDuration: const Duration(seconds: 1),
               fit: BoxFit.cover,
              cacheKey: '${imageUrl ?? ""}?${DateTime.now().millisecondsSinceEpoch}',
            ),
          ),

          Text(
            '$title',

            style: GoogleFonts.rubik(
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w300,
              color: isSelected ? Colors.black : Colors.grey,


            ),

            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

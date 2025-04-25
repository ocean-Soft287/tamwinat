


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';





Widget buildStep(BuildContext context, String title, String subtitle, IconData icon, bool isActive,String image,bool divder)
{
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(icon, color: isActive ? Colors.green : Colors.grey),
          (divder) ?  Container(
            width: 2,
            height: 50,
            color: isActive ? Colors.green : Colors.grey,
          ):const SizedBox(),
        ],
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Row(
          children: [
            Image.asset(image, width: 60.w, height: 60.h),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Monadi',
                      color: isActive ? Colors.green : Colors.grey,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  Text(subtitle,style: TextStyle(

                    fontFamily: 'Monadi',
                    color: isActive ? Colors.black : Colors.grey,
                    fontWeight: isActive ? FontWeight.w400 : FontWeight.normal,
                  ),),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
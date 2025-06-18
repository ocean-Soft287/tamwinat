import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';


class UpdatePopup extends StatelessWidget {
  const UpdatePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.update,
                size: 60,
                color: Colors.amber,
              ),
              const SizedBox(height: 16),
              Text(
                'تحديث متاح' ,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'متاح نسخة جديدة من التطبيق. قم بالتحديث للاستمتاع بأحدث  العروض',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async  {
                  final Uri url = Uri.parse(
                    Platform.isAndroid ? "https://play.google.com/store/apps/details?id=com.tmwenat&hl=ar":
                      'https://apps.apple.com/in/app/تموينات/id6479165814');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تعذر فتح متجر التطبيقات')),
                    );
                  }
                },
                child: Text('تحديث الآن', style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
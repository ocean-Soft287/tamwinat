import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sundaymart/src/presentation/pages/main/home/on_system/controller/home_riverpod.dart';
import 'package:sundaymart/src/riverpod/gh.dart';

class OfferName extends StatelessWidget {
  
  const OfferName({
    super.key,
    required this.appModel,

    required this.getDataOferTwoFromApi, required this.indexOne,
  });

  final AppModel appModel;
  final int indexOne;
  final GetDataOverOneFromApi getDataOferTwoFromApi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        (appModel.activeLanguage.languageCode == 'ar')
            ? '${getDataOferTwoFromApi.overOneList[indexOne]["OfferName"]??''}'
            : '${getDataOferTwoFromApi.overOneList[indexOne]["OfferName"]??''}',
        style: GoogleFonts.tajawal(
          fontSize:
          16.sp,
          fontWeight:
          FontWeight.bold,
        ),
      ),
    );
  }
}
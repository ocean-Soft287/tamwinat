import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:sundaymart/src/presentation/pages/main/home/on_system/controller/home_riverpod.dart';
import 'package:sundaymart/src/presentation/theme/app_colors.dart';
import 'package:sundaymart/src/riverpod/gh.dart';

class NewListWidget extends ConsumerStatefulWidget {
  const NewListWidget({super.key});

  @override
  ConsumerState<NewListWidget> createState() => _NewListWidgetState();
}

class _NewListWidgetState extends ConsumerState<NewListWidget> {
  @override
  Widget build(BuildContext context) {
        final appModel = ref.watch(appModelProvider);

    return Consumer(builder: (context, ref, child) {
            final getDataNews = ref.watch(getDataNewsFromApiProvider);
            List<String> newsTextList = [];
            for (var item in getDataNews.newsList) {
              newsTextList.add(item['NewsText']);
            }

            for (var item in getDataNews.newsList) {
              newsTextList.add(item['NewsText']);
            }
            return (newsTextList.isEmpty)?const Text(' '):
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              height: 30.h,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Center(
                child: Marquee(
                  text: (newsTextList.isEmpty)
                      ? (appModel.activeLanguage.languageCode == 'ar')
                      ? '         '
                      : '           '
                      : (appModel.activeLanguage.languageCode == 'ar')
                      ? newsTextList.join('           ')
                      : newsTextList.join('           '),
                  style: GoogleFonts.tajawal(
                    fontSize: 13.sp, color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),


                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 100.0,
                  pauseAfterRound: const Duration(milliseconds: 500),
                  startPadding: 10.0,
                  accelerationDuration: const Duration(milliseconds: 500),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
            );
          });
  

  }
}
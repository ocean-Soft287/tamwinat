import 'package:auto_route/auto_route.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../riverpod/gh.dart';
import '../../../../components/app_bars/common_appbar.dart';
import '../../../../theme/app_colors.dart';
import '../on_system/controller/notification_riverpod.dart';


class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends ConsumerState<NotificationView> {
  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(appModelProvider);
    return Scaffold(
      backgroundColor: AppColors.white.withOpacity(0.9),
      appBar: CommonAppBar(
        title: (lang.activeLanguage.languageCode == 'ar')
            ? 'الاشعارات'
            : 'Notification',
        onLeadingPressed: () => context.popRoute(),
      ),
      body:  Consumer(
          builder: (context, ref, child) {
            final listNotification = ref.watch(getNotificationRiverpod);
            return
              ConditionalBuilder(
                  condition:listNotification.notificationList.isNotEmpty ,
                  builder: (context){
                    return  ListView.builder(
                        itemCount: listNotification.notificationList.length,

                        itemBuilder:(context,index)
                        {
                          return
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(

                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                height: 80.h,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (lang.activeLanguage.languageCode == 'ar')
                                          ? '${listNotification.notificationList[index]['Title']}'
                                          : '${listNotification.notificationList[index]['Title']}',
                                      style: GoogleFonts.tajawal(
                                        fontSize:
                                        12.sp,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),),
                                    5.verticalSpace,
                                    Expanded(
                                      child: Text(
                                        '${listNotification.notificationList[index]['MobileAppNotification']}',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                          fontWeight:
                                          FontWeight.bold,
                                          fontFamily: 'Monadi',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            );
                        }

                    );
                  },
                  fallback: (context){
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(color: Colors.orange,),
                          5.verticalSpace,
                          Text(
                            (lang.activeLanguage.languageCode == 'ar')
                                ? 'جارى التحميل انتظر..'
                                :  'Loading...',
                            style: GoogleFonts.tajawal(
                              fontSize:
                              12.sp,
                              fontWeight:
                              FontWeight.bold,
                            ),),
                        ],
                      ),
                    );
                  })
            ;

          }
      ),

    );
  }
}



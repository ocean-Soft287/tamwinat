
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sundaymart/src/core/constants/app_assets.dart';

import 'package:sundaymart/src/presentation/pages/main/drawer/MyPreviousRequests/view/widget/custom_step.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/MyPreviousRequests/view/widget/order_detalise_screen.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/MyPreviousRequests/view/widget/tab_bar_previous_order_view.dart';

import '../../../../../../riverpod/gh.dart';


import '../../../../pages.dart';
import '../manager/my_previous_request_state.dart';
import '../manager/my_previous_requets_riverpod.dart';


class MyPreviousRequetsScreen extends ConsumerStatefulWidget {
  @override
  _MyPreviousRequetsScreenState createState() => _MyPreviousRequetsScreenState();
}

class _MyPreviousRequetsScreenState extends ConsumerState<MyPreviousRequetsScreen> {
  @override
  bool isLoading = true;

  void initState() {

    super.initState();

    ref
        .read(getDataMyPreviousRequetsApiProvider.notifier)
        .getMyPreviousRequetsPhone();


    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  @override
  void dispose() {
    // Cancel the stream subscription

    super.dispose();
  }
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,

        appBar:PreferredSize(
        preferredSize: const Size.fromHeight(40),

          child:ClipRRect(
            child: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation)=>MainPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child)
                      =>SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    ),(route) =>true ,



                  );


                },
                icon: const Icon(Icons.arrow_forward_ios,color: Colors.black,size: 20,),
              ),
              elevation: 0.0,

              title:
              Text(
                (appModel.activeLanguage.languageCode == 'ar')?
                'متابعه الطلبات' :'My previous requests',

                style: const TextStyle(
                    color: Colors.black,
                  fontFamily: 'Monadi',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),

              ), centerTitle: true,



            ),
          ),
        ),
        body: OrdersTabBar(appModel: appModel)

      ),
    );
  }
}




import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sundaymart/src/core/routes/app_router.gr.dart';
import 'package:sundaymart/src/core/utils/shared_refrence.dart';
import 'package:sundaymart/src/presentation/pages/auth/login/one_system/CashHelper.dart';
import 'package:sundaymart/src/presentation/pages/main/Notification/notification_service.dart/notification.service.dart';
import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/DioOneSystem.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import 'firebase_options.dart';
import 'src/app_widget.dart';
//OceanMac@715
import 'src/core/utils/utils.dart';
import 'src/presentation/theme/theme.dart';
import 'src/core/di/dependency_manager.dart';
var UserPhone;
var UserPhoneAll;
var DeliveryValue;
final AppRouter routerPackage = AppRouter();
GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
var token;
Future<void> firebaseMessageBackgroundHandler(RemoteMessage message) async {
  print('BackgroundMessage');
  print(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationServices.init();
  setUpDependencies();
  DioHelperOneSystem.init();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  TabbySDK().setup(
    withApiKey: 'pk_test_0190c5f9-bbe2-1538-785c-c1b3a45f801b', // Put here your Api key, given by the Tabby integrations team
  );
     
  // token = await FirebaseMessaging.instance.getToken();
  //    debugPrint("+++++++++++");
  //   debugPrint(token);
  //    debugPrint("+++++++++++");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('onMessage2');
    print(message.notification!.title);
    print(message.notification!.body);
  }).onError((error) {
    print("Errorr1");// kkdad
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('onMessageOpenedApp');
    print(event.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessageBackgroundHandler);


  await LocalStorage.getInstance();
  await SharedPreferencesService().init();

  UserPhone = CacheHelper.getData(key: 'PhoneUser');

  // if (Platform.isAndroid) {
  //
  // }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  // }
  runApp(ProviderScope(


      child: AppWidget()));
}
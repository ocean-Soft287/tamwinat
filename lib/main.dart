import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:sundaymart/src/core/routes/app_router.gr.dart';
import 'package:sundaymart/src/core/utils/shared_refrence.dart';
import 'package:sundaymart/src/presentation/pages/auth/login/one_system/CashHelper.dart';
import 'package:sundaymart/src/presentation/pages/main/Notification/notification_service.dart/notification.service.dart';
import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/DioOneSystem.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import 'src/app_widget.dart';
import 'src/core/utils/utils.dart';
import 'src/presentation/theme/theme.dart';
import 'src/core/di/dependency_manager.dart';

var UserPhone;
var UserPhoneAll;
var DeliveryValue;
bool isGuestMode = false;
final AppRouter routerPackage = AppRouter();
GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
var token;

bool get isAuthenticatedUser {
  final phone = UserPhone?.toString().trim();
  return !isGuestMode && phone != null && phone.isNotEmpty;
}

@pragma('vm:entry-point')
Future<void> firebaseMessageBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint('📩 BackgroundMessage: ${message.notification?.title}');
  debugPrint(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  FirebaseMessaging.onBackgroundMessage(firebaseMessageBackgroundHandler);

  await NotificationServices.init();

  setUpDependencies();
  DioHelperOneSystem.init();
  await CacheHelper.init();

  TabbySDK().setup(
    withApiKey: 'pk_test_0190c5f9-bbe2-1538-785c-c1b3a45f801b',
  );

  await LocalStorage.getInstance();
  await SharedPreferencesService().init();

  final savedPhone = CacheHelper.getData(key: 'PhoneUser')?.toString().trim();
  final savedGuestMode = CacheHelper.getData(key: 'IsGuestMode');
  isGuestMode = savedGuestMode == true;

  if (isGuestMode) {
    UserPhone = null;
    UserPhoneAll = savedPhone;
  } else {
    UserPhone = (savedPhone == null || savedPhone.isEmpty) ? null : savedPhone;
    UserPhoneAll = UserPhone;
  }

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

  runApp(
    ProviderScope(
      child: AppWidget(),
    ),
  );
}
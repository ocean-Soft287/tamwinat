import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/DioOneSystem.dart';
import '../notification_model/notification_model.dart';

abstract class NotificationServices {
  static ReceivePort? receivePort;
  static final awesomeNotifications = AwesomeNotifications();
  static final _firebaseMessaging = FirebaseMessaging.instance;

  // ✅ init كامل مع Firebase + AwesomeNotifications
  static Future<void> init() async {
    // 1️⃣ تهيئة AwesomeNotifications
    await awesomeNotifications.initialize(
      null,
      [
        NotificationChannel(
          channelKey: "basic_channel",
          channelName: 'Offers',
          channelDescription: "Offers For Users",
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.Max,
          ledColor: Colors.white,
          channelShowBadge: true,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
          onlyAlertOnce: true,
        )
      ],
      debug: true,
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel',
          channelGroupName: 'Category tests',
        )
      ],
    );

    // 2️⃣ طلب إذن الإشعارات (iOS + Android 13+)
    await _requestPermissions();

    // 3️⃣ إعداد Firebase Messaging listeners
    await _setupFirebaseListeners();

    // 4️⃣ تسجيل Listeners لـ AwesomeNotifications
    await startListeningNotificationEvents();

    // 5️⃣ طباعة FCM Token
    await _printFCMToken();

    await FirebaseMessaging.instance.subscribeToTopic("all_users");
    debugPrint("✅ Subscribed to topic: all_users");
  }

  // ✅ طلب الأذونات
  static Future<void> _requestPermissions() async {
    // iOS Permission عبر Firebase
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('📋 iOS Permission Status: ${settings.authorizationStatus}');

    // Android Permission عبر AwesomeNotifications
    final isAllowed = await awesomeNotifications.isNotificationAllowed();
    if (!isAllowed) {
      await awesomeNotifications.requestPermissionToSendNotifications();
    }
  }

  // ✅ إعداد Firebase Messaging لاستقبال الإشعارات
  static Future<void> _setupFirebaseListeners() async {
    // الإشعار وصل والتطبيق مفتوح (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📩 Foreground Message: ${message.notification?.title}');
      _showFirebaseNotification(message);
    });

    // المستخدم ضغط على الإشعار والتطبيق كان في الخلفية
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('🔔 Notification Opened: ${message.data}');
      _handleNotificationTap(message.data);
    });

    // لو التطبيق اتفتح من terminated state بسبب إشعار
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('🚀 App opened from terminated via notification');
      _handleNotificationTap(initialMessage.data);
    }

    // تحديث Token لما يتغير
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      debugPrint('🔄 FCM Token Refreshed: $newToken');
      // هنا ترسل الـ Token الجديد للـ Backend بتاعك
    });
  }

  // ✅ عرض إشعار من Firebase كـ Local Notification عبر AwesomeNotifications
  static Future<void> _showFirebaseNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: message.hashCode,
        channelKey: 'basic_channel',
        title: notification.title ?? 'تموينات',
        body: notification.body ?? '',
        notificationLayout: NotificationLayout.Default,
        payload: Map<String, String>.from(
          message.data.map((k, v) => MapEntry(k, v.toString())),
        ),
      ),
    );
  }

  // ✅ التعامل مع الضغط على الإشعار
  static void _handleNotificationTap(Map<String, dynamic> data) {
    debugPrint('📌 Notification Data: $data');
    // هنا تتحكم في التنقل بناءً على data
    // مثال: if (data['screen'] == 'orders') { navigate to orders }
  }

  // ✅ طباعة FCM Token
  static Future<void> _printFCMToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      debugPrint('🔑 FCM Token: $token');
      // ابعت الـ token للـ Backend هنا
    } catch (e) {
      debugPrint('❌ Error getting FCM token: $e');
    }
  }

  // ✅ عرض إشعارات من الـ Backend (API)
  static Future<void> showNotification({
    required List<NotificationsModel> allNotifications,
  }) async {
    for (int i = 0; i < allNotifications.length; i++) {
      await awesomeNotifications.createNotification(
        content: NotificationContent(
          id: allNotifications[i].id,
          channelKey: 'basic_channel',
          title: 'تموينات',
          body: allNotifications[i].message,
          notificationLayout: NotificationLayout.Default,
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'buyNow',
            label: 'Buy Now',
            actionType: ActionType.Default,
          ),
          NotificationActionButton(
            key: 'addToCart',
            label: 'Add To Cart',
            actionType: ActionType.Default,
          ),
        ],
      );
    }
  }

  // ✅ تسجيل Listeners
  static Future<void> startListeningNotificationEvents() async {
    debugPrint("✅ Started listening to notification events");
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  // ✅ استقبال الـ Action
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      debugPrint(
          'Silent action: "${receivedAction.buttonKeyInput}"');
    } else {
      if (receivePort == null) {
        debugPrint('Called inside a parallel dart isolate.');
        SendPort? sendPort =
            IsolateNameServer.lookupPortByName('notification_action_port');

        if (sendPort != null) {
          debugPrint('Redirecting to main isolate.');
          sendPort.send(receivedAction);
          return;
        }
      }
      return onActionReceivedImplementationMethod(receivedAction);
    }
  }

  static Future<void> onActionReceivedImplementationMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.buttonKeyPressed == "buyNow") {
      // MyApp.navigatorKey.currentState?.push(
      //   MaterialPageRoute(builder: (context) => const CheckoutScreen()),
      // );
    } else if (receivedAction.buttonKeyPressed == "addToCart") {
      // MyApp.navigatorKey.currentState?.push(
      //   MaterialPageRoute(builder: (context) => const ProductScreen()),
      // );
    }
  }

  static Future<void> executeLongTaskInBackground() async {
    debugPrint("starting long task");
    await Future.delayed(const Duration(seconds: 4));
    const String url = "http://google.com";
    final re = await DioHelperOneSystem.getData(url: url);
    debugPrint(re.data.toString());
    debugPrint("long task done");
  }
}

// ─── Screens (unchanged) ──────────────────────────────────────────────────────

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Screen"),
        centerTitle: true,
      ),
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout Screen"),
        centerTitle: true,
      ),
    );
  }
}
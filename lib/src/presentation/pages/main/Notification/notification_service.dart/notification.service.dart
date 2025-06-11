import 'dart:async';

import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:flutter/material.dart';

import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/DioOneSystem.dart';

import '../notification_model/notification_model.dart';

abstract class NotificationServices {
  static ReceivePort? receivePort;
  static final awesomeNotifications = AwesomeNotifications();
  static Future<void> init() async {

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
          channelShowBadge: false,
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
  }

  static Future<void> showNotification({
    required List<NotificationsModel> allNotifications,
  }) async {
    int i = 0;
    while (i < allNotifications.length) {
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
      i++;
    }
    await startListeningNotificationEvents();
  }

static Future<void> startListeningNotificationEvents() async {
    debugPrint("check data with start listing");
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      // For background actions, you must hold the execution until the end
      debugPrint(
          'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      // await executeLongTaskInBackground();
    } else {
      // this process is only necessary when you need to redirect the user
      if (receivePort == null) {
        debugPrint(
            'onActionReceivedMethod was called inside a parallel dart isolate.');
        SendPort? sendPort =
            IsolateNameServer.lookupPortByName('notification_action_port');

        if (sendPort != null) {
          debugPrint('Redirecting the execution to main isolate process.');
          sendPort.send(receivedAction);
          return;
        }
      }
      debugPrint("check data with receivedAction 3${receivedAction.buttonKeyInput}");

      return onActionReceivedImplementationMethod(receivedAction);
    }
  }

  static Future<void> onActionReceivedImplementationMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.buttonKeyPressed == "buyNow") {
      // MyApp.navigatorKey.currentState?.push(
      //   MaterialPageRoute(
      //     // screen
      //     builder: (context) => const CheckoutScreen(),
      //   ),
      // );
    } else if (receivedAction.buttonKeyPressed == "addToCart") {
      // MyApp.navigatorKey.currentState?.push(
      //   MaterialPageRoute(
      //     // screen
      //     builder: (context) => const ProductScreen(),
      //   ),
      // );
    }
  }

  static Future<void> executeLongTaskInBackground() async {
    debugPrint("starting long task");
    await Future.delayed(const Duration(seconds: 4));
    String url = "http://google.com";
    final re = await DioHelperOneSystem.getData( url: url);
    debugPrint(re.data.toString());
    debugPrint("long task done");
  }


}

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

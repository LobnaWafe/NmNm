import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:simple_face/core/services/noti/local_notification_services.dart';
import 'package:simple_face/core/utilis/api/dio_consumer.dart';



class PushNotificationServices {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static String? fcmToken;

  static Future init() async {

    // طلب صلاحية الإشعارات
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  
  await Future.delayed(const Duration(seconds: 1));

   try {
    fcmToken = await messaging.getToken();
  } catch (e) {
    log("First attempt failed, retrying...");
    // محاولة ثانية بعد 3 ثواني لو فشلت الأولى
    await Future.delayed(const Duration(seconds: 3));
    fcmToken = await messaging.getToken();
  }

    log("FCM Token : ${fcmToken ?? "null"}");

    // إرسال التوكين للسيرفر
    if (fcmToken != null) {
      await sendToken(fcmToken!);
    }

      // 👇 لو Firebase غير التوكين
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    log("FCM Token Refreshed: $newToken");
    sendToken(newToken);
  });


    // استقبال الرسائل في الخلفية
    FirebaseMessaging.onBackgroundMessage(handelbackgroundMessage);

    // استقبال الرسائل في foreground
    handelforgroundMessage();
  }

  static void handelforgroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      log("Notification title : ${message.notification?.title}");
      log("Notification body : ${message.notification?.body}");

      // اظهار local notification
      LocalNotificationService.showBasicNotification(message);
    });
  }
}

Future<void> handelbackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  log("Background notification: ${message.notification?.title}");
}

Future<void> sendToken(String token) async {

  try {

    DioConsumer api = DioConsumer(dio: Dio());

    var response = await api.post(
      "api/Fcm/register",
      data: {
        "fcmToken": token,
        "deviceType": "android"
      },
    );
   
    log("sendToken response : $response");

  } catch (e) {

    log("Error sending token : ${e.toString()}");

  }

}


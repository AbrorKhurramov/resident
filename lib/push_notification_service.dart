import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/injection/params/notification_param.dart';
import 'package:resident/main.dart';

import 'core/util/app_color.dart';
import 'feature/presentation/app_route/app_route_name.dart';



class NotificationParams {
  final String screenType;
  final String id;

  NotificationParams({required this.screenType, required this.id});

  factory NotificationParams.fromJsonString(String str) => NotificationParams._fromJson(jsonDecode(str));
  factory NotificationParams._fromJson(Map<String, dynamic> json) => NotificationParams(
    screenType: json['type_screen'],
    id: json['param'],
  );
  String toJsonString() => jsonEncode(_toJson());
  Map<String, dynamic> _toJson() => {
    'type_screen': screenType,
    'param': id,
  };

}



class PushNotificationService {
  PushNotificationService._();

  factory PushNotificationService() => _instance;

  static final PushNotificationService _instance = PushNotificationService._();
   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true);

  Future<void> init() async {

    await _firebaseMessaging.requestPermission(
      announcement: true,
      provisional: false,
      sound: true,
      criticalAlert: true,
      carPlay: true,
      badge: true,
      alert: true,
    );

    _subscribeNotification();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );

    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true
    );


    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid,iOS: iosInitializationSettings);

      flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: onSelectNotification);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

print("REMOTE MESSAGE");
print(message.toString());
print("REMOTE MESSAGE DATA");
print(message.data.toString());
print("REMOTE MESSAGE NOTIFICATION");
print(message.notification!.body.toString());
print(message.notification!.bodyLocArgs.toString());
print(message.notification!.bodyLocKey.toString());
RemoteNotification? notification = message.notification;

      NotificationParams notificationParams = NotificationParams._fromJson(message.data);

      String screen =  notificationParams.toJsonString();
print("OFF");
      if (notification != null&&Platform.isAndroid) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
           notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  color: AppColor.c1000,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
                iOS: const DarwinNotificationDetails(),

            ),
          payload:screen,

        );
      }

    });
//background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      print("onMessageOpened");

      NotificationParams notificationParams = NotificationParams._fromJson(message.data);
      String screen =  notificationParams.toJsonString();

     // NotificationParams notificationParams1 = NotificationParams.fromJsonString(screen);

      String? currentPath;
      Navigator.of(navigatorKey.currentState!.context).popUntil((route) {
        currentPath = route.settings.name;
        return true;
      });

      if(notificationParams.screenType=="appeal"){

        if(currentPath==AppRouteName.appealHistoryScreen){
          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.appealHistoryScreen);

        }
        else {
          Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.appealHistoryScreen);
        }
      }
      if(notificationParams.screenType=="invoice"){
        if(currentPath==AppRouteName.invoiceScreen){
          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.invoiceScreen,arguments: notificationParams.id);

        }
        else {
          Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.invoiceScreen,arguments: notificationParams.id);
        }
      }
      if(notificationParams.screenType=="survey"){
        if(currentPath==AppRouteName.surveyScreen){
          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.surveyScreen);

        }
        else {
          Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.surveyScreen);
        }
      }
      if(notificationParams.screenType=="news"){
        if(currentPath==AppRouteName.dashboardScreen){
          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.dashboardScreen);

        }
        else {
          Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.dashboardScreen);
        }
      }
      if(notificationParams.screenType=="document"){
        if(currentPath==AppRouteName.documentScreen){
          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.documentScreen);

        }
        else {
          Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.documentScreen);
        }
      }
      if(notificationParams.screenType=="deposit"){
        if(currentPath==AppRouteName.paymentHistoryScreen){
          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.paymentHistoryScreen);

        }
        else {
          Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.paymentHistoryScreen);
        }
      }

    });

    checkBackgroundNotification();
        }

  Future<dynamic> onSelectNotification(payload) async{

    NotificationParams notificationParams = NotificationParams.fromJsonString(payload);
print("ON SELECT");
    String? currentPath;
    Navigator.of(navigatorKey.currentState!.context).popUntil((route) {
      currentPath = route.settings.name;
      return true;
    });

    if(notificationParams.screenType=="appeal"){

      if(currentPath==AppRouteName.appealHistoryScreen){
         Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.appealHistoryScreen);

      }
      else {
        Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.appealHistoryScreen);
      }
    }
    if(notificationParams.screenType=="invoice"){
      if(currentPath==AppRouteName.invoiceScreen){
        Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.invoiceScreen,arguments: notificationParams.id);

      }
      else {
        Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.invoiceScreen,arguments: notificationParams.id);
      }
     }
    if(notificationParams.screenType=="survey"){
      if(currentPath==AppRouteName.surveyScreen){
        Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.surveyScreen);

      }
      else {
        Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.surveyScreen);
      }
    }
    if(notificationParams.screenType=="news"){
      if(currentPath==AppRouteName.dashboardScreen){
        Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.dashboardScreen);

      }
      else {
        Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.dashboardScreen);
      }
    }
    if(notificationParams.screenType=="document"){
      print("YES");
      if(currentPath==AppRouteName.documentScreen){
        Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.documentScreen);
      }
      else {
        Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.documentScreen);
      }
    }
    if(notificationParams.screenType=="deposit"){
      if(currentPath==AppRouteName.paymentHistoryScreen){
        Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.paymentHistoryScreen);

      }
      else {
        Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.paymentHistoryScreen);
      }
    }
  }





  Future<void> checkBackgroundNotification() async{
    print("checkBackgroundNotification");
    RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null){
      print("TERMINATED Firebase");
      print(message.toString());
      print("TERMINATED Firebase MESSAGE DATA");
      print(message.data.toString());
      print("TERMINATED Firebase MESSAGE NOTIFICATION");
      NotificationParams notificationParams = NotificationParams._fromJson(message.data);
      //   String screen =  notificationParams.toJsonString();
      print(notificationParams.screenType.toString());

      // NotificationParams notificationParams1 = NotificationParams.fromJsonString(screen);

      String? currentPath;
      Navigator.of(navigatorKey.currentState!.context).popUntil((route) {
        currentPath = route.settings.name;
        return true;
      });

      if(notificationParams.screenType=="appeal"){



        if(currentPath==AppRouteName.appealHistoryScreen){
          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.appealHistoryScreen);

        }
        else {
          Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.appealHistoryScreen);
        }
      }
      if(notificationParams.screenType=="news"){
        if(currentPath==AppRouteName.dashboardScreen){
          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.dashboardScreen);

        }
        else {
          Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.dashboardScreen);
        }
      }
      if(notificationParams.screenType=="invoice"){
        if(currentPath==AppRouteName.invoiceScreen){
          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.invoiceScreen,arguments: notificationParams.id);

        }
        else {
          Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.invoiceScreen,arguments: notificationParams.id);
        }
      }
      if(notificationParams.screenType=="survey"){
        if(currentPath==AppRouteName.surveyScreen){
          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.surveyScreen);

        }
        else {
          Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.surveyScreen);
        }
      }
      if(notificationParams.screenType=="document"){
        if(currentPath==AppRouteName.documentScreen){
          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.documentScreen);

        }
        else {
          Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.documentScreen);
        }
      }
      if(notificationParams.screenType=="deposit"){
        if(currentPath==AppRouteName.paymentHistoryScreen){
          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, AppRouteName.paymentHistoryScreen);

        }
        else {
          Navigator.pushNamed(navigatorKey.currentState!.context, AppRouteName.paymentHistoryScreen);
        }
      }
    }
  }

  void _subscribeNotification() {
    bool notification = getIt<NotificationParam>().notification;

    if (notification) {
      print("SUBSCRIBE TOPiC");
     _firebaseMessaging.subscribeToTopic('news');
    } else {
      print("UNSUBSCRIBE TOPiC");
     _firebaseMessaging.unsubscribeFromTopic('news');
    }
  }


}

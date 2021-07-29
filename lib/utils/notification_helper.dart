import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/db_provider.dart';
import 'package:restaurant_app/data/remote/model/restaurants_response.dart';
import 'package:restaurant_app/screen/details_screen.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('dish');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          if (payload != null) {
            print('notification payload: ' + payload);
          }
          selectNotificationSubject.add(payload ?? 'empty payload');
        });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantsResponse restaurant) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "restaurant news channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Restaurant Now</b>";
    var titleNews = restaurant.restaurants[0].name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(restaurant.toJson()));
  }

  void configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen(
          (String payload) async {
        var data = RestaurantsResponse.fromJson(json.decode(payload));
        var restaurants = data.restaurants[0];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChangeNotifierProvider<DbProvider>(
              create: (_) => DbProvider(),
              child: DetailScreen(
                idRestaurants: restaurants.id,
              ),
            );
          }),
        );
      },
    );
  }
}
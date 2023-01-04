import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationServices{

  void initialiseNotifications(Color color)async{
    AwesomeNotifications().initialize(
      //'resource://drawable/res_app_icon',
        null,
        [
          NotificationChannel
            (
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: color,
            ledColor: Colors.white,
            enableLights: true,
            enableVibration: true,
          ),
        ],
        channelGroups: [
          NotificationChannelGroup
            (
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group',
          )
        ],
        debug: true
    );
  }

  void initialiseRemindNotifications(Color color)async{
    AwesomeNotifications().initialize(
      //'resource://drawable/res_app_icon',
        null,
        [
          NotificationChannel
            (
            channelGroupKey: 'remind_channel_group',
            channelKey: 'remind_channel',
            channelName: 'Remind notifications',
            channelDescription: 'Notification channel for remind time',
            defaultColor: color,
            ledColor: Colors.white,
            enableLights: true,
            enableVibration: true,
          ),
        ],
        channelGroups: [
          NotificationChannelGroup
            (
            channelGroupKey: 'remind_channel_group',
            channelGroupName: 'Remind group',
          )
        ],
        debug: true
    );
  }

  Future<void> NotifyRemindTime(
      {required String title ,
        required String body ,
        required int year ,
        required int month ,
        required int day ,required int hour,
        required int minute,})async
  {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: 'remind_channel',
        title: title,
        body: body,
      ),
      schedule: NotificationCalendar(year: year,month: month,day: day,hour: hour,minute: minute),
    );

  }

  Future<void> Notify(
      {required String title ,
        required String body ,
        required int year ,
        required int month ,
        required int day ,required int hour,
        required int minute,})async
  {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
      schedule: NotificationCalendar(year: year,month: month,day: day,hour: hour,minute: minute),
    );

  }

}

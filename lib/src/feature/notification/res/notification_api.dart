import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationApi {
  // static  String? timein;

  static final _notification = FlutterLocalNotificationsPlugin();
  static Future _notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            'channel id', 'channel name', 'channel description',
            importance: Importance.max),
        iOS: IOSNotificationDetails());
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/launcher_icon');
    final ios = IOSInitializationSettings();
    final setting = InitializationSettings(android: android, iOS: ios);
    print(setting);
    await _notification.initialize(setting,
        onSelectNotification: (payload) async {});
    if (initScheduled) {
      tz.initializeTimeZones();
      final localName = await FlutterNativeTimezone.getLocalTimezone();
      print(localName);

      tz.setLocalLocation(tz.getLocation(localName));
    }
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notification.show(id, title, body, await _notificationDetails(),
        payload: payload);
  }

  // schedule notification
  static Future showScheduleNotificationTimeIn({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    int? timeInH,
    int? timeInM,
    // required DateTime scheduleDate,
  }) async {
    
    _notification.zonedSchedule(
        id,
        title,
        body,
        // _scheduleDaily(Time(4, 35)),
        _scheduleWeekly(Time(timeInH!, timeInM!), days: [
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
          DateTime.friday,
          DateTime.sunday,
        ]),
        //  tz.TZDateTime.from(scheduleDate, tz.local),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        // matchDateTimeComponents: DateTimeComponents.time
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }
  static Future showScheduleNotificationTimeOut({
    int id = 0,
    String? title,
    String? body,
    String? payload,
     int? timeOutH,
    int? timeOutM,
    // required DateTime scheduleDate,
  }) async {
    
    _notification.zonedSchedule(
        id,
        title,
        body,
        // _scheduleDaily(Time(4, 35)),
        _scheduleWeekly(Time(timeOutH!, timeOutM!), days: [
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
          DateTime.friday,
          DateTime.sunday,
        ]),
        //  tz.TZDateTime.from(scheduleDate, tz.local),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        // matchDateTimeComponents: DateTimeComponents.time
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    print(now);
    final scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    print("date $scheduleDate");
    // return scheduleDate;
    // if today already , add one day for tomorrow
    return scheduleDate.isBefore(now)
        ? scheduleDate.add(Duration(days: 1))
        : scheduleDate;
  }

  static tz.TZDateTime _scheduleWeekly(Time time, {required List<int> days}) {
    print(_scheduleDaily(time));
    tz.TZDateTime scheduleDate = _scheduleDaily(time);
    print("time $time");
    print("date $scheduleDate");
    while (!days.contains(scheduleDate.weekday)) {
      scheduleDate = scheduleDate.add(Duration(days: 1));
      print(scheduleDate);
    }

    return scheduleDate;
  }
}

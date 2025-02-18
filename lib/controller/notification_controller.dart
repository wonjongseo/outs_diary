import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    tz.initializeTimeZones(); // 타임존 초기화

    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitSettings =
        DarwinInitializationSettings();

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> scheduleWeeklyNotification(
      int id, int day, int hour, int minute) async {
    final tz.TZDateTime scheduledDate =
        _nextInstanceOfWeekday(day, hour, minute);

    print("📢 알람 등록: 요일=$day, 시간=${hour}:${minute}, 실제 예약 시간=$scheduledDate");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id, // 고유 ID (요일 * 100 + 시간 * 10 + 분)
      '💊 약 복용 알림',
      '지정된 시간에 약을 복용하세요!',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'weekly_notification_channel',
          'Weekly Notifications',
          channelDescription: '매주 특정 요일 및 시간에 알림을 받습니다',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  tz.TZDateTime _setDate(DateTime date) {
    Duration offSet = DateTime.now().timeZoneOffset;
    DateTime local = date.add(-offSet);

    return tz.TZDateTime(tz.local, local.year, local.month, local.day,
        local.hour, local.minute, local.second);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    print("🚫 모든 알람 취소 완료");
  }

  Future<void> cancellNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    print("🚫 $id 알람 취소 완료");
  }

  tz.TZDateTime _nextInstanceOfWeekday(int weekday, int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    // tz.TZDateTime scheduledDate =
    //     tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    var scheduledDate =
        _setDate(DateTime(now.year, now.month, now.day, hour, minute));

    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    return scheduledDate;
  }
}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// 생성자에서 초기화
  NotificationService() {
    _initializeNotifications();
  }

  /// 📌 알람 초기화 (앱 실행 시)
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await flutterLocalNotificationsPlugin.initialize(settings);
  }

  /// 📌 매주 특정 요일/시간에 반복되는 알람 설정
  Future<void> scheduleWeeklyNotification({
    required int id,
    required String title,
    required String message,
    required String channelDescription,
    required int weekday,
    required int hour,
    required int minute,
  }) async {
    final scheduledDate = _nextInstanceOfWeekday(weekday, hour, minute);

    print("📢 주간 알람 등록: ${scheduledDate.toString()}");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'weekly_notification_channel',
          'Weekly Notifications',
          channelDescription: channelDescription,
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

  /// 📌 특정 날짜에 한 번만 울리는 알람 설정
  Future<void> scheduleSpecificDateNotification({
    required int id,
    required String title,
    required String message,
    required String channelDescription,
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
  }) async {
    final scheduledDate = _setDate(DateTime(year, month, day, hour, minute));

    print("📢 특정 날짜 알람 등록: ${scheduledDate.toString()}");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      message,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'specific_date_notification_channel',
          'Specific Date Notifications',
          channelDescription: channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  /// 📌 매주 특정 요일과 시간의 다음 인스턴스를 계산
  tz.TZDateTime _nextInstanceOfWeekday(int weekday, int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
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

  /// 📌 특정 날짜를 타임존이 적용된 형태로 변환
  tz.TZDateTime _setDate(DateTime date) {
    return tz.TZDateTime(
        tz.local, date.year, date.month, date.day, date.hour, date.minute);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    print("🚫 모든 알람 취소 완료");
  }

  Future<void> cancellNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    print("🚫 $id 알람 취소 완료");
  }
}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// 생성자에서 초기화
  NotificationService() {
    _initializeNotifications();
  }

  /// 📌 알람 초기화
  Future<void> _initializeNotifications() async {
    print('_initializeNotifications }');

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await flutterLocalNotificationsPlugin.initialize(settings);
  }

  /// 📌 매주 특정 요일/시간에 반복되는 알람 설정
  Future<tz.TZDateTime?> scheduleWeeklyNotification({
    required int id,
    required String title,
    required String message,
    String? channelDescription,
    required int weekday,
    required int hour,
    required int minute,
  }) async {
    final scheduledDate = _nextInstanceOfWeekday(weekday, hour, minute);

    if (scheduledDate == null) {
      print("⚠️ 유효하지 않은 날짜입니다. 알람을 설정하지 않습니다.");
      return null;
    }

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
          channelDescription:
              channelDescription ?? AppString.pillcCannelDescription.tr,
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

    return scheduledDate;
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

    if (scheduledDate == null) {
      print("⚠️ 유효하지 않은 날짜입니다. 알람을 설정하지 않습니다.");
      return;
    }

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
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  /// 📌 매주 특정 요일과 시간의 다음 인스턴스를 안전하게 계산
  tz.TZDateTime? _nextInstanceOfWeekday(int weekday, int hour, int minute) {
    try {
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime scheduledDate =
          _setDate(DateTime(now.year, now.month, now.day, hour, minute))!;

      while (scheduledDate.weekday != weekday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
        print('scheduledDate : ${scheduledDate}');
      }

      return scheduledDate;

      /**
           int daysUntilNext = (weekday - scheduledDate.weekday) % 7;
    if (daysUntilNext <= 0) {
      daysUntilNext += 7; // 항상 미래의 날짜를 찾도록 보정
    }
    
    scheduledDate = scheduledDate.add(Duration(days: daysUntilNext));

    print('✅ Next scheduledDate: $scheduledDate');
    return scheduledDate;
       */
    } catch (e) {
      print("🚨 _nextInstanceOfWeekday 오류: $e");
      return null;
    }
  }

  /// 📌 특정 날짜를 타임존이 적용된 형태로 변환 (범위 체크 포함)
  tz.TZDateTime? _setDate(DateTime date) {
    try {
      final tz.TZDateTime scheduledDate = tz.TZDateTime(
          tz.local, date.year, date.month, date.day, date.hour, date.minute);

      // ✅ 유효한 범위인지 확인
      if (scheduledDate.millisecondsSinceEpoch < -8640000000000000 || // 최소값 체크
          scheduledDate.millisecondsSinceEpoch > 8640000000000000) // 최대값 체크
      {
        throw RangeError("🚨 잘못된 날짜 범위: $scheduledDate");
      }

      return scheduledDate;
    } catch (e) {
      print("🚨 _setDate 오류: $e");
      return null;
    }
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    print("🚫 모든 알람 취소 완료");
  }

  Future<void> cancellNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    print("🚫 $id 알람 취소 완료");
  }

  //
}

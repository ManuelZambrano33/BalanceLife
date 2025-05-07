import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Inicializa las notificaciones
  static Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher'); 

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


  static Future<void> scheduleNapNotification(DateTime napTime) async {
    final now = DateTime.now();
    final napDuration = napTime.difference(now);
    if (napDuration.isNegative) {
      print("La hora de la siesta ya pasó.");
      return;
    }

   await _flutterLocalNotificationsPlugin.zonedSchedule(
  0,
  'Hora de despertar 😴',
  'Tu siesta ha terminado, ¡es hora de levantarse!',
  tz.TZDateTime.from(napTime, tz.local),
  const NotificationDetails(
    android: AndroidNotificationDetails(
      'nap_channel_id',
      'Alarmas de siesta',
      channelDescription: 'Canal para alarmas cortas de siesta',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    ),
  ),
  androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // ✅ NUEVO
  uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
  matchDateTimeComponents: DateTimeComponents.time,
);

  }
}

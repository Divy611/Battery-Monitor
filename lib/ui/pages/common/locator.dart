import 'package:get_it/get_it.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:batterymonitor/navigator/shared_prefrence_helper.dart';
import 'package:batterymonitor/widgets/push_notification_service.dart';

final getIt = GetIt.instance;
void setupDependencies() {
  getIt.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper());
  getIt.registerSingleton<PushNotificationService>(
    PushNotificationService(FirebaseMessaging.instance),
  );
}

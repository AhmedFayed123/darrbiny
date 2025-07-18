// // services/push_notification_service.dart
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class PushNotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   Future<void> initialize() async {
//     // For iOS
//     await _firebaseMessaging.requestPermission();
//
//     // For getting the device token
//     String? token = await _firebaseMessaging.getToken();
//     print('Device Token: $token');
//   }
//
//   Future<void> subscribeToTopic(String topic) async {
//     await _firebaseMessaging.subscribeToTopic(topic);
//   }
//
//   Future<void> unsubscribeFromTopic(String topic) async {
//     await _firebaseMessaging.unsubscribeFromTopic(topic);
//   }
//
//   void onMessageReceived(Function(RemoteMessage) onMessage) {
//     FirebaseMessaging.onMessage.listen(onMessage);
//   }
// }

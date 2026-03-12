import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:skillsync/services/notification_service.dart';

class NotificationsProvider extends ChangeNotifier {
  AuthorizationStatus _status = AuthorizationStatus.notDetermined;

  AuthorizationStatus get status => _status;

  bool get isEnabled => _status == AuthorizationStatus.authorized || _status == AuthorizationStatus.provisional;

  Future<void> loadStatus() async {
    final s = await NotificationService().getPermissionStatus();
    _status = s;
    notifyListeners();
  }

  Future<void> requestPermission() async {
    final s = await NotificationService().requestPermission();
    _status = s;
    notifyListeners();
  }
}

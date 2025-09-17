// define an abstract class or interface Notifier with the send method
abstract class NotificationService {
  void send(String message);
}

class LocalNotificationService implements NotificationService {
  @override
  void send(String message) {
    print('Sending local notification: $message');
  }
}

class AppNotifier {
// allowing the class to depend on abstractions for greater flexibility and decoupling in the design
  final NotificationService service;

  AppNotifier(this.service);

  void notifyUser(String message) {
    service.send(message);
  }
}

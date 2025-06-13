import 'MyNotificationListener.dart';

class MyNotification {
  final List<MyNotificationListener> notificationListener = [];

  void subscribeListener(MyNotificationListener newListener) {
    notificationListener.add(newListener);
  }

  void removeSubscribe(MyNotificationListener newListener) {
    notificationListener.remove(newListener);
  }

  void publish(String tag, dynamic data) {
    var index = notificationListener.indexWhere((element) {
      return element.tag() == tag;
    });
    if (index != -1) {
      notificationListener[index].onReceiveData(data);
    }
  }
}

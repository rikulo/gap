import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/notification.dart';

void createNotification() {
  notification.alert('MESSAGE', 'Alert', 'OK').then((_) {
    print("-------->1");
    print('success!\n');
  });
  
  notification.confirm('MESSAGE', 'Game Over', 'Restart,Exit').then((index) {
    print("-------->2");
    print('You selected button ' + index + '\n');
  });
  
  notification.beep(3);
  
  notification.vibrate(2000);
}

void main() {
  enableDeviceAccess().then((dev) {
    if (dev == null) {
      print("Time out! Fail to enable device.");
    } else {
      createNotification();
    }
  });
}
import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/notification.dart';

import 'dart:js' as js;

void accessNotification() {
  notification.alert('MESSAGE', 'Alert', 'OK')
  .then((_) {
    js.context.callMethod('alert',['-------->1\nsuccess!']);
    
    return notification.confirm('MESSAGE', 'Game Over', ['Restart', 'Exit']);
  }).then((index) {
    js.context.callMethod('alert',['-------->2\n' 
                                   + 'You selected button ' 
                                   + index]);
    
    return notification.prompt('MESSAGE', 'Name', ['OK', 'Cancel'], 'your name');
  }).then((results) {
    js.context.callMethod('alert',['-------->2\n' 
                                   + 'You selected button ' 
                                   + results.buttonIndex 
                                   + ' and the input is ' 
                                   + results.input1]);
    
    notification.beep(3);
    
    notification.vibrate(2000);
  })
  .catchError((e) => js.context.callMethod('alert',['Failed!']));
}

void main() {
  Device.init()
  .then((_) {
    accessNotification();
  })
  .catchError((ex, st) => print(ex+ '\n' + st));
}
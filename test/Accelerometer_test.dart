import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/accelerometer.dart';

import 'dart:async';
import 'dart:js' as js;

void accessAccelerometer() {
  var id;
  accelerometer.getCurrentAcceleration()
  .then((Acceleration acc) {
    js.context.callMethod('alert',['-------->1\n'
                                   + '$acc\n'
                                   + 'x:${acc.x}\n'
                                   + 'y:${acc.y}\n'
                                   + 'z:${acc.z}\n'
                                   + 't:${acc.timestamp}']);
   return accelerometer.getCurrentAcceleration();
  })
  .then((Acceleration acc) {
    js.context.callMethod('alert',['-------->2\n'
                                   + '$acc\n'
                                   + 'x:${acc.x}\n'
                                   + 'y:${acc.y}\n'
                                   + 'z:${acc.z}\n'
                                   + 't:${acc.timestamp}']);

    id = accelerometer.watchAcceleration(
      (Acceleration acc) {
        js.context.callMethod('alert',['-------->watch\n'
                                       +'x:${acc.x}\n'
                                       +'y:${acc.y}\n'
                                       +'z:${acc.z}\n'
                                       +'t:${acc.timestamp}']);
      },
      () => js.context.callMethod('alert', ['Failed!']));

    new Timer(new Duration(seconds: 5), () => accelerometer.clearWatch(id));
  })
  .catchError((e) => js.context.callMethod('alert',['Failed!']));
}

void main() {
  Device.init()
  .then((Device device) {
    accessAccelerometer();
  })
  .catchError((ex, st) => print(ex+ '\n' + st));
}
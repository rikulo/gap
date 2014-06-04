//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Oct 9, 2012  06:03:22 PM
// Author: henrichen

import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/accelerometer.dart';

import 'dart:async';
import 'dart:html';
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
      () => print("Fail!"));

    new Timer(new Duration(seconds: 5), () => accelerometer.clearWatch(id));
  })
  .catchError((_) => js.context.callMethod('alert',['Failed!']));
}

void main() {
  Device.init()
  .then((_) {
    accessAccelerometer();
  });
}

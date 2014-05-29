//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Oct 9, 2012  06:03:22 PM
// Author: henrichen

import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/accelerometer.dart';

import 'dart:js' as js;

void accessAccelerometer() {
  accelerometer.getCurrentAcceleration()
  .then((Acceleration acc) {
    js.context.callMethod('alert',['-------->1\n'
                                   + '$acc\n'
                                   + 'x:${acc.x}\n'
                                   + 'y:${acc.y}\n'
                                   + 'z:${acc.z}\n'
                                   + 't:${acc.timestamp}']);
//      print("-------->1");
//      print(acc);
//      print("x:${acc.x}");
//      print("y:${acc.y}");
//      print("z:${acc.z}");
//      print("t:${acc.timestamp}");
    })
    .catchError((_) => js.context.callMethod('alert',['Failed!\n']));
  //  
//  
//  accelerometer.getCurrentAcceleration()
//  .then((Acceleration acc) {
//      print("-------->2");
//      print("x:${acc.x}");
//      print("y:${acc.y}");
//      print("z:${acc.z}");
//      print("t:${acc.timestamp}");
//    })
//    .catchError((_) => print("Fail!"));
//
  var id = accelerometer.watchAcceleration(
    (Acceleration acc) {
      print("-------->watch");
      print("x:${acc.x}");
      print("y:${acc.y}");
      print("z:${acc.z}");
      print("t:${acc.timestamp}");
    },
    () => print("Fail!"));
//  
//  accelerometer.clearWatch(id);
}

void main() {
//  enableDevice().then((_) {
//      accessAccelerometer();
//  });
  enableDeviceAccess().then((dev) {
    if (dev == null) {
      print("Time out! Fail to enable device.");
    } else {
      accessAccelerometer();
    }
  });
}

//Future enableDevice() {
//  final c = new Completer();
//  var onDeviceReady = (_) => c.complete();
//  document.addEventListener('deviceready', onDeviceReady, false);
//  return c.future;
//}

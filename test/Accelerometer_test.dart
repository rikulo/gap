//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Oct 9, 2012  06:03:22 PM
// Author: henrichen
import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/accelerometer.dart';

void accessAccelerometer() {
  accelerometer.getCurrentAcceleration(
      (Acceleration acc) {
        print("-------->1");
        print(acc);
        print("x:${acc.x}");
        print("y:${acc.y}");
        print("z:${acc.z}");
        print("t:${acc.timestamp}");
      },
      () => print("Fail!")
  );
  accelerometer.getCurrentAcceleration(
      (Acceleration acc) {
        print("-------->2");
        print("x:${acc.x}");
        print("y:${acc.y}");
        print("z:${acc.z}");
        print("t:${acc.timestamp}");
      },
      () => print("Fail!")
  );
  var id = accelerometer.watchAcceleration(
      (Acceleration acc) {
        print("-------->watch");
        print("x:${acc.x}");
        print("y:${acc.y}");
        print("z:${acc.z}");
        print("t:${acc.timestamp}");
      },
      () => print("Fail!"));
//  accelerometer.clearWatch(id);
}

void main() {
  enableDeviceAccess().then((dev) {
    if (dev == null) {
      print("Time out! Fail to enable device.");
    } else {
      accessAccelerometer();
    }
  });
}

//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Thu, May 3, 2012  11:22:40 AM
// Author: henrichen, tomyeh

part of rikulo_accelerometer;

/** The acecleration information. When a device lying flat on a table and
 * facing up, the value is x = 0, y = 0, and z = 9.81 (one gravity in
 * meter/sec^2)
 */
class Acceleration {
  final num x;
  final num y;
  final num z;
  final int timestamp;

  Acceleration.fromProxy(js.Proxy p)
      : this.x = p.x,
        this.y = p.y,
        this.z = p.z,
        this.timestamp = p.timestamp;

  String toString() => "($timestamp: $x, $y, $z)";
}

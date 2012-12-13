//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Thu, May 3, 2012  11:22:40 AM
// Author: henrichen

part of rikulo_accelerometer;

/** Options used with [Accelerometer.watchAcceleration] */
class AccelerometerOptions {
  /** interval in milliseconds to retrieve Accleration back; default to 10000 */
  final int frequency;

  AccelerometerOptions({int frequency : 10000})
      : this.frequency = frequency;

  Map _toMap() => {'frequency' : this.frequency};
}

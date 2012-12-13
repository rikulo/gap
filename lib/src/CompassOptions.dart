//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, May 11, 2012  10:21:52 AM
// Author: henrichen

part of rikulo_compass;

/** Options used with [Compass.watchHeading] method. */
class CompassOptions {
  /** interval in milliseconds to retrieve CompassHeading back; Default: 100 */
  final int frequency;
  /** changes in degrees required to initiate a success callback. */
  final double filter;

  CompassOptions({int frequency : 100, double filter})
      : this.frequency = frequency,
        this.filter = filter;

  String toString() => "($frequency, $filter)";

  Map _toMap() => {'frequency' : this.frequency, 'filter' : this.filter};
}

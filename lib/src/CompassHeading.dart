//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, May 11, 2012  10:11:22 AM
// Author: henrichen

part of rikulo_compass;

/** The Compass heading information */
class CompassHeading {
  /** 0 ~ 359.99 degree at a single moment of time */
  final double magneticHeading;
  /** Heading relative to geographic north pole */
  final double trueHeading;
  /** Deviation in degrees between reported heading and true heading */
  final double headingAccuracy;
  /** the time in milliseconds the heading was determined */
  final int timestamp;

  CompassHeading.fromProxy(js.Proxy p)
      : this.magneticHeading = p.magneticHeading,
        this.trueHeading= p.trueHeading,
        this.headingAccuracy = p.headingAccuracy,
        this.timestamp = p.timestamp;

  String toString()
  => "($timestamp: $magneticHeading, $trueHeading, $headingAccuracy)";
}

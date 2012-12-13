//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, May 18, 2012  09:18:11 AM
// Author: henrichen

part of rikulo_geolocation;

/** The Geolocation position */
class Position {
  final Coordinates coords;
  final int timestamp;

  Position.fromProxy(js.Proxy p)
      : this.coords = new Coordinates.fromProxy(p.coords),
        this.timestamp = p.timestamp;

  String toString() => "($timestamp: $coords)";
}

class Coordinates {
  /** Latitude in decimal degrees. */
  double latitude;
  /** Longitude in decimal degrees. */
  double longitude;
  /** Height of the position in meters above the ellipsoid. */
  double altitude;
  /** Accuracy level of the latitude and longitude in meters. */
  double accuracy;
  /** Accuracy level of altitude in meters. */
  double altitudeAccuracy;
  /** Direction of travel in degrees to true north (north is 0 degree, east is 90 degree, south is 180 degree, west is 270 degree) */
  double heading;
  /** Ground speed in meters per second */
  double speed;

  Coordinates.fromProxy(js.Proxy p)
      : this.latitude = p.latitude,
        this.longitude = p.longitude,
        this.altitude = p.altitude,
        this.accuracy = p.accuracy,
        this.altitudeAccuracy = p.altitudeAccuracy,
        this.heading = p.heading,
        this.speed = p.speed;
}

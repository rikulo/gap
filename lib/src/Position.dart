//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Thu, May 29, 2014  11:47:38 AM
// Author: urchinwang

part of rikulo_geolocation;

/** The Geolocation position */
class Position {
  final Coordinates coords;
  final int timestamp;

  Position.getPosition(js.JsObject p)
      : this.coords = new Coordinates.getCoords(p['coords']),
        this.timestamp = p['timestamp'];

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

  Coordinates.getCoords(js.JsObject p)
      : this.latitude = p['latitude'],
        this.longitude = p['longitude'],
        this.altitude = p['altitude'],
        this.accuracy = p['accuracy'],
        this.altitudeAccuracy = p['altitudeAccuracy'],
        this.heading = p['heading'],
        this.speed = p['speed'];
}

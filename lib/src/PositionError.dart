//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Thu, May 29, 2014  11:47:59 AM
// Author: urchinwang

part of rikulo_geolocation;

/** Error returned when trying to get [Geolocation] position */
class PositionError {
  static const int PERMISSION_DENIED = 1;
  static const int POSITION_UNAVAILABLE = 2;
  static const int TIMEOUT = 3;

  final int code;
  final String message;

  PositionError.getPositionError(js.JsObject p)
      : this.code = p['code'],
        this.message = p['message'];
}

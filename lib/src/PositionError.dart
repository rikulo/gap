//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Oct 15, 2012  05:04:26 PM
// Author: henrichen

part of rikulo_geolocation;

/** Error returned when trying to get [Geolocation] position */
class PositionError {
  static const int PERMISSION_DENIED = 1;
  static const int POSITION_UNAVAILABLE = 2;
  static const int TIMEOUT = 3;

  final int code;
  final String message;

  PositionError.fromProxy(js.Proxy p)
      : this.code = p.code,
        this.message = p.message;
}

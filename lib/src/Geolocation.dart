//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Apr 27, 2012  10:26:33 AM
// Author: henrichen, tomyeh

part of rikulo_geolocation;

/** onSuccess callback function that returns the Position information */
typedef GeolocationSuccessCB(Position pos);
/** onError callback function if fail getting the Positioninformation */
typedef GeolocationErrorCB(PositionError error);

/** Singleton Geolocation. */
Geolocation geolocation = new Geolocation._internal();

/**
 * Capture device motion in x, y, and z direction.
 */
class Geolocation {
  js.Proxy _geolocation;

  factory Geolocation() => geolocation;

  Geolocation._internal() {
    if (device == null)
      throw new RuntimeError('device is not ready yet.');
    js.scoped(() {
      _geolocation = js.context.navigator.geolocation;
      js.retain(_geolocation);
    });
  }

  /**
   * Returns the current Position of this device.
   * The Position is returned via the success callback function.
   */
  void getCurrentPosition(GeolocationSuccessCB success,
                    [GeolocationErrorCB error, GeolocationOptions options]) {
    js.scoped(() {
      var s0 = (p) => success(new Position.fromProxy(p));
      var e0 = (p) => error(new PositionError.fromProxy(p));
      List jsfns = JsUtil.newCallbackOnceGroup("geo", [s0, e0], [1, 1]);
      var ok = jsfns[0];
      var fail = jsfns[1];
      _geolocation.getCurrentPosition(ok, fail);
    });
  }

  /**
   * Register functions to get the Position information in a regular
   * interval. This method returns an associated watchID which you can use to
   * clear this watch via [clearWatch] method.
   *
   * + [success] - success callback function.
   * + [error] - error callback function.
   * + [options] - optional parameter.
   */
  watchPosition(GeolocationSuccessCB success,
                    [GeolocationErrorCB error, GeolocationOptions options]) {
    return js.scoped(() {
      var s0 = (p) => success(new Position.fromProxy(p));
      var e0 = error == null ?
          null : (p) => error(new PositionError.fromProxy(p));
      var ok = new js.Callback.many(s0);
      var fail = e0 == null ? null : new js.Callback.many(e0);
      var opts = options == null ? null : js.map(options._toMap());
      var id = "geo_${geolocation.watchPosition(ok, fail, opts)}";
      JsUtil.addCallbacks(id, [ok, fail]);
      return id;
    });
  }

  /**
   * Stop watching the Position that was associated with the specified
   * watchID.
   *
   * + [watchID] - the watch ID got from [watchPosition] method.
   */
  void clearWatch(var watchID) {
    js.scoped(() {
      _geolocation.clearWatch(watchID.substring(4));
      JsUtil.delCallbacks(watchID);
    });
  }
}

//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Apr 27, 2012  10:26:33 AM
// Author: henrichen, tomyeh

part of rikulo_compass;

/** onSuccess callback function that returns the heading information */
typedef CompassSuccessCB(CompassHeading heading);
/** onError callback function if fail getting the heading information */
typedef CompassErrorCB(CompassError error);

/** Singleton Compass. */
Compass compass = new Compass._internal();

/**
 * Obtains the direction the device is pointing.
 */
class Compass {
  js.Proxy _compass;

  factory Compass() => compass;

  Compass._internal() {
    if (device == null)
      throw new RuntimeError('device is not ready yet.');
    js.scoped(() {
      _compass = js.context.navigator.compass;
      js.retain(_compass);
    });
  }

  /**
   * Returns the current compass heading; the compass heading is returned via
   * the [success] callback.
   * Returns the error code if fail to obtain the compass heading; the error
   * code is returned via the [error] callback.
   */
  void getCurrentHeading(CompassSuccessCB success, CompassErrorCB error) {
    js.scoped(() {
      var s0 = (p) => success(new CompassHeading.fromProxy(p));
      var e0 = (p) => error(new CompassError.fromProxy(p));
      List jsfns = JsUtil.newCallbackOnceGroup("cmp", [s0, e0], [1, 1]);
      var ok = jsfns[0];
      var fail = jsfns[1];
      js.context.navigator.compass.getCurrentHeading(ok, fail);
    });
  }

  /**
   * Register functions to get the compass heading information in a regular
   * interval. This method returns an associated watchID which you can use to
   * clear this watch via [clearWatch] method.
   *
   * + [success] - success callback function.
   * + [error] - error callback function.
   * + [options] - optional parameter.
   */
  watchHeading(CompassSuccessCB success,
               CompassErrorCB error, [CompassOptions options]) {
    return js.scoped(() {
      var s0 = (p) => success(new CompassHeading.fromProxy(p));
      var e0 = (p) => error(new CompassError.fromProxy(p));
      var ok = new js.Callback.many(s0);
      var fail = new js.Callback.many(e0);
      var opts = options == null ? null : js.map(options._toMap());
      var id = "cmp_${js.context.navigator.compass.watchHeading(ok, fail, opts)}";
      JsUtil.addCallbacks(id, [ok, fail]);
      return id;
    });
  }

  /**
   * Stop watching the CompassHeading that was associated with the specified
   * watchID.
   *
   * + [watchID] - the watch ID got from [watchCompassHeading] method.
   */
  void clearWatch(var watchID) {
    js.scoped(() {
      js.context.navigator.compass.clearWatch(watchID.substring(4));
      JsUtil.delCallbacks(watchID);
    });
  }
}

//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Thu, May 29, 2014  10:43:33 AM
// Author: urchinwang

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
  js.JsObject _compass;

  factory Compass() => compass;

  Compass._internal() {
    if (device == null)
      throw new StateError('device is not ready yet.');
      _compass = js.context['navigator']['compass'];
  }

  /**
   * Returns the current compass heading. It measures the heading in degrees 
   * from 0 to 359.99, where 0 is north.
   * Returns the error code if fail to obtain the compass heading; the error
   * code is returned via the [error] callback.
   */
  Future<dynamic> getCurrentHeading() {
    Completer cmpl = new Completer();
    var ok = (p) => cmpl.complete(new CompassHeading.getHeading(p));
    var fail = (p) => cmpl.completeError(new CompassError.getErrorCode(p));
    _compass.callMethod('getCurrentHeading', [ok, fail]);
    return cmpl.future;
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
    var ok = (p) => success(new CompassHeading.getHeading(p));
    var fail = (p) => error(new CompassError.getErrorCode(p));
    var opts = options == null ? null : new js.JsObject.jsify(options._toMap());
    var id = "cmp_${_compass.callMethod('watchHeading', [ok, fail, opts])}";
    return id;
  }

  /**
   * Stop watching the CompassHeading that was associated with the specified
   * watchID.
   *
   * + [watchID] - the watch ID got from [watchCompassHeading] method.
   */
  void clearWatch(var watchID) {
      _compass.callMethod('clearWatch', [watchID.substring(4)]);
  }
}

//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Thu, May 29, 2014  11:31:05 AM
// Author: urchinwang

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
  js.JsObject _geolocation;

  factory Geolocation() => geolocation;

  Geolocation._internal() {
    if (device == null)
      throw new StateError('device is not ready yet.');
    _geolocation = js.context['navigator']['geolocation'];
  }

  /**
   * Returns the current Position of this device.
   * The Position is returned via the success callback function.
   */
  Future<dynamic> getCurrentPosition([GeolocationOptions options]) {
    Completer cmpl = new Completer();
    var ok = (p) => cmpl.complete(new Position.getPosition(p));
    var fail = (p) => cmpl.completeError(new PositionError.getPositionError(p));
    _geolocation.callMethod('getCurrentPosition', [ok, fail]);
    return cmpl.future;
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
    var ok = (p) => success(new Position.getPosition(p));
    var fail = (p) => error(new PositionError.getPositionError(p));
    var opts = options == null ? null : new js.JsObject.jsify(options._toMap());
    var id = "geo_${_geolocation.callMethod('watchPosition',[ok, fail, opts])}";
    return id;
  }

  /**
   * Stop watching the Position that was associated with the specified
   * watchID.
   *
   * + [watchID] - the watch ID got from [watchPosition] method.
   */
  void clearWatch(var watchID) {
    _geolocation.callMethod('clearWatch', [watchID.substring(4)]);
  }
}

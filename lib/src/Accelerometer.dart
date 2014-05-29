//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Wed, May 28, 2014  11:31:33 PM
// Author: urchinwang

part of rikulo_accelerometer;

/** onSuccess callback function that returns the Acceleration information */
typedef AccelerometerSuccessCB(Acceleration accel);
/** onError callback function if fail getting the acceleration information */
typedef AccelerometerErrorCB();

/** Singleton Accelerometer. */
Accelerometer accelerometer = new Accelerometer._internal();

/**
 * Capture device motion in x, y, and z direction.
 */
class Accelerometer {
  js.JsObject _accelerometer;

  factory Accelerometer() => accelerometer;

  Accelerometer._internal() {
    if (device == null)
      throw new StateError('device is not ready yet.');
    _accelerometer = js.context['navigator']['accelerometer'];
//    js.context.callMethod('alert', [_accelerometer]);
  }

  /**
   * Returns the current motion Acceleration along x, y, and z axis.
   * The acceleration is returned via the [success] callback.
   */
  Future<Acceleration> getCurrentAcceleration() {
    Completer cmpl = new Completer();
    var ok = (p) => cmpl.complete(new Acceleration.getAcceleration(p));
    var fail = () => cmpl.completeError(null);
//    List jsfns = JSUtil.newCallbackOnceGroup("acc", [s0, e0], [1, 0]);
//    var ok = jsfns[0];
//    var fail = jsfns[1];
    _accelerometer.callMethod('getCurrentAcceleration', [ok, fail]);
    return cmpl.future;
  }

  /**
   * Register functions to get the Acceleration information in a regular
   * interval. This method returns an associated watchID which you can use to
   * clear this watch via [clearWatch] method.
   *
   * + [success] - success callback function.
   * + [error] - error callback function.
   * + [options] - optional parameter.
   */
  watchAcceleration(AccelerometerSuccessCB success,
                    AccelerometerErrorCB error, [AccelerometerOptions options]) {
    var ok = (p) => success(new Acceleration.getAcceleration(p));
    var fail = error;
    //var ok = new js.Callback.many(s0);
//    var ok = s0;
//    var fail = e0;
    var opts = options == null ? null : new js.JsObject.jsify(options._toMap());
    var id = "acc_${_accelerometer.callMethod('watchAcceleration', [ok, fail, opts])}";
    JSUtil.addCallbacks(id, [ok, fail]);
    return id;
  }

  /**
   * Stop watching the Acceleration that was associated with the specified
   * watchID.
   *
   * + [watchID] - the watch ID got from [watchAcceleration] method.
   */
  void clearWatch(var watchID) {
    _accelerometer.callMethod(js.context['clearWatch'], [watchID.substring(4)]);
    JSUtil.delCallbacks(watchID);
  }
}

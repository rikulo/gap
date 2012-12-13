//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Apr 27, 2012  10:26:33 AM
// Author: henrichen, tomyeh

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
  js.Proxy _accelerometer;

  factory Accelerometer() => accelerometer;

  Accelerometer._internal() {
    if (device == null)
      throw new RuntimeError('device is not ready yet.');
    js.scoped(() {
      _accelerometer = js.context.navigator.accelerometer;
      js.retain(_accelerometer);
    });
  }

  /**
   * Returns the current motion Acceleration along x, y, and z axis.
   * The acceleration is returned via the [success] callback.
   */
  void getCurrentAcceleration(AccelerometerSuccessCB success,
                              AccelerometerErrorCB error) {
    js.scoped(() {
      var s0 = (p) => success(new Acceleration.fromProxy(p));
      List jsfns = JsUtil.newCallbackOnceGroup("acc", [s0, error], [1, 0]);
      var ok = jsfns[0];
      var fail = jsfns[1];
      _accelerometer.getCurrentAcceleration(ok, fail);
    });
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
    return js.scoped(() {
      var s0 = (p) => success(new Acceleration.fromProxy(p));
      var ok = new js.Callback.many(s0);
      var fail = new js.Callback.many(error);
      var opts = options == null ? null : js.map(options._toMap());
      var id = "acc_${_accelerometer.watchAcceleration(ok, fail, opts)}";
      JsUtil.addCallbacks(id, [ok, fail]);
      return id;
    });
  }

  /**
   * Stop watching the Acceleration that was associated with the specified
   * watchID.
   *
   * + [watchID] - the watch ID got from [watchAcceleration] method.
   */
  void clearWatch(var watchID) {
    js.scoped(() {
      _accelerometer.clearWatch(watchID.substring(4));
      JsUtil.delCallbacks(watchID);
    });
  }
}

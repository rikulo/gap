part of rikulo_accelerometer;

/** onSuccess callback function that returns the Acceleration information */
typedef AccelerometerSuccessCB(Acceleration accel);
/** onError callback function if fail getting the acceleration information */
typedef AccelerometerErrorCB();

/** Singleton Accelerometer. */
final Accelerometer accelerometer = new Accelerometer._();

/**
 * Capture device motion in the x, y, and z direction.
 */
class Accelerometer {
  js.JsObject _accelerometer;
  
  Accelerometer._() {
    _accelerometer = js.context['navigator']['accelerometer'];
    if (_accelerometer == null)
      throw new StateError('Not ready yet.');
  }
  
  /**
   * Get the current acceleration along the x, y, and z axes.
   * These acceleration values are returned via future.then().
   */
  Future<Acceleration> getCurrentAcceleration() {
    Completer cmpl = new Completer();
    var ok = (p) => cmpl.complete(new Acceleration._fromProxy(p));
    var fail = (_) => cmpl.completeError(new UnknownError());
    
    _accelerometer.callMethod('getCurrentAcceleration', [ok, fail]);
    return cmpl.future;
  }
  
  /** 
   * At a regular interval, get the acceleration along the x, y, and z axis.
   * The returned watch ID references the accelerometer's watch interval, 
   * and can be used with accelerometer.clearWatch(ID) to stop watching the accelerometer.
   * 
   * + [success] - success callback function.
   * + [error] - error callback function.
   * + [options] - optional parameter got from [AccelerometerOptions] class.
   */
  watchAcceleration(AccelerometerSuccessCB success,
                    AccelerometerErrorCB error, [AccelerometerOptions options]) {
    var ok = (p) => success(new Acceleration._fromProxy(p));
    var fail = error;
    var opts = options == null ? null : new js.JsObject.jsify(options._toMap());
    
    var id = _accelerometer.callMethod('watchAcceleration', [ok, fail, opts]);
    return id;
  }
  
  /**
   * Stop watching the Acceleration referenced by the watchID parameter.
   * + [watchID] - the watch ID got from [watchAcceleration] method.
   */
  void clearWatch(var watchID) {
      _accelerometer.callMethod('clearWatch', [watchID]);
    }
}
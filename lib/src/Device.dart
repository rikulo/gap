part of rikulo_device;

/** Singleton Device. */
Device device;

/** The device object describes the device's hardware and software. */
class Device {
  js.JsObject _device;
  
  Device._internal() {
    _device = js.context['device'];
  }

  /** Get the device's operating system name. */
  String get platform => _device['platform'];
  /** Get the operating system version. */
  String get version => _device['version'];
  /** Get the device's Universally Unique Identifier. */
  String get uuid => _device['uuid'];
  /** Return the version of Cordova running on the device. */
  String get cordova => _device['cordova'];
  /** Return the name of the device's model or product. */
  String get model => _device['model'];
  
  /** Init the device when device APIs have loaded and are ready to access; 
   * throw exception if failed to enable the device.
   *
   *     Device.init()
   *     .then((Device device) {
   *        //Access the device
   *         ...
   *     })
   *     .catchError((ex) {
   *        //Fail to enable the device
   *         ...
   *     });
   *
   * This method can be called multiple times, but the second invocation
   * will return immediately.
   */
  static Future<Device> init() 
  => device == null ? 
      _enableDevice() : new Future.value(device);
  
  static Future<Device> _enableDevice() {
    Completer cmpl = new Completer();
    
    var _doWhenDeviceReady = (_) {
      device = new Device._internal();
      cmpl.complete(device);
    };
    
    //Essential to any application. It signals that Cordova's device APIs have loaded and are ready to access.
    document.addEventListener("deviceready", _doWhenDeviceReady, true);
    return cmpl.future;
  }
}

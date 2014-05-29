//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Wed, May 28, 2014  11:58:56 PM
// Author: urchinwang

part of rikulo_device;

/** Singleton Device. */
Device device;

/** The device. */
class Device {
  js.JsObject _device;

  Device._internal() {
      _device = js.context['device'];
  }
  
 /**
  * This represents the mobile device, and provides properties for inspecting the model, version, UUID of the
  * phone, etc.
  * @constructor
  */
  bool get available => _device['available'];
  String get platform => _device['platform'];
  String get version => _device['version'];
  String get uuid => _device['uuid'];
  String get cordova => _device['cordova'];
  String get model => _device['model'];

  void _onDeviceReady() {
    //TODO
  }

  void _onPause() {
    //TODO
  }

  void _onResume() {
    //TODO
  }

  void _onOnline() {
    //TODO
  }

  void _onOffline() {
    //TODO
  }

  void _onBackButton() {
    //TODO
  }

  void _onBatteryPause() {
    //TODO
  }

  void _onBatteryCritical() {
    //TODO
  }

  void _onBatteryLow() {
    //TODO
  }

  void _onBatteryStatus() {
    //TODO
  }

  void _onMenuButton() {
    //TODO
  }

  void _onSearchButton() {
    //TODO
  }

  void _onStartCallButton() {
    //TODO
  }

  void _onEndCallButton() {
    //TODO
  }

  void _onVolumeDownButton() {
    //TODO
  }

  void _onVolumeUpButton() {
    //TODO
  }

  void _registerDeviceEvents() {
    _addEventListener("pause", _onPause);
    _addEventListener("resume", _onResume);
    _addEventListener("online", _onOnline);
    _addEventListener("offline", _onOffline);
    _addEventListener("backbutton", _onBackButton);
    _addEventListener("batterycritical", _onBatteryCritical);
    _addEventListener("batterylow", _onBatteryLow);
    _addEventListener("batterystatus", _onBatteryStatus);
    _addEventListener("menubutton", _onMenuButton);
    _addEventListener("searchbutton", _onSearchButton);
    _addEventListener("startcallbutton", _onStartCallButton);
    _addEventListener("endcallbutton", _onEndCallButton);
    _addEventListener("volumedownbutton", _onVolumeDownButton);
    _addEventListener("volumeupbutton", _onVolumeUpButton);
  }
}

/** Enable the device accessibility and pass the singleton device via
 * a Future; throw exception if failed to enable the device.
 *
 *     Future<device> enable = enableDeviceAccess();
 *     enable.then((device) {
 *        //Access the device
 *         ...
 *     });
 *     enable.handleException((ex) {
 *        //Fail to enable the device
 *         ...
 *     });
 *
 * This method can be called multiple times, but the second invocation
 * will return the ready singleton device immediately.
 *
 * + [serviceUri] - the URI of the device access service uri;
 *                  default: "cordova.js".
 */
Future<Device> enableDeviceAccess()
=> device == null ?
    _doWhenDeviceReady() : new Future.value(device);

//wait Cordova ready
Future<Device> _doWhenDeviceReady() {
  Completer cmpl = new Completer();
  
  _doDeviceReady () {
    Device dev = new Device._internal();
    dev._registerDeviceEvents();
    device = dev;
    dev._onDeviceReady();
    cmpl.complete(dev);
  }
  
  if (_deviceReady()) {
    try {
      _doDeviceReady();
    } catch (exp) {
      cmpl.completeError(exp);
    }
  } else
    _addEventListener("deviceready", _doDeviceReady, true);
  return cmpl.future;
}

//Add cordova event listener
void _addEventListener(String name, Function callback, [bool once = false]) {
  document.addEventListener(name, callback, false);
}

//Whether cordova device is ready
bool _deviceReady() {
    var ctx = js.context;
    if (ctx['cordova'] != null) {
      var cordova = ctx['cordova'];
      if(cordova['require'] != null) {
        var channel = cordova.callMethod('require', ['cordova/channel']);
        var features = channel.deviceReadyChannelsArray;
        var len = features.length;
        for (int j = 0; j < len; ++j) {
          var f = features[j];
          if (f['fired'] == false) return false;
        }
      }
    }
    return true;
}
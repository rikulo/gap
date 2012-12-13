//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, May 2, 2012  12:32:56 PM
// Author: henrichen

part of rikulo_device;

/** Singleton Device. */
Device device;

/** The device. */
class Device {
  js.Proxy _device;

  Device._internal() {
    js.scoped(() {
      _device = js.context.device;
      js.retain(_device);
    });
  }

  String get name => js.scoped(() => _device.name);
  String get cordova => js.scoped(() => _device.cordova);
  String get platform => js.scoped(() => _device.platform);
  String get uuid => js.scoped(() => _device.uuid);
  String get version => js.scoped(() => _device.version);

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
Future<Device> enableDeviceAccess([String serviceUri = "cordova.js"])
=> device == null ?
    _doWhenDeviceReady(serviceUri) : new Future.immediate(device);

//wait Cordova ready
Future<Device> _doWhenDeviceReady(String serviceUri) {
  //load cordova.js
  if (!_cordovaLoaded())
    _injectJavaScriptSrc(serviceUri); //load "cordova.js" asynchronously

  //wait cordova.js to be loaded. Try every 10 ms, try total 180 seconds
  Future<bool> loaded = JsUtil.doWhenReady(_cordovaLoaded, 50, 180000);

  //prepare the device-ready callback
  Completer cmpl = new Completer();
  Function _doDeviceReady = () {
    Device dev = new Device._internal();
    dev._registerDeviceEvents();
    device = dev;
    dev._onDeviceReady();
    cmpl.complete(dev);
  };

  //after cordova.js loaded
  loaded.then((ready) {
    if (ready) {
      //call/register the device-ready callback
      if (_deviceReady())
        _doDeviceReady();
      else
        _addEventListener("deviceready", _doDeviceReady, true);
    } else //time out, throw exception.
      cmpl.completeException(
          new RuntimeError("Time out! Fail to enable the device."));
  });

  return cmpl.future;
}

//Add cordova event listener
void _addEventListener(String name, Function callback, [bool once = false]) {
  js.scoped(() {
    var listener = once ?
        new js.Callback.once(callback) : new js.Callback.many(callback);
        js.context.document.addEventListener(name, listener, false);

  });
}

//Whether cordova.js is loaded
bool _cordovaLoaded() {
  return js.scoped(() {
    var ctx = js.context;
    if (ctx['cordova'] != null) {
      var cordova = ctx['cordova'];
      if(cordova['require'] != null) {
        var channel = cordova['require']("cordova/channel");
        if (!channel.onDOMContentLoaded.fired) {
          channel.onDOMContentLoaded.fire();
        }
      }
    }
    return ctx['cordova'] != null;
  });
}

//Whether cordova device is ready
bool _deviceReady() {
  return js.scoped(() {
    var ctx = js.context;
    if (ctx['cordova'] != null) {
      var cordova = ctx['cordova'];
      if(cordova['require'] != null) {
        var channel = cordova['require']("cordova/channel");
        var features = channel.deviceReadyChannelsArray;
        var len = features.length;
        for (int j = 0; j < len; ++j) {
          var f = features[j];
          if (!f.fired) return false;
        }
      }
    }
    return true;
  });
}

//Inject JavaScript
void _injectJavaScriptSrc(String uri) {
  var s = new ScriptElement();
  s.type = "text/javascript";
  s.charset = "utf-8";
  s.src = uri;
  document.head.nodes.add(s);
}

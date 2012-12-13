//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, May 21, 2012  02:44:12 PM
// Author: henrichen

part of rikulo_capture;

/** onSuccess callback function that returns the captured media */
typedef CaptureSuccessCB(List<MediaFile> mediaFiles);

/** onError callback function if fail to capture the media */
typedef CaptureErrorCB(CaptureError error);

/** Singleton Capture. */
Capture capture = new Capture._internal();

/**
 * Access to the audio/image/video capture facility of this device.
 */
class Capture {
  js.Proxy _capture;

  factory Capture() => capture;

  Capture._internal() {
    if (device == null)
      throw new RuntimeError('device is not ready yet.');
    js.scoped(() {
      _capture = js.context.navigator.device.capture;
      js.retain(_capture);
    });
  }

  /** Returns the audio formats supported by this device */
  List<ConfigurationData> get supportedAudioModes
  => js.scoped(() => _capture.supportedAudioModes);

  /** Returns the image formats/size supported by this device */
  List<ConfigurationData> get supportedImageModes
  => js.scoped(() => _capture.supportedImageModes);

  /** Returns the video formats/resolutions suupported by this device */
  List<ConfigurationData> get supportedVideoModes
  => js.scoped(() => _capture.supportedVideoModes);

  /** Launch device audio recording application to record audio clips. */
  void captureAudio(CaptureSuccessCB success,
                    CaptureErrorCB error, [CaptureAudioOptions options]) {
    js.scoped(() {
      var s0 = (p) => success(_toFiles(p));
      var e0 = (p) => error(new CaptureError.fromProxy(p));
      var jsfns = JsUtil.newCallbackOnceGroup("cap", [s0, e0], [1, 1]);
      var ok = jsfns[0];
      var fail = jsfns[1];
      var opts = options == null ? null : js.map(options._toMap());
      _capture.captureAudio(ok, fail, opts);
    });
  }

  /** Launch camera application to capture image files. */
  void captureImage(CaptureSuccessCB success,
                    CaptureErrorCB error, [CaptureImageOptions options]) {
    js.scoped(() {
      var s0 = (p) => success(_toFiles(p));
      var e0 = (p) => error(new CaptureError.fromProxy(p));
      var jsfns = JsUtil.newCallbackOnceGroup("cap", [s0, e0], [1, 1]);
      var ok = jsfns[0];
      var fail = jsfns[1];
      var opts = options == null ? null : js.map(options._toMap());
      _capture.captureImage(ok, fail, opts);
    });
  }

  /** Launch device video recording application to record video clips. */
  void captureVideo(CaptureSuccessCB success,
                    CaptureErrorCB error, [CaptureVideoOptions options]) {
    js.scoped(() {
      var s0 = (p) => success(_toFiles(p));
      var e0 = (p) => error(new CaptureError.fromProxy(p));
      var jsfns = JsUtil.newCallbackOnceGroup("cap", [s0, e0], [1, 1]);
      var ok = jsfns[0];
      var fail = jsfns[1];
      var opts = options == null ? null : js.map(options._toMap());
      _capture.captureVideo(ok, fail, opts);
    });
  }

  List<MediaFile> _toFiles(js.Proxy p) {
    List<MediaFile> result = new List();
    for(var j = 0; j < p.length; ++j) {
      MediaFile mf = new MediaFile.fromProxy(p[j]);
      result.add(mf);
    }
    return result;
  }
}
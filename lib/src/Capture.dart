//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Thu, May 29, 2014  11:55:54 AM
// Author: urchinwang

part of rikulo_capture;

/** Singleton Capture. */
Capture capture = new Capture._internal();

/**
 * Access to the audio/image/video capture facility of this device.
 */
class Capture {
  js.JsObject _capture;

  factory Capture() => capture;

  Capture._internal() {
    if (device == null)
      throw new StateError('device is not ready yet.');
    _capture = js.context['navigator']['device']['capture'];
  }

  /** Returns the audio formats supported by this device */
  List<ConfigurationData> get supportedAudioModes
  => _capture.callMethod('supportedAudioModes');

  /** Returns the image formats/size supported by this device */
  List<ConfigurationData> get supportedImageModes
  => _capture.callMethod('supportedImageModes');

  /** Returns the video formats/resolutions suupported by this device */
  List<ConfigurationData> get supportedVideoModes
  => _capture.callMethod('supportedVideoModes');

  /** Launch device audio recording application to record audio clips. */
  Future<dynamic> captureAudio([CaptureAudioOptions options]) {
    Completer cmpl = new Completer();
    var ok = (p) => cmpl.complete(_toFiles(p));
    var fail = (p) => cmpl.completeError(new CaptureError.getErrorCode(p));
    var opts = options == null ? null : new js.JsObject.jsify(options._toMap());
    _capture.callMethod('captureAudio', [ok, fail, opts]);
    return cmpl.future;
  }

  /** Launch camera application to capture image files. */
  Future<dynamic> captureImage([CaptureImageOptions options]) {
    Completer cmpl = new Completer();
    var ok = (p) => cmpl.complete(_toFiles(p));
    var fail = (p) => cmpl.completeError(new CaptureError.getErrorCode(p));
    var opts = options == null ? null : new js.JsObject.jsify(options._toMap());
    _capture.callMethod('captureImage', [ok, fail, opts]);
    return cmpl.future;
  }

  /** Launch device video recording application to record video clips. */
  Future<dynamic> captureVideo([CaptureVideoOptions options]) {
    Completer cmpl = new Completer();
    var ok = (p) => cmpl.complete(_toFiles(p));
    var fail = (p) => cmpl.completeError(new CaptureError.getErrorCode(p));
    var opts = options == null ? null : new js.JsObject.jsify(options._toMap());
    _capture.callMethod('captureVideo', [ok, fail, opts]);
    return cmpl.future;
  }

  List<MediaFile> _toFiles(js.JsObject p) {
    List<MediaFile> result = new List();
    for(var j = 0; j < p['length']; ++j) {
      MediaFile mf = new MediaFile.getFile(p[j]);
      result.add(mf);
    }
    return result;
  }
}
//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Thu, May 29, 2014  11:04:33 AM
// Author: urchinwang

part of rikulo_camera;

typedef CameraSuccessCB(String imageData);
typedef CameraErrorCB(String message);
typedef CleanupSuccessCB();

/** Singleton Camera. */
Camera camera = new Camera._internal();

/**
 * Access to the camera application of this device.
 */
class Camera {
  js.JsObject _camera;

  factory Camera() => camera;

  Camera._internal() {
    if (device == null)
      throw new StateError('device is not ready yet.');
      _camera = js.context['navigator']['camera'];
  }

  /**
  * Takes a photo using the camera or retrieves a photo from the device's
  * album based on the cameraOptoins paremeter. Returns the image as a
  * base64 encoded String or as the URI of an image file.
  */
  Future<dynamic> getPicture([CameraOptions options]) {
    Completer cmpl = new Completer();
    var ok = (p) => cmpl.complete(new CameraImageData.getImagegData(p));
    var fail = (p) => cmpl.completeError(new CameraError.getErrorMessage(p));
    var opts = options == null ? null : new js.JsObject.jsify(options._toMap());
    _camera.callMethod('getPicture', [ok, fail, opts]);
    return cmpl.future;
  }

  /**
   * Cleans up the image files stored in temporary storage that were taken by
   * the method [getPicture] when the [CameraOptions.sourceType] is set to
   * [PictureSourceType.CAMERA] and [CameraOptions.destinationType] is set
   * to [DestinationType.FILE_URI].
   */
  Future<dynamic> cleanup() {
    Completer cmpl = new Completer();
    var ok = (_) => cmpl.complete(null);
    var fail = (p) => cmpl.completeError(new CameraError.getErrorMessage(p));
    _camera.callMethod('cleanup', [ok, fail]);
    return cmpl.future;
  }
}

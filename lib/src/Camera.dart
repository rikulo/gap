//1Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, May 9, 2012  09:12:33 AM
// Author: henrichen

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
  js.Proxy _camera;

  factory Camera() => camera;

  Camera._internal() {
    if (device == null)
      throw new RuntimeError('device is not ready yet.');
    js.scoped(() {
      _camera = js.context.navigator.camera;
      js.retain(_camera);
    });
  }

  /**
  * Takes a photo using the camera or retrieves a photo from the device's
  * album based on the cameraOptoins paremeter. Returns the image as a
  * base64 encoded String or as the URI of an image file.
  */
  void getPicture(CameraSuccessCB success,
      CameraErrorCB error, [CameraOptions options]) {
    js.scoped(() {
      var jsfns = JsUtil.newCallbackOnceGroup("cam", [success, error], [1, 1]);
      var ok = jsfns[0];
      var fail = jsfns[1];
      var opts = options == null ? null : js.map(options._toMap());
      _camera.getPicture(ok, fail, opts);
    });
  }

  /**
   * Cleans up the image files stored in temporary storage that were taken by
   * the method [getPicture] when the [CameraOptions.sourceType] is set to
   * [PictureSourceType.CAMERA] and [CameraOptions.destinationType] is set
   * to [DestinationType.FILE_URI].
   */
  void cleanup(CleanupSuccessCB success, CameraErrorCB error) {
    js.scoped(() {
      var jsfns = JsUtil.newCallbackOnceGroup("cam", [success, error], [0, 1]);
      var ok = jsfns[0];
      var fail = jsfns[1];
      _camera.cleanup(ok, fail);
    });
  }
}

//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, May 21, 2012  02:32:31 PM
// Author: henrichen

part of rikulo_capture;

/** Error returned when failed to capture the require media */
class CaptureError {
  static const int CAPTURE_INTERNAL_ERR = 0;
  static const int CAPTURE_APPLICATION_BUSY = 1;
  static const int CAPTURE_INVALID_ARGUMENT = 2;
  static const int CAPTURE_NO_MEDIA_FILES = 3;
  static const int CAPTURE_NOT_SUPPORTED = 20;

  final int code; //error code

  CaptureError.fromProxy(js.Proxy p)
      : this.code = p.code;
}


//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Thu, May 29, 2014  11:19:57 AM
// Author: urchinwang

part of rikulo_camera;

class CameraError {
  final String message;
  
  CameraError.getErrorMessage(js.JsObject p)
      : this.message = p as String;
}
//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Thu, May 29, 2014  11:04:33 AM
// Author: urchinwang

part of rikulo_camera;

class CameraImageData {
  final String data;
  
  CameraImageData.getImagegData(js.JsObject p)
      : this.data = p as String;
}
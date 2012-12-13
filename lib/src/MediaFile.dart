//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, May 21, 2012  03:51:44 PM
// Author: henrichen

part of rikulo_capture;

/** onSuccess callback function that returns the file data. */
typedef MediaFileDataSuccessCB(MediaFileData data);

/** onError callback function if fail getting the file data. */
typedef MediaFileDataErrorCB();

/** Midea capture file */
class MediaFile {
  /** file name without path information */
  String name;
  /** file name with full path information */
  String fullPath;
  /** MIME type of this file */
  String type;
  /** The date/time this file was last modified */
  Date date;
  /** The file size in bytes */
  int size;

  js.Proxy _proxy;

  MediaFile.fromProxy(js.Proxy p)
      : this._proxy = p,
        this.name = p.name,
        this.fullPath = p.fullPath,
        this.type = p.type,
        this.date = p.date,
        this.size = p.size {
    js.retain(_proxy); //must retain the proxy for calling getFormatData
  }

  /** Returns format information of this Media file */
  void getFormatData(MediaFileDataSuccessCB success, [MediaFileDataErrorCB error]) {
    js.scoped(() {
      var s0 = (p) => success(new MediaFileData.fromProxy(p));
      List jsfns = JsUtil.newCallbackOnceGroup("cap", [s0, error], [1, 0]);
      var ok = jsfns[0];
      var fail = jsfns[1];
      _proxy.getFormatData(ok, fail);
    });
  }

  /** Release the MediaFile */
  void release() {
    js.scoped(() => js.release(_proxy));
  }
}


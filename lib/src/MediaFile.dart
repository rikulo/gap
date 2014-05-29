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
  DateTime date;
  /** The file size in bytes */
  int size;

  js.JsObject _proxy;

  MediaFile.getFile(js.JsObject p)
      : this._proxy = p,
        this.name = p['name'],
        this.fullPath = p['fullPath'],
        this.type = p['type'],
        this.date = p['date'],
        this.size = p['size'];

  /** Returns format information of this Media file */
  void getFormatData() {
    Completer completer = new Completer();
    var s0 = (p) {completer.complete(new MediaFileData.getFileData(p));};
    var e0 = () {};
    _proxy.callMethod('getFormatData', [s0, e0]);
  }
}


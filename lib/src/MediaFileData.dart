//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, May 21, 2012  03:51:44 PM
// Author: henrichen

part of rikulo_capture;

/** The media file data */
class MediaFileData {
  /** the actual format of the audio/video contents */
  String codecs;
  /** The average bitrate of the content; image is always 0 */
  double bitrate;
  /** The height of the image/video in pixels; for sound clip always 0 */
  int height;
  /** the width of the image/video in pixels; for sound clip always 0 */
  int width;
  /** The length of audio/video clip in seconds; image is always 0 */
  int duration;

  MediaFileData.fromProxy(js.Proxy p)
      : this.codecs = p.codecs,
        this.bitrate = p.bitrate,
        this.height = p.height,
        this.width = p.width,
        this.duration = p.duration;
}

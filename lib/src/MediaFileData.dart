//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Thu, May 29, 2014  12:10:33 AM
// Author: urchinwang

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

  MediaFileData.getFileData(js.JsObject p)
      : this.codecs = p['codecs'],
        this.bitrate = p['bitrate'],
        this.height = p['height'],
        this.width = p['width'],
        this.duration = p['duration'];
}

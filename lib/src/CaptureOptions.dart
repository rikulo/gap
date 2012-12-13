//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, May 21, 2012  02:44:12 PM
// Author: henrichen

part of rikulo_capture;

/** Options used with [Capture.captureAudio] method. */
class CaptureAudioOptions {
  /** The maximum number of audio clips the device user can record in a single capture operation; default to 1; */
  final int limit;
  /** The maximum duration of an audio sound clip in seconds */
  final int duration;
  /** The selected audio mode; must be one of supportedAudioModes in Capture */
  final ConfigurationData mode;

  CaptureAudioOptions({this.limit : 1, this.duration, this.mode});

  Map _toMap()
  => {'limit' : limit, 'duration' : duration, 'mode' : mode._toMap()};
}

/** Options used with [Capture.captureImage] method. */
class CaptureImageOptions {
  /** The maximum number of images the device user can capture in a single capture operation; default to 1; */
  final int limit;
  /** The selected image mode; must be one of supportedImageModes in Capture */
  final ConfigurationData mode;

  CaptureImageOptions({this.limit : 1, this.mode});

  Map _toMap()
  => {'limit' : limit, 'mode' : mode._toMap()};
}

/** Options used with [Capture.captureVideo] method. */
class CaptureVideoOptions {
  /** The maximum number of video clips the device user can record in a single capture operation; default to 1; */
  final int limit;
  /** The maximum duration of a video clip in seconds */
  final int duration;
  /** The selected video mode; must be one of supportedVideoModes in Capture */
  final ConfigurationData mode;

  CaptureVideoOptions({this.limit : 1, this.duration, this.mode});

  Map _toMap()
  => {'limit' : limit, 'duration' : duration, 'mode' : mode._toMap()};
}

/** Media configuration data */
class ConfigurationData {
  /** MIME types supported by this device.
   * video/3gpp
   * video/quicktime
   * image/jpeg
   * audio/amr
   * audio/wav
   */
  final String type;
  /** The height of the image/video in pixels; for sound clip always 0 */
  final int height;
  /** the width of the image/video in pixels; for sound clip always 0 */
  final int width;

  ConfigurationData(this.type, this.height, this.width);

  Map _toMap()
  => {'type' : type, 'height' : height, 'width' : width};
}

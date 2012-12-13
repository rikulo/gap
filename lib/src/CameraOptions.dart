//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, May 9, 2012  09:12:33 AM
// Author: henrichen

part of rikulo_camera;

/** Options used with [Camera]. */
class CameraOptions {
  /** The picture quality(0 ~ 100); default: 100. */
  final int quality;
  /**
   * The picture format(DestinationType); default: [DestinationType.FILE_URI].
   */
  final int destinationType;
  /** The picture source(PictureSourceType); default:
   * [PictureSourceType.CAMERA].
   */
  final int sourceType;
  /** Whether allows simple editing before selection */
  final bool allowEdit;
  /** The encoding format(EncodingType) */
  final int encodingType;
  /** Width in pixels (retain scale ratio) */
  final int targetWidth;
  /** Height in pixels (retain scale ratio) */
  final int targetHeight;
  /** Media type(MediaType). Only when
   *  sourceType == PictureSourceType.PHOTOLIBRARY or
   *  sourceType == PictureSourceType.SAVEDPHOTOALBUM
   */
  final int mediaType;
  /** Whether rotate the image to correct the orientation */
  final bool correctOrientation;
  /** Whether save the image to photo album after capture */
  final bool saveToPhotoAlbum;

  /** Options used with [Camera]. */
  CameraOptions({
      int quality : 100,
      int destinationType : DestinationType.FILE_URI,
      int sourceType : PictureSourceType.CAMERA,
      bool allowEdit,
      int encodingType,
      int targetWidth,
      int targetHeight,
      int mediaType,
      bool correctOrientation,
      bool saveToPhotoAlbum})
      : this.quality = quality,
        this.destinationType = destinationType,
        this.sourceType = sourceType,
        this.allowEdit = allowEdit,
        this.encodingType = encodingType,
        this.targetWidth = targetWidth,
        this.targetHeight = targetHeight,
        this.mediaType = mediaType,
        this.correctOrientation = correctOrientation,
        this.saveToPhotoAlbum = saveToPhotoAlbum;

  Map _toMap()
  => {'quality' : quality,
      'destinationType' : destinationType,
      'sourceType' : sourceType,
      'allowEdit' : allowEdit,
      'encodingType' : encodingType,
      'targetWidth' : targetWidth,
      'targetHeight' : targetHeight,
      'mediaType' : mediaType,
      'correctOrientation' : correctOrientation,
      'saveToPhotoAlbum' : saveToPhotoAlbum};
}

class DestinationType {
  /** Returns image as base64 encoded string */
  static const int DATA_URL = 0;
  /** Returns image as file URI */
  static const int FILE_URI = 1;
}

class EncodingType {
  static const int JPEG = 0;
  static const int PNG = 1;
}

class MediaType {
  static const int PICTURE = 0;
  static const int VIDEO = 1;
  static const int ALLMEDIA = 2;
}

class PictureSourceType {
  static const int PHOTOLIBRARY = 0;
  static const int CAMERA = 1;
  static const int SAVEDPHOTOALBUM = 2;
}

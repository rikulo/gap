//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Thu, May 29, 2014  10:20:40 AM
// Author: urchinwang

part of rikulo_notification;

/** The notification confirm button index, which is the index of 
 * the pressed button. Note that the index uses one-based indexing, 
 * so the value is 1, 2, 3, etc.
 */
class ButtonIndex {
  final num index;
  
  ButtonIndex.getIndex(js.JsObject p)
    : this.index = p as num;
  
  String toString()
  => "($index)";
}
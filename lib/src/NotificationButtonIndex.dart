part of rikulo_notification;

/** 
 * The notification confirm button index, which is the index of 
 * the pressed button. Note that the index uses one-based indexing, 
 * so the value is 1, 2, 3, etc.
 */
class NotificationButtonIndex {
  final num buttonIndex;
    
  NotificationButtonIndex._fromProxy(js.JsObject p)
      : this.buttonIndex = p as num;
}
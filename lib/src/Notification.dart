//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, May 18, 2012  03:31:33 PM
// Author: henrichen

part of rikulo_notification;

/** Singleton Notification. */
Notification notification = new Notification._internal();

/**
 * Access to the device notification facility.
 */
class Notification {
  js.JsObject _notification;

  factory Notification() => notification;

  Notification._internal() {
    if (device == null)
      throw new StateError('device is not ready yet.');
    _notification = js.context['navigator']['notification'];
  }

  /** Show a custom alert/dialog box.
   * + [message] dialog message.
   * + [title] dialog title; default to "Alert".
   * + [buttonName] button name of the dialog; default to "OK".
   */
  Future alert(String message, 
      [String title = 'Alert', String buttonName = 'OK']) {
    Completer cmpl = new Completer();
    var ok = () => cmpl.complete();
    _notification.callMethod('alert', [message, ok, title, buttonName]);
    return cmpl.future;
  }

  /** Show a customizable confirmation dialog box.
   * + [message] dialog message.
   * + [title] dialog title; default to "Confirm".
   * + [buttonLabels] comma separated button names of the dialog; default to "OK,Cancel".
   */
  Future<ButtonIndex> confirm(String message, 
      [String title = 'Confirm', String buttonLabels = 'OK,Cancel']) {
    Completer cmpl = new Completer();
    var ok = (index) => cmpl.complete(new ButtonIndex.getIndex(index));
    _notification.callMethod('confirm', [message, ok, title, buttonLabels]);
    return cmpl.future;
  }

  /** Play a beep sound.
   * + [times] the number of times to beep.
   */
  beep(int times) =>  _notification.callMethod('beep', [times]);

  /** Vibrates device the specified duration in milliseconds.
   */
  vibrate(int milliseconds) => _notification.callMethod('vibrate', [milliseconds]);
}

//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, May 18, 2012  03:31:33 PM
// Author: henrichen

part of rikulo_notification;

typedef NotificationAlertCallback();
typedef NotificationConfirmCallback(int buttonId);

/** Singleton Notification. */
Notification notification = new Notification._internal();

/**
 * Access to the device notification facility.
 */
class Notification {
  js.Proxy _notification;

  factory Notification() => notification;

  Notification._internal() {
    if (device == null)
      throw new RuntimeError('device is not ready yet.');
    js.scoped(() {
      _notification = js.context.navigator.notification;
      js.retain(_notification);
    });
  }

  /** Show a custom alert/dialog box.
   * + [message] dialog message.
   * + [alertCallback] callback function when the alert dialog is closed.
   * + [title] dialog title; default to "Alert".
   * + [buttonName] button name of the dialog; default to "OK".
   */
  alert(String message, NotificationAlertCallback alertCallback,
      [String title = 'Alert', String buttonName = 'OK']) {
    js.scoped(() {
      var s = new js.Callback.once(alertCallback);
      _notification.alert(message, s, title, buttonName);
    });
  }

  /** Show a customizable confirmation dialog box.
   * + [message] dialog message.
   * + [confirmCallback] callback function invoked with index of button pressed(1, 2, or 3) when the confirm dialog is closed.
   * + [title] dialog title; default to "Confirm".
   * + [buttonLabels] comma separated button names of the dialog; default to "OK,Cancel".
   */
  confirm(String message, NotificationConfirmCallback confirmCallback,
          [String title = 'Confirm', String buttonLabels = 'OK,Cancel']) {
    js.scoped(() {
      var s = new js.Callback.once(confirmCallback);
      _notification.confirm(message, s, title, buttonLabels);
    });
  }

  /** Play a beep sound.
   * + [times] the number of times to beep.
   */
  beep(int times) => js.scoped(() => _notification.beep(times));

  /** Vibrates device the specified duration in milliseconds.
   */
  vibrate(int milliseconds) => js.scoped(() => _notification.vibrate(milliseconds));
}

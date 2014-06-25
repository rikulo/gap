part of rikulo_notification;

/** Singleton Notification. */
final Notification notification = new Notification._();

class Notification {
  js.JsObject _notification;
  
  Notification._() {
    _notification = js.context['navigator']['notification'];
    if (_notification == null)
      throw new StateError('Not ready yet');
  }
  
  /** Shows a custom alert or dialog box.
   * + [message] - dialog message.
   * + [title] - dialog title; default to "Alert".
   * + [buttonName] - button name of the dialog; default to "OK".
   */
  Future alert(String message,
               [String title = 'Alert', String buttonName = 'OK']) {
    Completer cmpl = new Completer();
    var ok = () => cmpl.complete();
    
    _notification.callMethod('alert', [message, ok, title, buttonName]);
    return cmpl.future;
  }
  
  /** Displays a customizable confirmation dialog box.
   * + [message] - dialog message.
   * + [title] - dialog title; default to "Confirm".
   * + [buttonLabels] - List of strings specifying button labels; defaults to ['OK', 'Cancel'].
   */
  Future<NotificationButtonIndex> confirm(String message,
      [String title = 'Confirm', var buttonLabels = const ['OK', 'Cancel']]) {
    Completer cmpl = new Completer();
    var ok = (p) => cmpl.complete(new NotificationButtonIndex._fromProxy(p));
    
    _notification.callMethod('confirm', [message, ok, title, buttonLabels]);
    return cmpl.future;
  }
  
  /** Shows a customizable prompt dialog box.
   * + [message] - dialog message.
   * + [title] - dialog title; default to "Prompt".
   * + [buttonLabels] - List of strings specifying button labels; defaults to ['OK', 'Cancel'].
   * + [defaultText] - Default textbox input value; default to empty string.
   */
  Future<NotificationPromptResults> prompt(String message, 
      [String title = 'Prompt', var buttonLabels = const ['OK', 'Cancel'], String defaultText = '']) {
    Completer cmpl = new Completer();
    var ok = (p) => cmpl.complete(new NotificationPromptResults._fromProxy(p));
    
    _notification.callMethod('prompt', [message, ok, title, buttonLabels, defaultText]);
    return cmpl.future;
  }
  
  /** The device plays a beep sound.
   * + [times] - The number of times to repeat the beep.
   */
  void beep(int times) => _notification.callMethod('beep', [times]);

  /** Vibrates the device for the specified amount of time.
   * + [milliseconds] - Milliseconds to vibrate the device, where 1000 milliseconds equals 1 second.
   */
  void vibrate(int milliseconds) => _notification.callMethod('vibrate', [milliseconds]);
}
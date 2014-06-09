part of rikulo_notification;

class NotificationPromptResults {
  final num buttonIndex;
  final String input1;
    
  NotificationPromptResults._fromProxy(js.JsObject p)
      : this.buttonIndex = p['buttonIndex'],
        this.input1 = p['input1'];
  
  String toString() => "($buttonIndex $input1)";
}
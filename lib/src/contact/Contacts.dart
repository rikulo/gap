part of rikulo_contact;

///The [Contacts] object to access the contacts list.
final Contacts contacts = new Contacts._();

/**
 * Access to the contacts list of this device.
 */
class Contacts {
  final js.JsObject _contacts;

  Contacts._(): _contacts = js.context['navigator']['contacts'] {
      if (_contacts == null)
        throw new StateError('Not ready yet');
  }

  /**
  * Returns the Contacts queried by this method.
  * + [fields] the fields name in Contact you want to query back; return
  *   Contact id only if empty; a zero-length fields is invalid and
  *   result in [ContactError.INVALID_ARGUMENT_ERROR];return all fields
  *   if provide ["*"].
  * + [contactOptions] the filter string to apply the query.
  */
  Future<List<Contact>> find(List<String> fields, ContactsFindOptions contactOptions) {
    Completer completer = new Completer();
    var fieldList = new js.JsArray.from(fields);
    var ok = (js.JsArray p) {
      List<Contact> result = new List();
      for(var j = 0; j < p.length; ++j) {
  print('++++++${p[j]}');
        result.add(new Contact._fromProxy(p[j]));
      }
  print('====');
      completer.complete(result);
    };
    var fail = (p) {completer.completeError(new ContactError._fromProxy(p));};
    var opts = new js.JsObject.jsify(contactOptions._toMap());
    _contacts.callMethod('find', [fieldList, ok, fail, opts]);
    return completer.future;
  }
}

part of rikulo_contacts;

/** Singleton Contacts. */
Contacts contacts = new Contacts._internal();

/**
 * Access to the contacts list of this device.
 */
class Contacts {
  js.JsObject _contacts;

  Contacts._internal() {
    if (device == null)
      throw new StateError('device is not ready yet.');
      _contacts = js.context['navigator']['contacts'];
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
      var ok = (p) {
        List<Contact> result = new List();
        for(var j = 0; j < p.length; ++j)
          result.add(new Contact._fromProxy(p[j]));
        completer.complete(result);
      };
      var fail = (p) {completer.completeError(new ContactError._fromProxy(p));};
      var opts = new js.JsObject.jsify(contactOptions._toMap());
      _contacts.callMethod(js.context['find'], [fieldList, ok, fail, opts]);
      return completer.future;
  }
}



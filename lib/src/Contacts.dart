part of rikulo_contacts;

/** onSuccess callback function that returns the Contact List */
typedef ContactsSuccessCB(List<Contact> contacts);
/** onError callback function if fail getting the Contact List */
typedef ContactsErrorCB(ContactError error);

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
  *   Contact id only if empty; return all fields if provide ["*"].
  * + [contactOptions] the filter string to apply the query.
  */
  Future<List<Contact>> find(List<String> fields, ContactsFindOptions contactOptions) {
    Completer completer = new Completer();
      var fs = new js.JsArray.from(fields);
      var s0 = (p) {
        List<Contact> result = new List();
        for(var j = 0; j < p.length; ++j)
          result.add(new Contact._fromProxy(p[j]));
        completer.complete(result);
      };
      var e0 = (p) {completer.completeError(new ContactError._fromProxy(p));};
      var opts = new js.JsObject.jsify(contactOptions._toMap());
      _contacts.callMethod(js.context['find'], [fs, s0, e0, opts]);
      return completer.future;
  }
}



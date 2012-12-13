//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, May 14, 2012  02:28:13 PM
// Author: henrichen

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
  js.Proxy _contacts;

  factory Contacts() => contacts;

  Contacts._internal() {
    if (device == null)
      throw new RuntimeError('device is not ready yet.');
    js.scoped(() {
      _contacts = js.context.navigator.contacts;
      js.retain(_contacts);
    });
  }

  /**
   * Create a new Contact object but not persisted into contact DB yet.
   * + [properties] the initial properties for the created [Contact].
   */
  Contact create(Map properties) {
    js.scoped(() {
      var props = js.map(properties);
      return new Contact.fromProxy(_contacts.create(props));
    });
  }

  /**
  * Returns the Contacts queried by this method.
  * + [fields] the fields name in Contact you want to query back; return
  *   Contact id only if empty; return all fields if provide ["*"].
  * + [contactOptions] the filter string to apply the query.
  */
  void find(List<String> fields, ContactsSuccessCB success,
            ContactsErrorCB error, ContactsFindOptions contactOptions) {
    js.scoped(() {
      var fs = js.array(fields);
      var s0 = (p) {
        List<Contact> result = new List();
        for(var j = 0; j < p.length; ++j)
          result.add(new Contact.fromProxy(p[j]));
        success(result);
      };
      var e0 = (p) => error(new ContactError.fromProxy(p));
      var opts = js.map(contactOptions._toMap());
      var jsfns = JsUtil.newCallbackOnceGroup('con', [s0, e0], [1, 1]);
      var ok = jsfns[0];
      var fail = jsfns[1];
      _contacts.find(fs, ok, fail, opts);
    });
  }
}



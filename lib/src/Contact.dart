//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Oct 15, 2012  10:26:33 AM
// Author: henrichen

part of rikulo_contacts;

/** onSuccess callback function that returns the Contact */
typedef ContactSuccessCB(Contact contact);
/** onError callback function if fail getting the Contact */
typedef ContactErrorCB(ContactError error);

/**
 * Retrieve device contact list.
 */
class Contact {
  String id; //global unique identifier
  String displayName; //display name of this Contact
  ContactName name; //detail name of this Contact
  String nickname; //casual name of this Contact
  List<ContactField> phoneNumbers; //array of phone numbers of this Contact
  List<ContactField> emails; //array of emails of this Contact
  List<ContactAddress> addresses; //array of address of this Contact
  List<ContactField> ims; //array of im addresses of this Contact
  List<ContactOrganization> organizations; //array of organizations of this Contact
  DateTime birthday; //birthday of this Contact
  String note; //note about this Contact
  List<ContactField> photos; //array of photos of this Contact
  List<ContactField> categories; //array of user defined categories by this Contact
  List<ContactField> urls;//array of web pages associated to this Contact

  js.JsObject _jsObject;

  Contact.fromProxy(js.JsObject p)
      : this._jsObject = p,
        this.id = p['id'],
        this.displayName = p['displayName'],
        this.name = new ContactName.fromProxy(p['name']),
        this.nickname = p['nickname'],
        this.birthday = p['birthday'],
        this.note = p['.note'] {
    this.phoneNumbers = _toFields(p['phoneNumbers']);
    this.emails = _toFields(p['emails']);
    this.addresses = _toAddresses(p['addresses']);
    this.ims = _toFields(p['ims']);
    this.organizations = _toOrganizations(p['organizations']);
    this.photos = _toFields(p['photos']);
    this.categories = _toFields(p['categories']);
    this.urls = _toFields(p['urls']);

    //js.retain(_proxy);
  }

//  void release() {
//    js.scoped(() => js.release(_proxy));
//  }

  /** Returns a cloned Contact object except its id is set to null.
   */
//  Contact clone() => js.scoped(() => new Contact.fromProxy(_proxy.clone()));
  Contact clone() => new Contact.fromProxy(_jsObject.callMethod(js.context['clone']));
  
  /** Remove this Contact from the device's contacts list.
   */
  void remove(ContactSuccessCB success, ContactErrorCB error) {
    //js.scoped(() {
      var s0 = (p) {success(this); /*js.release(_proxy);*/};
      var e0 = (p) => error(new ContactError.fromProxy(p));
      var jsfns = JSUtil.newCallbackOnceGroup("con", [s0, e0], [1, 1]);
      var ok = jsfns[0];
      var fail = jsfns[1];
      _jsObject.callMethod(js.context['remove'], [ok, fail]);
    //});
  }

  /** Saves a new contact to the device contacts list; or updates an existing
   * contact if exists the id.
   */
  void save(ContactSuccessCB success, ContactErrorCB error) {
    //js.scoped(() {
      var old = this.id;
      var s0 = (p) {
        if (old != p.id) //a new Contact
          this.id = p.id;
        if (_jsObject != p) { //a new Proxy
          //js.release(_proxy);
          _jsObject = p;
          //js.retain(p);
        }
        success(this);
      };
      var e0 = (p) => error(new ContactError.fromProxy(p));
      var jsfns = JSUtil.newCallbackOnceGroup("con", [s0, e0], [1, 1]);
      var ok = jsfns[0];
      var fail = jsfns[1];
      _updateProxy();
      _jsObject.callMethod(js.context['save'], [ok, fail]);
    //});
  }

  void _updateProxy() {
    _jsObject['displayName'] = displayName;
    _jsObject['name'] = name == null ? null : name.toProxy();
    _jsObject['nickname'] = nickname;
    _jsObject['birthday'] = birthday;
    _jsObject['note'] = note;
    _jsObject['phoneNumbers'] = js.array(phoneNumbers);
    _jsObject['emails'] = js.array(emails);
    _jsObject['addresses'] = js.array(addresses);
    _jsObject['ims'] = js.array(ims);
    _jsObject['organizations'] = js.array(organizations);
    _jsObject['photos'] = js.array(photos);
    _jsObject['categories'] = js.array(categories);
    _jsObject['urls'] = js.array(urls);
  }

  List<ContactOrganization> _toOrganizations(js.JsObject p) {
    List<ContactOrganization> result = new List();
    for(var j = 0, len = p['length']; j < len; ++j)
      result.add(new ContactOrganization.fromProxy(p[j]));
    return result;

  }

  List<ContactAddress> _toAddresses(js.JsObject p) {
    List<ContactAddress> result = new List();
    for(var j = 0, len = p['length']; j < len; ++j)
      result.add(new ContactAddress.fromProxy(p[j]));
    return result;

  }

  List<ContactField> _toFields(js.JsObject p) {
    List<ContactField> result = new List();
    for(var j = 0, len = p['length']; j < len; ++j)
      result.add(new ContactField.fromProxy(p[j]));
    return result;
  }
}

class ContactAddress {
  /** Set to true if this ContactAddress contains the user's preferred value.*/
  bool pref;
  /** Tells which address this is; e.g. 'home'. */
  String type;
  /** The full address formatted for display. */
  String formatted;
  /** The full street address. */
  String streetAddress;
  /** The city or locality */
  String locality;
  /** The state or region. */
  String region;
  /** The zip code or postal code. */
  String postalCode;
  /** The country or area name */
  String country;

  ContactAddress.fromProxy(js.JsObject p)
      : this.pref = p['pref'],
        this.type = p['type'],
        this.formatted = p['formatted'],
        this.streetAddress = p['streetAddress'],
        this.locality = p['locality'],
        this.region = p['region'],
        this.postalCode = p['postalCode'],
        this.country = p['country'];
}

class ContactName {
  /** The Contact's complete name. */
  String formatted;
  /** The Contact's family name. */
  String familyName;
  /** The Contact's given name. */
  String givenName;
  /** The Contact's middle name. */
  String middleName;
  /** The Contact's prefix; e.g. Mr., Mrs., Miss, or Dr. */
  String honorificPrefix;
  /** The Contact's suffix */
  String honorificSuffix;

  ContactName.fromProxy(js.JsObject p)
      : this.formatted = p['formatted'],
        this.familyName = p['familyName'],
        this.givenName = p['givenName'],
        this.middleName = p['middleName'],
        this.honorificPrefix = p['honorificPrefix'],
        this.honorificSuffix = p['honorificSuffix'];

  js.JsObject toProxy() {
    var p = new js.JsObject(js.context['ContactName']);
    p['formatted'] = formatted;
    p['familyName'] = familyName;
    p['givenName'] = givenName;
    p['middleName'] = middleName;
    p['honorificPrefix'] = honorificPrefix;
    p['honorificSuffix'] = honorificSuffix;
    return p;
  }
}

class ContactOrganization {
  /** Set to true if this ContactOrganization contains the user's preferred value. */
  bool pref;
  /** Tells what type this organization is; e.g. 'home'. */
  String type;
  /** The name of the organization the Contact works for. */
  String name;
  /** The department the Contact works for. */
  String department;
  /** The Contact's title at the organization.*/
  String title;

  ContactOrganization.fromProxy(js.JsObject p)
      : this.pref = p['pref'],
        this.type = p['type'],
        this.name = p['name'],
        this.department = p['department'],
        this.title = p['title'];
}

class ContactField {
  /** Tells what kind of field this is for; e.g. 'email' */
  String type;
  /** The value of the field (such as a phone number or email address). */
  String value;
  /** Set to true if this ContactField contains the user's preferred value. */
  bool pref;

  ContactField.fromProxy(js.JsObject p)
      : this.type = p['type'],
        this.value = p['value'],
        this.pref = p['pref'];
}
part of rikulo_contacts;

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
  
  Contact(ContactName this.name, {String this.displayName, String this.nickname, 
    List<ContactField> this.phoneNumbers, List<ContactField> this.emails,
    List<ContactAddress> this.addresses, List<ContactField> this.ims,
    List<ContactOrganization> this.organizations, DateTime this.birthday,
    String this.note, List<ContactField> this.photos,
    List<ContactField> this.categories, List<ContactField> this.urls, String this.id}) {
  }
  
  factory Contact._fromProxy(js.JsObject p) {
    
    return new Contact(new ContactName._fromProxy(p['name']), id: p['id'], nickname: p['nickname'], 
        displayName: p['displatname'], phoneNumbers: _toFields(p['phoneNumbers']),
        addresses: _toAddresses(p['address']), ims: _toFields(p['ims']),
        organizations: _toOrganizations(p['organizations']), birthday: p['birthday'],
        note: p['note'], photos: _toFields(p['photos']), categories: _toFields(p['categories']),
        urls: _toFields(p['urls'])); 
  }
  
  js.JsObject _toProxy() {
    js.JsObject p = new js.JsObject(js.context['Contact']);
    p['name'] = name._toProxy();
    if (displayName == null)
        p['displayName'] = name.formatted;
    if (id != null);
      p['id'] = id;
    if (nickname != null)
      p['nickname'] = nickname;
    if (birthday != null)
      p['birthday'] = birthday;
    if (note != null)
      p['note'] = note;
    if (phoneNumbers != null)
      p['phoneNumbers'] =_toFieldsProxy(phoneNumbers);
    if (emails != null)
      p['emails'] = _toFieldsProxy(emails);
    if (addresses != null)
      p['addresses'] = _toAddressesProxy(addresses);
    if (ims != null)
      p['ims'] = _toFieldsProxy(ims);
    if (organizations != null)
      p['organizations'] = _toOrganizationsProxy(organizations);
    if (photos != null)
      p['photos'] = _toFieldsProxy(photos);
    if (categories != null)
      p['categories'] = _toFieldsProxy(categories);
    if (urls != null)
      p['urls'] = _toFieldsProxy(urls);
    return p;
  }
  
  /** Remove this Contact from the device's contacts list.
   */
  Future remove() {
    Completer completer = new Completer();
    var e0 = (p) {completer.completeError(new ContactError._fromProxy(p));};
    var s0 = (){};
    _toProxy().callMethod(js.context['remove'], [s0, e0]);
    return completer.future;
  }

  /** Saves a new contact to the device contacts list; or updates an existing
   * contact if exists the id.
   */
  Future<Contact> save() {
    Completer completer = new Completer();
    //var old = this.id;
    var s0 = (p) {
      this.id = p['id'];
      completer.complete(this);
    };
    var e0 = (p) {completer.completeError(new ContactError._fromProxy(p));};
    _toProxy().callMethod(js.context['save'], [e0, s0]);
    return completer.future;
  }
}

class ContactAddress {
  /** Set to true if this ContactAddress contains the user's preferred value.*/
  bool preference;
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

  ContactAddress(bool this.preference, String this.type, String this.formatted,
    String this.streetAddress, String this.locality, String this.region,
    String this.country, String this.postalCode) {}
  
  factory ContactAddress._fromProxy(js.JsObject p) {
    return new ContactAddress(p['preference'], p['type'], p['formatted'],
      p['streetAddress'], p['locality'], p['region'], p['postalCode'], p['country']);
  }
  
  js.JsObject _toProxy() {
    return new js.JsObject(js.context['ContactAddress'], [preference, type, formatted,
                                                          streetAddress, locality,
                                                          region, postalCode, country]);
  }
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

  ContactName(String this.formatted, String this.familyName, String this.givenName,
    String this.middleName, String this.honorificPrefix, String this.honorificSuffix) {}
  
  factory ContactName._fromProxy(js.JsObject p) {
    return new ContactName(p['formatted'], p['familyName'], p['givenName'],
      p['middleName'], p['honorificPrefix'], p['honorificSuffix']);
  }

  js.JsObject _toProxy() {
    return new js.JsObject(js.context['ContactName'], [formatted, familyName, givenName,
                                                       middleName, honorificPrefix,
                                                       honorificSuffix]);
    }
}

class ContactOrganization {
  /** Set to true if this ContactOrganization contains the user's preferred value. */
  bool preference;
  /** Tells what type this organization is; e.g. 'home'. */
  String type;
  /** The name of the organization the Contact works for. */
  String name;
  /** The department the Contact works for. */
  String department;
  /** The Contact's title at the organization.*/
  String title;
  
  ContactOrganization(bool this.preference, String this.type, String this.name,
    String this.department, String this.title) {}
  
  factory ContactOrganization._fromProxy(js.JsObject p) {
    return new ContactOrganization( p['pref'], p['type'], p['name'],
      p['department'],p['title']);
  }
  
  js.JsObject _toProxy() {
    return new js.JsObject(js.context['ContactName'], [preference, type, name, department, title]);
  }
}

class ContactField {
  /** Tells what kind of field this is for; e.g. 'email' */
  String type;
  /** The value of the field (such as a phone number or email address). */
  String value;
  /** Set to true if this ContactField contains the user's preferred value. */
  bool preference;

  ContactField(String this.type, String this.value, bool this.preference) {}
  
  factory ContactField._fromProxy(js.JsObject p) {
    return new ContactField(p['type'], p['value'], p['pref']);
    }
  
  js.JsObject _toProxy() {
    return new js.JsObject(js.context['ContactName'], [preference, type, value]);
  }
}



  List<ContactOrganization> _toOrganizations(js.JsObject p) {
    List<ContactOrganization> result = new List();
    for(var j = 0, len = p['length']; j < len; ++j)
      result.add(new ContactOrganization._fromProxy(p[j]));
    return result;

  }

  List<ContactAddress> _toAddresses(js.JsObject p) {
    List<ContactAddress> result = new List();
    for(var j = 0, len = p['length']; j < len; ++j)
      result.add(new ContactAddress._fromProxy(p[j]));
    return result;

  }

  List<ContactField> _toFields(js.JsObject p) {
    List<ContactField> result = new List();
    for(var j = 0, len = p['length']; j < len; ++j)
      result.add(new ContactField._fromProxy(p[j]));
    return result;
  }
  
  js.JsArray _toOrganizationsProxy(List<ContactOrganization> organs) {
    js.JsArray p = new js.JsArray();
    for(ContactOrganization organ in organs)
      p.add(organ._toProxy());
    return p;
  }

  js.JsArray _toAddressesProxy(List<ContactAddress> addresses) {
      js.JsArray p = new js.JsArray();
      for(ContactAddress address in addresses)
        p.add(address._toProxy());
      return p;
  }

  js.JsArray _toFieldsProxy(List<ContactField> fields) {
    js.JsArray p = new js.JsArray();
    for(ContactField field in fields)
      p.add(field._toProxy());
    return p;
  }
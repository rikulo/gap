part of rikulo_contact;

/** Contains properties that describe a [Contact], such as a user's personal
 *  or business contact.
 */
class Contact {
  /**global unique identifier*/
  String id;
  /**The name of this Contact, suitable for display to end users*/
  String displayName;
  /** An object containing all components of a persons name;parse from displayName; */
  String nickname;
  /** An array of all the contact's phone numbers */
  List<ContactField> phoneNumbers;
  /** An array of all the contact's email addresses */
  List<ContactField> emails;
  /** An array of all the contact's addresses */
  List<ContactAddress> addresses;
  /** An array of all the contact's IM addresses */
  List<ContactField> ims; 
  /** An array of all the contact's organization */
  List<ContactOrganization> organizations;
  /** The birthday of the contact */
  DateTime birthday;
  /**  A note about the contact */
  String note;
  /** An array of the contact's photos */
  List<ContactField> photos;
  /** An array of all the user-defined categories associated with the contact */
  List<ContactField> categories;
  /**  An array of web pages associated with the contact */
  List<ContactField> urls;
  
  Contact(String this.displayName, {String this.nickname, 
    List<ContactField> this.phoneNumbers, List<ContactField> this.emails,
    List<ContactAddress> this.addresses, List<ContactField> this.ims,
    List<ContactOrganization> this.organizations, DateTime this.birthday,
    String this.note, List<ContactField> this.photos,
    List<ContactField> this.categories, List<ContactField> this.urls,
    String this.id});
  
  factory Contact._fromProxy(js.JsObject p)
    => new Contact(p['displayName'], id: p['id'], nickname: p['nickname'], 
        phoneNumbers: _toFields(p['phoneNumbers']), emails: _toFields(p['email']),
        addresses: _toAddresses(p['addresses']), ims: _toFields(p['ims']),
        organizations: _toOrganizations(p['organization']), birthday: p['birthday'],
        note: p['note'], photos: _toFields(p['photos']),
        categories: _toFields(p['categories']), urls: _toFields(p['urls']));
  
  js.JsObject _toProxy() {
    js.JsObject p = new js.JsObject(js.context['Contact']);
    p['displayName'] = displayName;
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
    var ok = (){completer.complete();};
    var fail = (p) {completer.completeError(new ContactError._fromProxy(p));};
    _toProxy().callMethod('remove', [ok, fail]);
    return completer.future;
  }

  /** Saves a new contact to the device contacts list; or updates an existing
   * contact if exists the id.
   */
  Future<ContactName> save() {
    Completer completer = new Completer();
    var ok = (p) {
      this.id = p['id'];
      completer.complete(new ContactName._fromProxy(p['name']));
    };
    var fail = (p) {completer.completeError(new ContactError._fromProxy(p));};
    _toProxy().callMethod('save', [ok, fail]);
    return completer.future;
  }
}

/** Contains address properties for a [Contact] object.
 */
class ContactAddress {
  /** Set to true if this ContactAddress contains the user's preferred value.*/
  bool preference;
  /** Tells which address this is; e.g. 'home'. */
  String type;
  /** The full address formatted for display. */
  String formatted;
  /** The full street address. combine of other argument*/
  String streetAddress;
  /** The city or locality */
  String locality;
  /** The state or region. */
  String region;
  /** The zip code or postal code. */
  String postalCode;
  /** The country or area name */
  String country;

  ContactAddress({bool this.preference: false, String this.type: "", String this.streetAddress: "",
    String this.locality: "", String this.region: "", String this.country: "", String this.postalCode: "",
    String this.formatted});
  
  factory ContactAddress._fromProxy(js.JsObject p)
  => new ContactAddress(preference: p['preference'], type: p['type'], formatted: p['formatted'],
      streetAddress: p['streetAddress'], locality: p['locality'], region: p['region'],
      postalCode: p['postalCode'], country:p['country']);
  
  js.JsObject _toProxy()
  => new js.JsObject(js.context['ContactAddress'], [preference, type, null,
        streetAddress, locality, region, postalCode, country]);
}

/** Contains different kinds of information about a [Contact] object's name.
 * Parsed from from displayName. You can get it by save().
 */
class ContactName {
  /** The Contact's complete name. */
  final String formatted;
  /** The Contact's family name. */
  final String familyName;
  /** The Contact's given name. */
  final String givenName;
  /** The Contact's middle name. */
  final String middleName;
  /** The Contact's prefix; e.g. Mr., Mrs., Miss, or Dr. */
  final String honorificPrefix;
  /** The Contact's suffix */
  final String honorificSuffix;

  ContactName._(String this.formatted, String this.familyName, String this.givenName,
    String this.middleName, String this.honorificPrefix, String this.honorificSuffix);
  
  factory ContactName._fromProxy(js.JsObject p)
  => new ContactName._(p['formatted'], p['familyName'], p['givenName'],
      p['middleName'], p['honorificPrefix'], p['honorificSuffix']);

  js.JsObject _toProxy() {
    return new js.JsObject(js.context['ContactName'], [formatted, familyName, givenName,
                                                       middleName, honorificPrefix,
                                                       honorificSuffix]);
    }
}

/** Contains a [Contact] object's organization properties.
 */
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
  
  ContactOrganization({bool this.preference: false, String this.type: "", String this.name: "",
    String this.department: "", String this.title: ""});
  
  factory ContactOrganization._fromProxy(js.JsObject p)
  => new ContactOrganization(preference: p['pref'], type: p['type'],
      name: p['name'], department: p['department'],title: p['title']);
  
  js.JsObject _toProxy()
  => new js.JsObject(js.context['ContactName'], [preference, type, name, department, title]);
}

/** Supports generic fields in a [Contact] object. Some properties stored as ContactField
 *  objects include email addresses, phone numbers, and URLs.
 */
class ContactField {
  /** Tells what kind of field this is for; e.g. 'email' */
  String type;
  /** The value of the field (such as a phone number or email address). */
  String value;
  /** Set to true if this ContactField contains the user's preferred value. */
  bool preference;

  ContactField(String this.type, String this.value, bool this.preference) {}
  
  factory ContactField._fromProxy(js.JsObject p)
  => new ContactField(p['type'], p['value'], p['pref']);
  
  js.JsObject _toProxy()
  => new js.JsObject(js.context['ContactName'], [preference, type, value]);
}



  List<ContactOrganization> _toOrganizations(js.JsArray p) {
    List<ContactOrganization> result = new List();
    for(var j = 0, len = p.length; j < len; ++j)
      result.add(new ContactOrganization._fromProxy(p[j]));
    return result;

  }

  List<ContactAddress> _toAddresses(js.JsArray p) {
    List<ContactAddress> result = new List();
    for(var j = 0, len = p.length; j < len; ++j)
      result.add(new ContactAddress._fromProxy(p[j]));
    return result;

  }

  List<ContactField> _toFields(js.JsArray p) {
    List<ContactField> result = new List();
    for(var j = 0, len = p.length; j < len; ++j)
      result.add(new ContactField._fromProxy(p[j]));
   print('-----------------------------==F');
    return result;
  }
  
  js.JsArray _toOrganizationsProxy(List<ContactOrganization> organs) {
    js.JsArray p = new js.JsArray();
    for(ContactOrganization organ in organs)
      p.add(organ._toProxy());
    print('-----------------------------==O');
    return p;
  }

  js.JsArray _toAddressesProxy(List<ContactAddress> addresses) {
      js.JsArray p = new js.JsArray();
      for(ContactAddress address in addresses)
        p.add(address._toProxy());
      print('-----------------------------==A');
      return p;
  }

  js.JsArray _toFieldsProxy(List<ContactField> fields) {
    js.JsArray p = new js.JsArray();
    for(ContactField field in fields)
      p.add(field._toProxy());
    return p;
  }
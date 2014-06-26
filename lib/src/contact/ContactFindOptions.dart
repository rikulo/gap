//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, May 14, 2012  02:28:13 PM
// Author: henrichen

part of rikulo_contact;

/** Options used with [Contacts.find] method.*/
class ContactsFindOptions {
  /** The search string used to filter Contacts; default "" */
  final String filter;
  /** Whether return multiple Contacts; default false */
  final bool multiple;

  ContactsFindOptions({this.filter : "", this.multiple : false});

  Map _toMap() => {'filter' : this.filter, 'multiple' : this.multiple};
}
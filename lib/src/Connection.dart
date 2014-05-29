//Copyright (C) 2014 Potix Corporation. All Rights Reserved.
//History: Thu, May 29, 2014  11:31:05 AM
// Author: urchinwang

part of rikulo_connection;

/** Singleton Connection. */
Connection connection = new Connection._internal();

/**
 * Network connection information of this device.
 */
class Connection {
  static const String UNKNOWN = "unknown";
  static const String ETHERNET = "ethernet";
  static const String WIFI = "wifi";
  static const String CELL_2G = "2g";
  static const String CELL_3G = "3g";
  static const String CELL_4G = "4g";
  static const String CELL = "generic";
  static const String NONE =  "none";

  js.JsObject _connection;

  factory Connection() => connection;

  Connection._internal() {
    if (device == null)
      throw new StateError('device is not ready yet.');
      _connection = js.context['navigator']['connection'];
  }

  /** connection type */
  //String get type => js.scoped(() => _connection.type);
  String get type => _connection['type'];
}


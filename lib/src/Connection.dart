//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, May 18, 2012  04:56:12 PM
// Author: henrichen

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
  static const String NONE =  "none";

  js.Proxy _connection;

  factory Connection() => connection;

  Connection._internal() {
    if (device == null)
      throw new RuntimeError('device is not ready yet.');
    js.scoped(() {
      _connection = js.context.navigator.network.connection;
      js.retain(_connection);
    });
  }

  /** connection type */
  String get type => js.scoped(() => _connection.type);
}


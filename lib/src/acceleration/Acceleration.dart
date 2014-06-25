part of rikulo_accelerometer;

/**Contains Accelerometer data captured at a specific point in time.
 * 
 * Acceleration values include the effect of gravity (9.81 m/s^2), 
 * so that when a device lies flat and facing up, x, y, and z values 
 * returned should be 0, 0, and 9.81.
 */ 
class Acceleration {
  final num x;
  final num y;
  final num z;
  final num timestamp;
  
  Acceleration._fromProxy(js.JsObject p)
      : this.x = p['x'],
        this.y = p['y'],
        this.z = p['z'],
        this.timestamp = p['timestamp'];
  
  String toString() => "($timestamp: $x, $y, $z)";
}
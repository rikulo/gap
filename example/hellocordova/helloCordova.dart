import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/accelerometer.dart';
      
//At a regular interval, get the acceleration along the x, y, and z axis.
void accessAccelerometer() {
  accelerometer.watchAcceleration(
    (Acceleration acc) {
      print("t:${acc.timestamp}, x:${acc.x}, y:${acc.y}, z:${acc.z}");
    },
    () => print("Fail to get acceleration."),
    new AccelerometerOptions(frequency: 1000)
  );
}
      
void main() {
  Device.init()
  .then((Device device) {
    accessAccelerometer();
  })
  .catchError((ex, st) {
    print("Failed: $ex, $st");
  });
}

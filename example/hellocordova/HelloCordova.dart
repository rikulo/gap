import 'package:rikulo_ui/view.dart';
import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/accelerometer.dart';

showAcceleration() {
  //prepare a text view to show the acceleration information
  TextView welcome = new TextView("Hello Accelerometer!");
  welcome.profile.text = "anchor:  parent; location: center center";
  new View()..addToDocument()
            ..addChild(welcome);

  //watch accelerometer and show the acceleration in x, y and z axis.
  accelerometer.watchAcceleration(
    (accel) {
      welcome.text = "${accel.timestamp},\n"
                   "x:${accel.x},\n"
                   "y:${accel.y},\n"
                   "z:${accel.z}";
      welcome.requestLayout(true); },
    () => print("Fail to get acceleration"),
    new AccelerometerOptions(frequency:1000)
  );
}

void main() {
  //enable the device
  Future<Device> enable = enableDeviceAccess();

  //when device is enabled and ready
  enable.then((device) => showAcceleration());

  //if failed to enable the device and/or timeout!
  enable.handleException((ex) {
    print("Fail to enable the device.");
    return true;
  });
}


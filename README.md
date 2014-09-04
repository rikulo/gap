#Rikulo Gap

[Rikulo Gap](http://rikulo.org) is a bridge implementation of the [Apache Cordova](http://incubator.apache.org/cordova/) mobile framework (a.k.a. PhoneGap) in Dart. It enables developers to access native facilities of multiple mobile platforms using the HTML, CSS, and Dart.
 
* [Home](http://rikulo.org)
* [Documentation](http://docs.rikulo.org/ui/latest/Rikulo_Gap/)
* [API Reference](http://www.dartdocs.org/documentation/rikulo_gap/0.6.0)
* [Discussion](http://stackoverflow.com/questions/tagged/rikulo)
* [Issues](https://github.com/rikulo/gap/issues)

Rikulo Gap is distributed under the Apache 2.0 License.

##Install from Dart Pub Repository

Add this to your `pubspec.yaml` (or create it):

    dependencies:
      rikulo_gap: ">=0.6.0 <0.7.0"

##Usage

Everything start from enabling your device accessiblity:

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

For more information, please refer to [Building Native Mobile Application](http://docs.rikulo.org/ui/latest/Getting_Started/Building_Native_Mobile_Application.html).

##Install from Github for Bleeding Edge Stuff

To install stuff that is still in development, add this to your `pubspec.yam`:

    dependencies:
      rikulo_gap:
        git: git://github.com/rikulo/gap.git

For more information, please refer to [Pub: Dependencies](http://pub.dartlang.org/doc/pubspec.html#dependencies).

###Fork Rikulo Gap

If you'd like to contribute back to the core, you can [fork this repository](https://help.github.com/articles/fork-a-repo) and send us a pull request, when it is ready.

Please be aware that one of Rikulo's design goals is to keep the sphere of API as neat and consistency as possible. Strong enhancement always demands greater consensus.

If you are new to Git or GitHub, please read [this guide](https://help.github.com/) first.

##Who Uses

* [Quire](https://quire.io) - a simple, collaborative, multi-level task management tool.

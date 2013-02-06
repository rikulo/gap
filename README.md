#Rikulo Gap

[Rikulo Gap](http://rikulo.org) is a bridge implementation of the [Apache Cordova](http://incubator.apache.org/cordova/) mobile framework (a.k.a. PhoneGap) in Dart. It enables developers to access native facilities of multiple mobile platforms using the HTML, CSS, and Dart.
 
* [Home](http://rikulo.org)
* [Documentation](http://docs.rikulo.org/ui/latest/Rikulo_Gap/)
* [API Reference](http://api.rikulo.org/gap/latest)
* [Discussion](http://stackoverflow.com/questions/tagged/rikulo)
* [Issues](https://github.com/rikulo/gap/issues)

Rikulo Gap is distributed under the Apache 2.0 License.

##Install from Dart Pub Repository

Add this to your `pubspec.yaml` (or create it):

    dependencies:
      rikulo_gap:

Then run the [Pub Package Manager](http://pub.dartlang.org/doc) (comes with the Dart SDK):

    pub install

##Install from Github for Bleeding Edge Stuff

To install stuff that is still in development, add this to your `pubspec.yam`:

    dependencies:
      rikulo_gap:
        git: git://github.com/rikulo/gap.git

For more information, please refer to [Pub: Dependencies](http://pub.dartlang.org/doc/pubspec.html#dependencies).

##Usage

Everything start from enabling your device accessiblity:

    import 'package:rikulo_gap/device.dart';

    void main() {
        //enable the device
    	Future<Device> enable = enableDeviceAccess(); 

        //when the device is enabled and ready
    	enable.then((device) {
     		...
    	});

        //if failed to enable the device and/or timeout
    	enable.handleException((ex) {
    		...
        });
    }

For more information, please refer to [Building Native Mobile Application](http://docs.rikulo.org/ui/latest/Getting_Started/Building_Native_Mobile_Application.html).

##Mobile Facilities	  
* device
* accelerometer
* camera
* capture
* compass
* connection
* contacts
* geolocation
* notification

##Notes to Contributors

###Create Addons

Rikulo is easy to extend. The simplest way to enhance Rikulo is to [create a new repository](https://help.github.com/articles/create-a-repo) and add your own great widgets and libraries to it.

###Fork Rikulo Gap

If you'd like to contribute back to the core, you can [fork this repository](https://help.github.com/articles/fork-a-repo) and send us a pull request, when it is ready.

Please be aware that one of Rikulo's design goals is to keep the sphere of API as neat and consistency as possible. Strong enhancement always demands greater consensus.

If you are new to Git or GitHub, please read [this guide](https://help.github.com/) first.

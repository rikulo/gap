#Rikulo Gap

[Rikulo Gap](http://rikulo.org) is a bridge implementation in Dart language of the [Apache Cordova](http://incubator.apache.org/cordova/) mobile framework(a.k.a. PhoneGap) which enables developers to access native facilities of multiple mobile platforms using the HTML, CSS, and Dart.
 
* [Home](http://rikulo.org)
* [Documentation](http://docs.rikulo.org)
* [API Reference](http://api.rikulo.org/rikulo-gap/latest/)
* [Discussion](http://stackoverflow.com/questions/tagged/rikulo)
* [Issues](https://github.com/rikulo/rikulo-gap/issues)

Rikulo Gap is distributed under the Apache 2.0 License.

##Installation

Add this to your `pubspec.yaml` (or create it):

    dependencies:
      rikulo_gap: any

Then run the [Pub Package Manager](http://www.dartlang.org/docs/pub-package-manager/) (comes with the Dart SDK):

    pub install

For more information, please refer to [Rikulo: Getting Started](http://docs.rikulo.org/rikulo/latest/Getting_Started/) and [Pub: Getting Started](http://www.dartlang.org/docs/pub-package-manager/).

##Usage

Everything start from enabling your device accessiblity:

    import 'package:rikulo_gap/gap.dart';

    void main() {
    	Future<Device> future = enableDeviceAccess(); //enable the device accessibility
    	future.then((device) {
			//device is ready
     		...
    	});
    	future.handleException((ex) {
    		//Time out! Failed to enable the device.
    		...
        	return true;
        });
    }

For more information, please refer to [Building Native Mobile Application](http://docs.rikulo.org/rikulo/latest/Getting_Started/Building_Native_Mobile_Application.html).

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

##History
* Oct. 16, 2012: alpha version
 * Refactor 'device' out from Rikulo main trunk.
 * Make it run with Dart's official js-interop package and independent to Rikulo's code.

##Notes to Contributors

###Create Addons

Rikulo is easy to extend. The simplest way to enhance Rikulo is to [create a new repository](https://help.github.com/articles/create-a-repo) and add your own great widgets and libraries to it.

###Fork Rikulo

If you'd like to contribute back to the core, you can [fork this repository](https://help.github.com/articles/fork-a-repo) and send us a pull request, when it is ready.

Please be aware that one of Rikulo's design goals is to keep the sphere of API as neat and consistency as possible. Strong enhancement always demands greater consensus.

If you are new to Git or GitHub, please read [this guide](https://help.github.com/) first.

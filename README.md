#Rikulo Gap

[Rikulo Gap](http://rikulo.org) is a bridge implementation in Dart language of the [Apache Cordova](http://incubator.apache.org/cordova/) mobile framework(a.k.a. PhoneGap) which enables developers to access native facilities of multiple mobile platforms using the HTML, CSS, and Dart.
 
Rikulo Gap is distributed under the Apache 2.0 License.

* [Home](http://rikulo.org)
* [Documentation](http://docs.rikulo.org)
* [API Reference](http://api.rikulo.org)
* [Discussion](http://stackoverflow.com/questions/tagged/rikulo)
* [Issues](https://github.com/rikulo/rikulo-gap/issues)

##Pub Package
    import 'package:rikulo_gap/gap.dart';

##pubspec.yaml
    name: ...
	...
	dependencies:
	  rikulo_gap:

##Mobile Facilities	  
* Device
* Accelerometer
* Camera
* Capture
* Compass
* Connection
* Contacts
* Geolocation
* Notification

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

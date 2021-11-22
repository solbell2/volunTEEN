# Metrohacks Hackaton: 11/21/21 - Volunteering App at Metrohacks
By: Michael Liu, Eshan Singhal, Kelsey Sun, Angela Yang </br>
[Devpost Metrohacks Site](https://devpost.com/software/volunteen-7s5nmj)

<h6> Resources<br />
- [App Showcase -  YouTube](https://youtu.be/icZ8hjPbFew)<br />
- [Final Source Code - GitHub](https://github.com/kelseyxsun/volunTEEN)<br />
- [Volunteen Documentation](https://github.com/kelseyxsun/volunTEEN/blob/master/README.md)<br/>

  <h5> Developers
  Younger than 18 years old (< 18): </br>
- [Michael Liu (Freshman)](https://devpost.com/bearr) <br />
- [Kelsey Sun (Junior)](https://devpost.com/kelseysun13) <br />
- [Eshan Singhal (Junior)](https://devpost.com/eshansinghal05) <br />
- [Angela Yang (Sophmore)](https://devpost.com/angelayang297) <br />

### Stable Execution:
To execute the project, download the code on the main master branch and unzip the folder. Open Android Studio -> File -> Open, and find the extracted folder (This should have an Android logo on the file). Make sure to have Dart SDK and any Flutter comilation plugins/SDKs required to run the project (Prefered versions: Flutter v2.2.1 and Dart 2.13.1). Ensure that full Flutter and Dart support is available on your machine and Android Studio (Android Studio Plugin Installation: File -> Settings -> Editor -> Plugins -> Marketplace -> Flutter -> Install). Additional support and any potential issues are discussed below.

Dart and Flutter Support: Dart support must be enabled on the project. To do this, install Dart support by installing Flutter located on the Flutter site and installing the Flutter plugin on Android Studio. The SDK should be in .zip located in the ../bin. Once everything is setup, you should be prompted by a blue overlay to enable Dart support unless it is already enabled. From there, a 'pub.get has not been run' message might appear. From there just ignore the message and debug on an emulator as the required pub dependencies will installed automatically on compilation. To preview the code, please locate the code specifications and dependency installations below. 

If the application crashed on startup and the error is due to something related to geological.dart, please allow locational access to the application when prompted to or change it in settings and go to the emulator settings and set a location (Three Dots -> Location -> Select Your Point on map -> Set Location). From there, close out of the app and rerun. (Do not rebuild/recompile as the location will be wiped. Just exit the app and press the icon again on the emulator)

Any unexpected erros may occur due to emulator discongruency or depreciated imports. (Emulators used in debugging are sdkgphone x86 arm (mobile) and Android Emulator Pixel 3a API 30 x86) Please use the ones discribed below and their specific versions. This should be imported directly by default on compilation of the app. Additional information about dependencies located below. 

### Code Specifications:
Flutter project location is under libs. This holds all of the code we created. 
```file
../volunTEEN/lib/
```

Additional Dependencies Located in pubspec.yaml.
```yaml
name: hackathon_11_21_21
description: Volunteering app made at Metro Hacks

environment:
  sdk: ">=2.12.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
    
  cupertino_icons: ^1.0.2
  shared_preferences: ^2.0.7
  date_format: ^2.0.4
  google_maps_flutter: ^2.0.9
  geolocator: ^7.7.1
  geocoding: ^2.0.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  firebase_core:
  firebase_auth:
  cloud_firestore:
  firebase_storage:
  
flutter:
  uses-material-design: true

```

### Additional Resources:

This project is a Flutter application that allows a community to create local volunteering options, both online and virtually, and gives students the ability to sign up for them. Organizers have the ability to verify a student's presence, view attendees, and perform various admin powers. Login and signup handled under a Firebase Authentication system and all additinal objects stored under a Firebase Database system. 

A few resources for Flutter Documentation: 
- [Flutter Documentation Getting Started](https://flutter.dev/docs/get-started/codelab)
- [Flutter Sample Cookbook](https://flutter.dev/docs/cookbook)
- [Flutter Installation Stable (2.2.1)](https://docs.flutter.dev/development/tools/sdk/releases)

Official Flutter Documentation,
[online documentation](https://flutter.dev/docs), offers tutorials,
samples, guidance on mobile development, and a full API reference.

Compiler and Emulator used: [Android Studio](https://developer.android.com/studio)

Firebase (Directly redirects to volunTEEN console which might be private. Direct access to the volunTEEN Firebase is not required): [Firebase](https://console.firebase.google.com/u/0/project/volunteen-d14f0/overview)

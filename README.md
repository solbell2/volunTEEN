# Metrohacks Hackaton: 11/21/21 - Volunteering App at Metrohacks
By: Michael Liu, Eshan Singhal, Kelsey Sun, Angela Yang </br>
[Devpost Metrohacks Site](https://devpost.com/software/volunteen-7s5nmj)


### Execution
To execute the project, download the code on the main master branch and unzip the folder. Open Android Studio -> File -> Open, and find the extracted folder (This should have an Android logo on the file). Make sure to have Dart SDK and any Flutter comilation plugins/SDKs required to run the project (Prefered versions: Flutter v2.2.1 and Dart 2.13.1). To preview the code, please locate the code specifications and dependency installations below. 


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

## Flutter Resources

This project is a Flutter application that allows a community to create local volunteering options, both online and virtually, and gives students the ability to sign up for them. Organizers have the ability to verify a student's presence, view attendees, and perform various admin powers. Login and signup handled under a Firebase Authentication system and all additinal objects stored under a Firebase Database system. 

A few resources for Flutter Documentation: 
- [Flutter Documentation Getting Started](https://flutter.dev/docs/get-started/codelab)
- [Flutter Sample Cookbook](https://flutter.dev/docs/cookbook)

Official Flutter Documentation,
[online documentation](https://flutter.dev/docs), offers tutorials,
samples, guidance on mobile development, and a full API reference.

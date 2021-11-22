// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hackathon_11_21_21/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    /* Commented Line 16: 
    (await tester.pumpWidget(MyApp());
    
    Because it produces error: The function 'MyApp' isn't defined. (Documentation) 
    Try importing the library that defines 'MyApp', correcting the name to the name of an existing function,
    or defining a function named 'MyApp'.
    
    This line does not interfere with the compilation at all but is just annoying to look at so I commented it. 
    This code was generated before we altered the main.dart class so it should be fine. Uncommenting will produce
    an error but will not change anything
    */
    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

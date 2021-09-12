// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:interview_link_list/main.dart';

void main() {

  testWidgets('complete test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    //await tester.pumpWidget(MyApp());
    tester.allWidgets.forEach((element) =>print(element));
    //expect(find.text('# javascript'), findsOneWidget);
    //search click
    //expect(find.byIcon(Icons.search_outlined),findsOneWidget);
    //await tester.tap(find.byIcon(Icons.search_outlined));
    //expect(find.byIcon(Icons.close),findsOneWidget);
    //expect(find.byIcon(Icons.search_outlined),findsNothing);
  });

}

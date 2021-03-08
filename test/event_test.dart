// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_project/main.dart';
import 'package:mobile_project/models/event.dart';
import 'package:mobile_project/provider/events.dart';

void main() {
  group('App provider tests', () {
    var events = Events();
    test('A new item should be added', () {
      var data = Event(
        id: '1',
        eventName: 'helllo',
        address: 'korba',
        date: '2-2-2222',
        image: 'www.google.com',
        dresscode: 'classic',
        limitAttending: 30,
        minimumCharge: 90,
      );
      events.addEvent(data, "hjghghjghghjbhj");
      expect(events.eventDB.contains(data), true);
    });
  });
}

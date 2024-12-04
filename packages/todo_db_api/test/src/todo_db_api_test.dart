// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_db_api/todo_db_api.dart';

void main() {
  group('TodoDbApi', () {
    test('can be instantiated', () {
      expect(TodoDbApi(), isNotNull);
    });
  });
}

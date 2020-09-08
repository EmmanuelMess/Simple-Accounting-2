// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_accounting_2/db/dao/account_row_dao.dart';
import 'package:simple_accounting_2/db/dao/month_dao.dart';
import 'package:simple_accounting_2/db/database.dart';

import 'package:simple_accounting_2/main.dart';

void main() {
  AppDatabase database;
  AccountRowDao accountRowDao;
  MonthDao monthDao;

  setUp(() async {
    database = await $FloorAppDatabase
        .inMemoryDatabaseBuilder()
        .build();
    accountRowDao = database.accountRowDao;
    monthDao = database.monthDao;
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(SimpleAccounting2App(accountRowDao, monthDao));

    //TODO add tests
  });
}

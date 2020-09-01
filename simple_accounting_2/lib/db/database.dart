import 'dart:async';
import 'package:floor/floor.dart';
import 'package:simple_accounting_2/db/dao/month_dao.dart';
import 'package:simple_accounting_2/db/entity/month.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/account_row_dao.dart';
import 'entity/account_row.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [AccountRow, Month])
abstract class AppDatabase extends FloorDatabase {
  AccountRowDao get accountRowDao;
  MonthDao get monthDao;
}
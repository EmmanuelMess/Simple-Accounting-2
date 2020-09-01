import 'package:floor/floor.dart';
import 'package:simple_accounting_2/db/entity/month.dart';

@dao
abstract class MonthDao {
  @update
  Future<void> updateMonth(Month accountRow);

  @delete
  Future<void> deleteMonthById(Month accountRow);

  @insert
  Future<void> insertMonth(Month accountRow);

  @Query('SELECT * FROM Month ORDER BY Month.month ASC')
  Stream<List<Month>> findAllMonthsAsStream();
}
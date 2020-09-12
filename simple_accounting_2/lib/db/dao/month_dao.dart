import 'package:floor/floor.dart';
import 'package:simple_accounting_2/db/entity/month.dart';

@dao
abstract class MonthDao {
  @update
  Future<void> updateMonth(Month accountRow);

  @delete
  Future<void> deleteMonthById(Month accountRow);

  @insert
  Future<int> insertMonth(Month accountRow);

  @Query('SELECT * FROM Month WHERE (month = :month AND year = :year AND currency = :currency)')
  Future<Month> findMonth(String month, String year, String currency);

  @Query('SELECT * FROM Month ORDER BY Month.month ASC')
  Stream<List<Month>> findAllMonthsAsStream();
}
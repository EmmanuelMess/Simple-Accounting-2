import 'package:floor/floor.dart';
import 'package:simple_accounting_2/db/dao/month_dao.dart';
import 'package:simple_accounting_2/db/entity/account_row.dart';
import 'package:simple_accounting_2/db/entity/month.dart';
import 'package:simple_accounting_2/logic/decimal_conversion.dart';

@dao
abstract class AccountRowDao {
  @update
  Future<void> updateAccountRow(AccountRow accountRow);

  @delete
  Future<void> deleteAccountRowById(AccountRow accountRow);

  @insert
  Future<void> insertAccountRow(AccountRow accountRow);

  @transaction
  Future<void> insertGeneratedAccountRow(MonthDao monthDao, DateTime date,
      String reference, String credit, String debit, String currency) async {
    final id = null;
    final lastPosition = await findMaxPosition();
    final position = lastPosition + 1;
    final possibleMonth = await monthDao.findMonth(date.month.toString(), date.year.toString(), currency);
    final monthId = possibleMonth == null ? await monthDao.insertMonth(Month(null, date.month, date.year, currency, DecimalConversion.zero)) : possibleMonth;
    insertAccountRow(AccountRow(
      id, position, date.day.toString(), reference, credit, debit, monthId, currency
    ));
  }

  @Query('SELECT * FROM AccountRow ORDER BY AccountRow.position ASC')
  Stream<List<AccountRow>> findAllAccountRowsAsStream();

  @Query('SELECT MAX(position) FROM AccountRow')
  Future<int> findMaxPosition();
}
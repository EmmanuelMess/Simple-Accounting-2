import 'package:floor/floor.dart';
import 'package:simple_accounting_2/db/entity/account_row.dart';

@dao
abstract class AccountRowDao {
  @update
  Future<void> updateAccountRow(AccountRow accountRow);

  @delete
  Future<void> deleteAccountRowById(AccountRow accountRow);

  @insert
  Future<void> insertAccountRow(AccountRow accountRow);//TODO update month for row

  @Query('SELECT * FROM AccountRow ORDER BY AccountRow.position ASC')
  Stream<List<AccountRow>> findAllAccountRowsAsStream();
}
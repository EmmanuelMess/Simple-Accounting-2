import 'package:floor/floor.dart';
import 'package:simple_accounting_2/db/entity/month.dart';

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['month_id'],
      parentColumns: ['id'],
      entity: Month,
    )
  ],
)
class AccountRow {
  @primaryKey
  final int id;

  final int position;

  final String date;

  final String reference;

  final String credit;
  final String debit;

  @ColumnInfo(name: 'month_id')
  final int monthId;

  final String currency;

  AccountRow(this.id, this.position, this.date, this.reference, this.credit, this.debit, this.monthId, this.currency);
}
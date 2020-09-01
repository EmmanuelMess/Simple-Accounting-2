import 'package:floor/floor.dart';

@entity
class Month {
  @primaryKey
  final int id;

  final int month;
  final int year;

  final String currency;

  final String balance;

  Month(this.id, this.month, this.year, this.currency, this.balance);
}
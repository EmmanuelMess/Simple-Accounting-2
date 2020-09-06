import 'package:decimal/decimal.dart';

class DecimalConversion {
  const DecimalConversion._();

  String sanitize(String number) {
    return Decimal.parse(number).toStringAsPrecision(3);
  }

  bool check(String number) {
    return Decimal.tryParse(number) != null;
  }


}
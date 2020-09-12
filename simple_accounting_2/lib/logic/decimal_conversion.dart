import 'package:decimal/decimal.dart';

class DecimalConversion {
  const DecimalConversion._();

  static final zero = sanitize('0');

  static String sanitize(String number) {
    return Decimal.parse(number).toStringAsPrecision(3);
  }

  static bool check(String number) {
    return Decimal.tryParse(number) != null;
  }
}
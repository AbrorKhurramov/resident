import 'package:intl/intl.dart';

extension InvoiceExtension on String {
  bool isOpen() {
    return toLowerCase() == 'open' ? true : false;
  }
}

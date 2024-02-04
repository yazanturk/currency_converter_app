import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    print('DateTimeExtension: ${DateFormat('yyyy-MM-dd').format(this)}');
    return DateFormat('yyyy-MM-dd').format(this);
  }
}

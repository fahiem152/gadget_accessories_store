import 'package:intl/intl.dart';

class Formatter {
  static formatRupiah(int value) {
    final formatter = NumberFormat('#,###', 'id_ID');
    return 'Rp. ${formatter.format(value)}';
  }

  static String formatWaktu(DateTime waktu) {
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(waktu);
  }

  static String formatWaktuAndClock(DateTime waktu) {
    final formatter = DateFormat('dd MMMM yyyy HH:mm:ss');
    return formatter.format(waktu);
  }
}

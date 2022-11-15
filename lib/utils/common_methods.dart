import 'package:intl/intl.dart';

class CommonMethods {
  String getOnlyDate({required String? date}) {
    if (date == '') {
      return '';
    }

    //"2022-11-01T20:45:13Z"
    DateTime startDateTemp =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date ?? '');

    return DateFormat('dd MMM yyyy').format(startDateTemp);
  }

  String getFormatedDate({required String? date}) {
    if (date == "") {
      return "";
    }

    DateTime startDateTemp =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date ?? '');

    String timediff = DateFormat('hh:mm a').format(startDateTemp).toLowerCase();

    print('$timediff in time');
    final dateNow = DateTime.now();
    final difference = dateNow.difference(startDateTemp);
    if ((difference.inDays / 7).floor() >= 1) {
      return DateFormat('dd MMM yyyy hh:mm a')
          .format(startDateTemp)
          .toLowerCase();
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago $timediff';
    } else if (difference.inDays >= 1) {
      return 'yestarday $timediff';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago $timediff';
    } else if (difference.inHours >= 1) {
      return 'an hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return 'a minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'just now';
    }

    // String? dateValue =
    //     DateFormat('dd MMM yyyy hh:mm a').format(startDateTemp).toLowerCase();
  }
}

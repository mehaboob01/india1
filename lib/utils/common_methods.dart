import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

class CommonMethods {
  String getDateFormat(String dateTime) {
    /// 2022-11-30T06:43:09.894264Z
    String shortDateTime = '${dateTime.substring(0, 19)}Z';
    return shortDateTime;
  }

  String textMask(String value) {
    if (value.length <= 4) {
      return value;
    }
    String startValue = value.substring(0, (value.length - 4));
    String endValue = value.substring(value.length - 4, value.length);
    final regex = RegExp(r'[0-9]');
    String maskedValue = startValue.replaceAll(regex, 'X');
    return maskedValue + endValue;
  }

  String getOnlyDate({required String? date}) {
    if (date == '') {
      return '';
    }

    //"2022-11-01T20:45:13Z"
    DateTime startDateTemp =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(getDateFormat(date ?? ''));

    return DateFormat('dd MMM yyyy').format(startDateTemp);
  }

  String getFormatedDate({required String? date}) {
    if (date == "") {
      return "";
    }

    DateTime startDateTemp =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(getDateFormat(date ?? ''));

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

  String indianRupeeValue(double value) {
    int toInt = value.round();
    final rupeeFormat = NumberFormat.currency(
        locale: 'en_IN', name: '', symbol: '', decimalDigits: 0);
    String data = rupeeFormat.format(toInt).trim();

    return data;
  }

  String accountFormattedText(String value) {
    if (value == '') {
      return '';
    }
    String val = value.trim();
    final maskedRegex = RegExp(r'^(?:\D*\d){1,3}$');

    String data = maskedRegex.stringMatch(val).toString();
    return data;
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String value = newValue.text.replaceAll(',', '');

    String? newText = value.length < 2
        ? value
        : CommonMethods().indianRupeeValue(double.parse(value));

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class MaskedInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String newVal = newValue.text;
    String? newText = newValue.text.length < 4
        ? newValue.text
        : CommonMethods().accountFormattedText(newVal);
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

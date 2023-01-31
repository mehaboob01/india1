import 'package:get/get.dart';

class CommonValidations {
  String? textValidation(
      {bool? isIfsc,
      String? value,
      String? nullError,
      String? invalidInputError}) {
    final validCharacters = isIfsc == true
        ? RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$')
        : RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
    if (value!.isEmpty) {
      return nullError ?? 'Input field cant be Empty';
    } else if (!validCharacters.hasMatch(value)) {
      return invalidInputError ?? 'Invalid Input value';
    }
    return null;
  }

// email validation

// general validation

// number validation

  String? numberValidation({
    String? value,
    String? nullError,
    String? invalidInputError,
    String? minLengthError,
    num minValLength = 0,
  }) {
    final validCharacters = RegExp(r'^([0-9]*)$');
    if (value!.isEmpty) {
      return nullError ?? 'Input field cant be Empty';
    } else if (value.length < minValLength) {
      return minLengthError ?? "Invalid Input value";
    } else if (!validCharacters.hasMatch(value)) {
      return invalidInputError ?? 'Invalid Input value';
    }

    return null;
  }

  String? maxAmountLengthValidate(
      {String? value,
      String? maxErrorText,
      String? minErrorText,
      String? nullErrorText,
      required int maxValue,
      required int minValue}) {
    if (value != '') {
      double newValue = double.parse(value!.replaceAll(',', ''));

      print(newValue);
      if (newValue > maxValue) {
        return maxErrorText ?? 'Value should be lesser than $maxValue';
      } else if (newValue < minValue) {
        return minErrorText ?? 'Value should be more than $minValue';
      } else {
        return null;
      }
    } else {
      return nullErrorText ?? 'Loan value is mandatory*';
    }
  }
}

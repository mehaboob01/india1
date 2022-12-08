class CommonValidations {
  String? textValidation(
      String? value, String? nullError, String? invalidInputError) {
    final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
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

  String? numberValidation(
      String? value, String? nullError, String? invalidInputError) {
    final validCharacters = RegExp(r'^(0|[1-9][0-9]*)$');
    if (value!.isEmpty) {
      return nullError ?? 'Input field cant be Empty';
    } else if (!validCharacters.hasMatch(value)) {
      return invalidInputError ?? 'Invalid Input value';
    }
    return null;
  }

  String? maxAmountLengthValidate(
      {String? value,
      String? maxErrorText,
      String? minErrorText,
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
      return 'Loan value is mandatory*';
    }
  }
}

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
  String? numberValidation({
      String? value, String? nullError, String? invalidInputError, int? minValue, String? minValueError}) {
    final validCharacters = RegExp(r'^(0|[1-9][0-9]*)$');
    if (value!.isEmpty) {
      return nullError ?? 'Input field cant be Empty';
    } else if (!validCharacters.hasMatch(value)) {
      return invalidInputError ?? 'Invalid Input value';
    } else if(value.length < minValue!){
      return minValueError ?? 'Minimum character length is $minValue';
    }
    return null;
  }
}
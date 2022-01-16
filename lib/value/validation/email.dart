import '../stream_value_with_validation.dart';

Validator<String> validateEmail({
  String emptyMsgKey = "empty",
  String invalidMsgKey = "invalid",
}) {
  var emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return (String? val) {
    if (val == null || val.isEmpty) {
      return ValidationResult(messageKey: emptyMsgKey);
    }
    else {
      if (!emailRegex.hasMatch(val)) {
        return ValidationResult(messageKey: invalidMsgKey);
      }
      return const ValidationResult(isValid: true);
    }
  };
}

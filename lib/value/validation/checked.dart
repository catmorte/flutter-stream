import '../stream_value_with_validation.dart';

Validator<bool> validateBinary(bool validValue, {
  String invalidMsgKey = "invalid"
}) {
  return (bool? val) {
    if (val == null || validValue != val) {
      return ValidationResult(messageKey: invalidMsgKey);
    }
    return const ValidationResult(isValid: true);
  };
}

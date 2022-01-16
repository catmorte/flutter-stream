import '../stream_value_with_validation.dart';

Validator<String> validateNotEmpty({
  String emptyMsgKey = "empty"
}) {
  return (String? val) {
    if (val == null || val.isEmpty) {
      return ValidationResult(messageKey: emptyMsgKey);
    }
    return const ValidationResult(isValid: true);
  };
}

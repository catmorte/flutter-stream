import '../stream_value_with_validation.dart';

Validator<String> validateInBetween(from, to, {
  String emptyMsgKey = "empty",
  String ltMsgKey = "need_more",
  String gtMsgKey = "need_less",
}) {
  return (String? val) {
    if (val == null || val.isEmpty) {
      return ValidationResult(messageKey: emptyMsgKey);
    } else {
      var length = val.length;
      if (length < from) {
        return ValidationResult(messageKey: ltMsgKey);
      } else if (length > to) {
        return ValidationResult(messageKey: gtMsgKey);
      }
    }
    return const ValidationResult(isValid: true);
  };
}

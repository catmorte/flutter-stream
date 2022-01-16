import 'package:stream/value/stream_value.dart';

class ValidationResult {
  final bool isValid;
  final String messageKey;

  const ValidationResult({this.isValid = false, this.messageKey = ""});
}

typedef Validator<T> = ValidationResult Function(T? val);

class StreamValueWithValidation<T> extends StreamValue<T?> {
  final List<Validator<T?>> _validators;
  ValidationResult _validationResult = const ValidationResult(isValid: true);

  StreamValueWithValidation(this._validators, {T? value}) : super(value);

  @override
  postJobBeforeUpdate() {
    if (_validators.isEmpty) return;
    for (var i = 0; i < _validators.length; i++) {
      _validationResult = _validators[i](value);
      if (!_validationResult.isValid) {
        return;
      }
    }
  }

  ValidationResult get validationResult => _validationResult;

  setValidationResult(ValidationResult newValidationResult) {
    _validationResult = newValidationResult;
    notify();
  }
}

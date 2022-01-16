import 'package:flutter_test/flutter_test.dart';
import 'package:stream/stream_holder.dart';
import 'package:stream/value/stream_value.dart';
import 'package:stream/value/stream_value_with_validation.dart';
import 'package:stream/value/validation/checked.dart';
import 'package:stream/value/validation/email.dart';
import 'package:stream/value/validation/in_between.dart';
import 'package:stream/value/validation/not_empty.dart';

class X with StreamHolder<String> {}

void main() {
  test('holder', () async {
    var sh = X();
    var future = sh.on.first;
    sh.notify(value: "triggered");
    expect(await future, "triggered");
  });

  test('value', () async {
    var sh = StreamValue("");
    var future = sh.on.first;
    sh.setValue("triggered");
    expect(await future, "triggered");
    expect(sh.value, "triggered");
  });

  test('value with validation empty', () async {
    var sh = StreamValueWithValidation<String>([]);
    var future = sh.on.first;
    sh.setValue("triggered");
    expect(await future, "triggered");
    expect(sh.value, "triggered");
    expect(sh.validationResult.isValid, true);
  });

  test('value with validation not empty valid', () async {
    var sh = StreamValueWithValidation<String>([validateNotEmpty(emptyMsgKey: "empty")]);
    var future = sh.on.first;
    sh.setValue("triggered");
    expect(await future, "triggered");
    expect(sh.value, "triggered");
    expect(sh.validationResult.isValid, true);
  });


  test('value with validation not empty empty', () async {
    var sh = StreamValueWithValidation<String>([validateNotEmpty(emptyMsgKey: "empty")]);
    var future = sh.on.first;
    sh.setValue("");
    expect(await future, "");
    expect(sh.value, "");
    expect(sh.validationResult.isValid, false);
    expect(sh.validationResult.messageKey, "empty");
  });

  test('value with validation in between valid', () async {
    var sh = StreamValueWithValidation<String>([validateInBetween(3, 7, emptyMsgKey: "empty", gtMsgKey: "too_much", ltMsgKey: "not_enough")]);
    var future = sh.on.first;
    sh.setValue("test");
    expect(await future, "test");
    expect(sh.value, "test");
    expect(sh.validationResult.isValid, true);
  });


  test('value with validation in between empty', () async {
    var sh = StreamValueWithValidation<String>([validateInBetween(3, 7, emptyMsgKey: "empty", gtMsgKey: "too_much", ltMsgKey: "not_enough")]);
    var future = sh.on.first;
    sh.setValue("");
    expect(await future, "");
    expect(sh.value, "");
    expect(sh.validationResult.isValid, false);
    expect(sh.validationResult.messageKey, "empty");
  });


  test('value with validation in between less', () async {
    var sh = StreamValueWithValidation<String>([validateInBetween(3, 7, emptyMsgKey: "empty", gtMsgKey: "too_much", ltMsgKey: "not_enough")]);
    var future = sh.on.first;
    sh.setValue("t");
    expect(await future, "t");
    expect(sh.value, "t");
    expect(sh.validationResult.isValid, false);
    expect(sh.validationResult.messageKey, "not_enough");
  });


  test('value with validation in between more', () async {
    var sh = StreamValueWithValidation<String>([validateInBetween(3, 7, emptyMsgKey: "empty", gtMsgKey: "too_much", ltMsgKey: "not_enough")]);
    var future = sh.on.first;
    sh.setValue("very long text");
    expect(await future, "very long text");
    expect(sh.value, "very long text");
    expect(sh.validationResult.isValid, false);
    expect(sh.validationResult.messageKey, "too_much");
  });

  test('value with validation email valid', () async {
    var sh = StreamValueWithValidation<String>([validateEmail(emptyMsgKey: "empty", invalidMsgKey: "invalid")]);
    var future = sh.on.first;
    sh.setValue("test@test.test");
    expect(await future, "test@test.test");
    expect(sh.value, "test@test.test");
    expect(sh.validationResult.isValid, true);
  });

  test('value with validation email empty', () async {
    var sh = StreamValueWithValidation<String>([validateEmail(emptyMsgKey: "empty", invalidMsgKey: "invalid")]);
    var future = sh.on.first;
    sh.setValue("");
    expect(await future, "");
    expect(sh.value, "");
    expect(sh.validationResult.isValid, false);
    expect(sh.validationResult.messageKey, "empty");
  });

  test('value with validation email invalid', () async {
    var sh = StreamValueWithValidation<String>([validateEmail(emptyMsgKey: "empty", invalidMsgKey: "invalid")]);
    var future = sh.on.first;
    sh.setValue("test@");
    expect(await future, "test@");
    expect(sh.value, "test@");
    expect(sh.validationResult.isValid, false);
    expect(sh.validationResult.messageKey, "invalid");
  });


  test('value with validation checked true valid', () async {
    var sh = StreamValueWithValidation<bool>([validateBinary(true, invalidMsgKey: "invalid")]);
    var future = sh.on.first;
    sh.setValue(true);
    expect(await future, true);
    expect(sh.value, true);
    expect(sh.validationResult.isValid, true);
  });


  test('value with validation checked false valid', () async {
    var sh = StreamValueWithValidation<bool>([validateBinary(false, invalidMsgKey: "invalid")]);
    var future = sh.on.first;
    sh.setValue(false);
    expect(await future, false);
    expect(sh.value, false);
    expect(sh.validationResult.isValid, true);
  });


  test('value with validation checked true invalid', () async {
    var sh = StreamValueWithValidation<bool>([validateBinary(false, invalidMsgKey: "invalid")]);
    var future = sh.on.first;
    sh.setValue(true);
    expect(await future, true);
    expect(sh.value, true);
    expect(sh.validationResult.isValid, false);
  });


  test('value with validation checked false invalid', () async {
    var sh = StreamValueWithValidation<bool>([validateBinary(true, invalidMsgKey: "invalid")]);
    var future = sh.on.first;
    sh.setValue(false);
    expect(await future, false);
    expect(sh.value, false);
    expect(sh.validationResult.isValid, false);
  });
}

import 'package:formz/formz.dart';

enum WeightValidationError { empty, negative, zero, text, short, invalid }

class Weight extends FormzInput<String, WeightValidationError> {
  const Weight.pure() : super.pure(' ');
  const Weight.dirty([super.value = '']) : super.dirty();

  @override
  WeightValidationError? validator(String value) {
    if (value.isEmpty) return WeightValidationError.empty;
    if (value.startsWith('0')) return WeightValidationError.zero;
    if (value.startsWith('-')) return WeightValidationError.negative;
    if (value.contains(RegExp(r'[a-zA-Z]'))) {
      return WeightValidationError.invalid;
    }
    return null;
  }
}

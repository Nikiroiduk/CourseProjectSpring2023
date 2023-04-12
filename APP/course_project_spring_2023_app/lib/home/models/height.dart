import 'package:formz/formz.dart';

enum HeightValidationError { empty, negative, zero, text, short, invalid }

class Height extends FormzInput<String, HeightValidationError> {
  const Height.pure() : super.pure(' ');
  const Height.dirty([super.value = '']) : super.dirty();

  @override
  HeightValidationError? validator(String value) {
    if (value.isEmpty) return HeightValidationError.empty;
    if (value.startsWith('0')) return HeightValidationError.zero;
    if (value.startsWith('-')) return HeightValidationError.negative;
    if (value.contains(RegExp(r'[a-zA-Z]')))
      return HeightValidationError.invalid;
    return null;
  }
}

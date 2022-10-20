import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

// var maskFormatter = new MaskTextInputFormatter(
//   mask: '+# (###) ###-##-##',
//   filter: { "#": RegExp(r'[0-9]') },
//   type: MaskAutoCompletionType.lazy
// );

class PorcentajeMaskFormatter extends MaskTextInputFormatter {
  PorcentajeMaskFormatter()
      : super(
            mask: '##.##%',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.eager);
}

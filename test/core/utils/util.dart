import 'package:flutter_test/flutter_test.dart';
import 'package:loadfile_baustro/core/utils/util.dart';

main() {
  group('Validacion de metodos de cedula', () {
    test('RUC VALIDO NATURAL 001', () {
      expect(validateCedula('0750017899001')['validate'], equals(true));
    });
    test('RUC VALIDO NATURAL 002', () {
      expect(validateCedula('0750017899002')['validate'], equals(true));
    });
    test('RUC VALIDO NATURAL 002', () {
      expect(validateCedula('0750017899002')['validate'], equals(true));
    });
    test('RUC VALIDO NATURAL 003', () {
      expect(validateCedula('0750017899003')['validate'], equals(true));
    });
    test('RUC VALIDO NATURAL 004', () {
      expect(validateCedula('0750017899004')['validate'], equals(true));
    });
    test('RUC VALIDO NATURAL 005', () {
      expect(validateCedula('0750017899005')['validate'], equals(true));
    });
    test('RUC VALIDO NATURAL 006', () {
      expect(validateCedula('0750017899006')['validate'], equals(true));
    });
    test('RUC VALIDO NATURAL 009', () {
      expect(validateCedula('0750017899009')['validate'], equals(true));
    });
    test('VALIDACION DE CEDULA', () {
      expect(validateCedula('0750017899')['validate'], equals(true));
    });
    test('VALIDACION DE CEDULA ERRONEA', () {
      expect(validateCedula('0750017898')['validate'], equals(false));
    });
  });
}

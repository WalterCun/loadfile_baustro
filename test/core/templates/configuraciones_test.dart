import 'package:flutter_test/flutter_test.dart';
import 'package:loadfile_baustro/core/templates/configuraciones.dart';

void main() {
  group('PRUEBAS DE GENERACION DE PLANTILLAS DE TEXTO', () {
    test('Generacion de template String', () {
      cltHDR.variables = {
        'nameShop': 'Test1',
        'direction': 'Test 2 y Test 3',
        'phone': '0993216547',
        'city': 'CUENCA',
        'ruc': '08564912530120'
      };

      expect(cltHDR.build(), contains('Test1'));
      expect(cltHDR.build(), contains('Test 2 y Test 3'));
      expect(cltHDR.build(), contains('0993216547'));
      expect(cltHDR.build(), contains('CUENCA'));
      expect(cltHDR.build(), contains('08564912530120'));
      });
  });
}

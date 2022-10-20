
import 'package:loadfile_baustro/core/structs/resources.dart';
import 'package:test/test.dart';

main(){
  group('Generador de clases para Recursos', ()
  {

    test('Clase Generica de obtension de metadata', () {
        final img = Imagen(path: 'assets/img/logo.png');

        expect(img.tree, equals('assets/img/'));
        expect(img.filename, equals('logo.png'));
        expect(img.ext, equals('png'));
    });

    test('Clase Generica de obtencion de metadata, Generacion de Error', () {
      final img = Imagen(path: 'prueba/de/dominio/test');

      expect(img.tree, equals('prueba/de/dominio/'));
      expect(img.filename, equals('test'));
      expect(img.ext, equals(null));
    });

  }
  );
}
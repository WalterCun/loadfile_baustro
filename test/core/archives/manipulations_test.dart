import 'package:loadfile_baustro/core/archives/manipulations.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

void main() {
  late String comercio;
  late String arbol;
  late String archivo;

  group('Manipulations the archives', () {
    setUpAll(() {
      comercio = 'Test 1';
      arbol = 'austro/icons/';
      archivo = 'test.doc';
    });

    test('Creacion de Fichero', () {
      createFile(
        pathFilename: join(comercio, arbol, archivo),
      ).then((resp) {
        expect(resp, true);
      });
    });

    test('Escribir contenido de Fichero', () {
      writeFile(pathFilename: join(comercio, arbol, archivo),
          content: '''prueba de ejecucion
          
          
test1''');
    });
  });
}

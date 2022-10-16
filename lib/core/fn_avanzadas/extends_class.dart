
import 'dart:developer';

/// Extension de metodo para la clase Map<String, bool> que retornar un valor
/// true o false al momento de realizar la validacion [eval] en el cual
/// todos los valores que contiene el Map deben ser iguales para [true] caso
/// contrario retorna un false
extension MapExtensions on Map<String, bool> {
  bool any({dynamic eval = true}) {
    for (var element in values) {
      if (element != eval) {
        log('any: false');
        return false;
      }
    }
    log('any: true');
    return true;
  }
}

extension ListExtensions on List<Map> {
  List<String> extractValuesFromMaps({required String key}) {
    final List<String> list = [];

    forEach((item) {
      list.add(item[key]);
    });

    return list;
  }
}

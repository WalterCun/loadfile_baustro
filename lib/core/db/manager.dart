class CLTIAD {
  /// Activar o descativar la Opcion
  bool active;
  int typeProcess;
  int typeValue;
  int base;
  int value;

  CLTIAD({
    this.active = false,
    required this.typeProcess,
    required this.typeValue,
    required this.base,
    required this.value,
  }) {
    assert(typeProcess >= 1 && typeProcess <= 3,
        'Error value typeProcces, validate is values 1:Ingreso Manual; 2: Calculado y cargado al valor base 3: Calculado y descargad oal valor base');
    assert(typeValue >= 1 && typeValue <= 2,
        'Error value typeValue, validate is values 1: Tasa porcentual; 2: Valor Fijo');
    assert(base >= 0 && base <= 2,
        'Error value base, validate is values 0: Monto 12; 1: Subtotal; 2: Monto 0');
  }
}

class DataProvider {
  static final DataProvider _singlenton = DataProvider._internal();
  factory DataProvider() => _singlenton;
  DataProvider._internal();

  String? pathOutput;

  String? nameShop;
  String? codeShop;
  String? serie;

  String? direction;
  String? phone;
  String? city;
  String? ruc;

  String? pathLogo;

  int conIVA0 = 1;

  final iva = CLTIAD(
    active: true,
    typeProcess: 3,
    typeValue: 1,
    base: 0,
    value: 1200,
  );

  final propina = CLTIAD(
    typeProcess: 1,
    typeValue: 2,
    base: 0,
    value: 0,
    // format: 'IAD1="2PROPINA:,1,2,0,000*"'
  );

  final servicio = CLTIAD(
    typeProcess: 1,
    typeValue: 2,
    base: 0,
    value: 0,
    // format: 'IAD2="3SERVICIO:,3,2,0,010*"'
  );

  final interes = CLTIAD(
    typeProcess: 1,
    typeValue: 1,
    base: 1,
    value: -1,
    // format:'IAD3="4INTERES,1,1,1,*"'
  );

  final montofijo = CLTIAD(
    typeProcess: 2,
    typeValue: 2,
    base: 1,
    value: 22,
    // format: 'IAD4="5MONTOFJ:,2,2,1,022*"'
  );

  List<String> listAdvertising = [];
}

//recursos: https://pub.dev/packages/format/example
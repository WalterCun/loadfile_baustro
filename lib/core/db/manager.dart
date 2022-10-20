enum Calculo {
  cargado,
  desglosado,
}

class CLTIAD {
  bool active;
  Calculo? valor;
  int? valor1;
  int? valor2;
  int? valor3;
  int? value;
  String format;

  CLTIAD(
      {this.active = false,
      this.valor,
      this.valor1,
      this.valor2,
      this.value,
      this.valor3,
      this.format = ''});
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

  final iva = CLTIAD(
      value: 1200,
    // format: 'IAD0="1IVA:,3,1,0,1200*"'
    format: '{active}IAD0="1IVA:,3,1,0,{value:4d}*"'
  );

  final propina = CLTIAD(
    value: 0,
    // format: 'IAD1="2PROPINA:,1,2,0,000*"'
    format: '{active}IAD1="2PROPINA:,1,2,0,{value:3d}*"'
  );

  final servicio = CLTIAD(
    value: 10,
    // format: 'IAD2="3SERVICIO:,3,2,0,010*"'
    format: '{active}IAD2="3SERVICIO:,3,2,0,{value:3d}*"'
  );

  final interes = CLTIAD(
    value: -1,
    // format:'IAD3="4INTERES,1,1,1,*"'
    format:'{active}IAD3="4INTERES,1,1,1,*"'
  );

  final montofijo = CLTIAD(
    value: 22,
    // format: 'IAD4="5MONTOFJ:,2,2,1,022*"'
    format: '{active}IAD4="5MONTOFJ:,2,2,1,{value:3d}*"'
  );

  List<String> listAdvertising = [];
}

//recursos: https://pub.dev/packages/format/example
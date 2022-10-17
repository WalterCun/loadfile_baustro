import 'package:objectbox/objectbox.dart';

import 'history.dart';

@Entity()
class Shop{
  @Id()
  int id = 0;

  String? codigo;
  String? giro;

  String? name;
  String? direction;
  String? phone;

  final history = ToOne<History>();
}

@Entity()
class ConfShops{
  @Id()
  int id = 0;

  bool fixedAmount = false; // monto Fijo
  bool tip = false; // propina
  bool service = false; // servicio
}

@Entity()
class Configure{}
import 'package:objectbox/objectbox.dart';

/// ***************************************************************************
@Entity()
class Shop {
  @Id()
  int id = 0;

  String? codigo;
  String? giro;

  String? name;
  String? direction;
  String? phone;

  // final history = ToOne<History>();
  // final confshop = ToOne<ConfShops>();
}

@Entity()
class ConfShops {
  @Id()
  int id = 0;

  bool fixedAmount = false; // monto Fijo
  bool tip = false; // propina
  bool service = false; // servicioç

  // final shop = ToMany<Shop>();
}

@Entity()
class Configure {
  @Id()
  int id = 0;
}

/// ***************************************************************************


@Entity()
class Config {
  Config({this.id = 0, this.parameter, this.value});

  @Id()
  int id = 0;

  @Index(type: IndexType.value)
  String? parameter;

  String? value;
}

/// ***************************************************************************

@Entity()
class Device {
  @Id()
  int id = 0;

  String? serie;

  // final history = ToOne<History>();
}

/// ***************************************************************************

@Entity()
class History {
  @Id()
  int id = 0;

  // @Backlink("history")
  // final shop = ToMany<Shop>();

  // @Backlink("history")
  // final device = ToMany<Device>();
}

/// ***************************************************************************

@Entity()
class Variables {
  @Id()
  int id = 0;
}

// class Templates {}

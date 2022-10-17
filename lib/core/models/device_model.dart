import 'package:objectbox/objectbox.dart';

import 'history.dart';

@Entity()
class Device{
  @Id()
  int id = 0;

  String? serie;

  final history = ToOne<History>();
}
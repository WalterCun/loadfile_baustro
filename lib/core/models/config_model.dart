import 'package:objectbox/objectbox.dart';

@Entity()
class Config {
  Config({this.id = 0, this.parameter, this.value});

  @Id()
  int id = 0;

  @Index(type: IndexType.value)
  String? parameter;

  String? value;
}

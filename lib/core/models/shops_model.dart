import 'package:objectbox/objectbox.dart';

@Entity()
class Shop{
  @Id()
  int id = 0;

  String? name;
  String? direction;
  String? phone;
}

import 'package:objectbox/objectbox.dart';

@Entity()
class Device{
  @Id()
  int id = 0;

  String? serie;
}
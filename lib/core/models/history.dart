import '../../objectbox.g.dart';
import 'device_model.dart';
import 'shops_model.dart';

@Entity()
class History{
  @Id()
  int id = 0;


  @Backlink("history")
  final shop = ToMany<Shop>();

  @Backlink("history")
  final device = ToMany<Device>();

}
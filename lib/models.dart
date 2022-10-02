import 'package:objectbox/objectbox.dart';

@Entity()
class Item {
  @Id()
  int article;
  String name;
  int quantity;

  Item({this.article = 0, required this.name, required this.quantity});
}

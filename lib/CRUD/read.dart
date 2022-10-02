import '../generated/objectbox.g.dart';
import '../models.dart';

void readItemElements(Store store) {
  final boxItem = store.box<Item>();
  final query = (boxItem.query(Item_.article.notEquals(0))).build();
  final results = query.find();
  query.close();
  if (results.isEmpty) {
    print('Нет элементов в БД');
  } else {
    for (var element in results) {
      print(
          'article - ${element.article}, name - ${element.name}, quantity - ${element.quantity}');
    }
  }
}

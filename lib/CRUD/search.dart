import 'dart:io';

import '../generated/objectbox.g.dart';
import '../models.dart';

void searchItemElement(Store store) {
  final boxItem = store.box<Item>();
  stdout.write('Введите name: ');
  final name = stdin.readLineSync()!;
  final query = (boxItem.query(Item_.name.equals(name))).build();
  final results = query.find();
  if (results.isEmpty) {
    print('Нет соответствующих элементов в БД');
  } else {
    for (var element in results) {
      print(
          'article - ${element.article}, name - ${element.name}, quantity - ${element.quantity}');
    }
  }
}

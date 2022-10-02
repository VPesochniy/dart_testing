import 'dart:io';

import '../generated/objectbox.g.dart';
import '../models.dart';

void createItemElement(Store store) {
  int? quantity;
  final boxItem = store.box<Item>();
  stdout.write('Введите название: ');
  final name = stdin.readLineSync()!;
  while (quantity == null || quantity <= 0) {
    stdout.write('Введите количество: ');
    final text = stdin.readLineSync()!;
    quantity = int.tryParse(text);
    if (quantity == null || quantity <= 0) {
      print('Ошибка ввода. Повторите попытку');
    } else {
      final item = Item(name: name, quantity: quantity);
      boxItem.put(item);
      print('Элемент ${item.name} успешно добавлен');
    }
  }
}

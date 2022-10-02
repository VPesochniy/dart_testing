import 'dart:io';

import '../generated/objectbox.g.dart';
import '../models.dart';

void updateItemElement(Store store) {
  int? article;
  int? quantity;
  final boxItem = store.box<Item>();
  while (article == null || article <= 0 || boxItem.get(article) == null) {
    stdout.write('Введите article: ');
    final text = stdin.readLineSync()!;
    article = int.tryParse(text);
    if (article == null || article <= 0 ) {
      print('Ошибка ввода. Повторите попытку');
    } else if (boxItem.get(article) == null) {
      print('Данного article не существует. Повторите попытку');
    }else {
      stdout.write('Введите название: ');
      final name = stdin.readLineSync()!;
      while (quantity == null || quantity <= 0) {
        stdout.write('Введите количество: ');
        final text = stdin.readLineSync()!;
        quantity = int.tryParse(text);
        if (quantity == null || quantity <= 0) {
          print('Ошибка ввода. Повторите попытку');
        } else {
          final item = Item(article: article, name: name, quantity: quantity);
          boxItem.put(item);
          print('Элемент ${item.name} успешно изменен');
        }
      }
    }
  }
}

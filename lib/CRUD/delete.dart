import 'dart:io';

import '../generated/objectbox.g.dart';
import '../models.dart';

void deleteAllItemElement(Store store) {
  final boxItem = store.box<Item>();
  boxItem.removeAll();
  print('Удалены все элементы БД');
}

void deleteItemElement(Store store) {
  int? article;
  final boxItem = store.box<Item>();
  while (article == null || article <= 0) {
    stdout.write('Введите article: ');
    final text = stdin.readLineSync()!;
    article = int.tryParse(text);
    if (article == null || article <= 0) {
      print('Ошибка ввода. Повторите попытку');
    } else {
      final query = (boxItem.query(Item_.article.equals(article))).build();
      final results = query.remove();
      if (results == 0) {
        print('Нет соответствующих элементов в БД');
      } else {
        boxItem.remove(article);
        print('Удален элемент под номером $article');
      }
      query.close();
    }
  }
}

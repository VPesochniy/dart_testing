import 'dart:isolate';

import 'CRUD/create.dart';
import 'CRUD/search.dart';
import 'CRUD/delete.dart';
import 'CRUD/read.dart';
import 'CRUD/update.dart';

import 'Dart:io';
import 'generated/objectbox.g.dart';

Future<void> main() async {
  print(Isolate.current.debugName);
  String? choice;
  while (true){
    print('\nИз какого изолята работаем?');
    print('1. createIsolate');
    print('2. optionalIsolate');
    print('0. Выход');
    choice = stdin.readLineSync();
    switch (choice) {
      case '1':
        await optionalIsolate();
        break;
      case '2':
        await createIsolate();
        break;
      case '0':
        exit(0);
      default:
        print('Такой опции нет в меню. Попробуйте еще раз');
    }
  }
}

Future<void> optionalIsolate() async {
  final receivePort = ReceivePort();
  await Isolate.spawn(workingWithDB, receivePort.sendPort);
  return await receivePort.first;
}

void optionalFunction(SendPort port) {
  print(Isolate.current.debugName);
  final receivePort = port;
  Isolate.exit(receivePort);
}

Future<void> createIsolate() async {
  final receivePort = ReceivePort();
  await Isolate.spawn(workingWithDB, receivePort.sendPort);
  return await receivePort.first;
}

void workingWithDB(SendPort port) {
  print(Isolate.current.debugName);
  final responsePort = port;
  final store = openStore();
  while (true) {
    print('\nПривет, это пробный CRUD, что ты хочешь сделать?');
    print('1. Просмотреть БД');
    print('2. Добавить элемент в БД');
    print('3. Изменить элемент БД');
    print('4. Удалить элемент БД');
    print('5. Поиск по фильтру');
    print('0. Вернуться к изолятам');
    String? choice = stdin.readLineSync();
    switch (choice) {
      case '1':
        readItemElements(store);
        break;
      case '2':
        createItemElement(store);
        break;
      case '3':
        updateItemElement(store);
        break;
      case '4':
        print('1. Удалить все элементы БД');
        print('2. Удалить выбранный элемент в БД');
        print('0. Вернуться к меню');
        String? deleteChoice = stdin.readLineSync();
        switch (deleteChoice) {
          case '1':
            deleteAllItemElement(store);
            break;
          case '2':
            deleteItemElement(store);
            break;
          case '0':
            break;
        }
        break;
      case '5':
        searchItemElement(store);
        break;
      case '0':
        store.close();
        Isolate.exit(responsePort);
      default:
        print('Такой опции нет в меню. Попробуйте еще раз');
    }
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reward_calculator/constant/client_name.dart';
import 'package:reward_calculator/model/reward_model.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _list = <Todo>[];
  List<Todo> get getList => _list;

  addItem(Todo todo) async {
    var box = Hive.box<Todo>(HiveBoxes.todo);
    box.add(todo);
    log('added');
    notifyListeners();
  }

  getItem() async {
    final box = Hive.box<Todo>(HiveBoxes.todo);
    _list = box.values.toList();
    log('all data fetched');
    //notifyListeners();
  }

  updateItem(int index, Todo todo) async {
    final box = Hive.box<Todo>(HiveBoxes.todo);
    box.putAt(index, todo);
    log('updated');
    notifyListeners();
  }

  deleteItem(int index) {
    final box = Hive.box<Todo>(HiveBoxes.todo);
    box.deleteAt(index);
    log('deleted');
    getItem();
    notifyListeners();
  }

  deleteAll(List<Todo> todo) {
    final box = Hive.box<Todo>(HiveBoxes.todo);
    box.clear();
    _list.clear();
    log('delete all');
    notifyListeners();
  }

  searchItem(String todo) {
    final box = Hive.box<Todo>(HiveBoxes.todo);
    var t = box.values.where((item) {
      return (item.amount!.contains(todo) ||
          item.phonNumber!.contains(todo) ||
          item.rewardPoint!.contains(todo));
    }).toList();
    _list.clear();
    _list.addAll(t);
    notifyListeners();
  }

  void clearText(TextEditingController todo) {
    todo.clear();
    log('clear');
    getItem();
    notifyListeners();
  }
}

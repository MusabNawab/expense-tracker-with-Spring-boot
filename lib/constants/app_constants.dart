import 'package:dio/dio.dart';
import 'package:expense_tracker/data/models/expense.dart';
import 'package:expense_tracker/data/models/users.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data/models/categories.dart';

class AppConstants {
  static final appColor = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
  static final darkAppColor = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 129, 71, 230));
  static snackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  static final dio = Dio();

  static late Box<Expense> expenseBox;
  static late Box<Users> usersBox;
  static late Users user;

  static List<Expense> expenses = [];

  static void deserializeExpenses(List expenses) {
    AppConstants.expenses = expenses.map((e) {
      return Expense(
          id: e["id"],
          title: e["title"],
          amount: double.parse(e["amt"].toString()),
          dt: DateTime.parse(e["date"]),
          //todo
          ct: fromString(e['category']));
    }).toList();
  }
}

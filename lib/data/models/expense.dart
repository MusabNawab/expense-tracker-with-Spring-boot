// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'categories.dart';

part 'expense.g.dart';

final categoryIcons = {
  Categories.food: Icons.dining_rounded,
  Categories.travel: Icons.flight,
  Categories.entertainment: Icons.movie,
  Categories.health: Icons.favorite,
  Categories.others: Icons.more_horiz_rounded
};

@HiveType(typeId: 2)
class Expense extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime dt;
  @HiveField(4)
  final Categories ct;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.dt,
    required this.ct,
  });

  @override
  String toString() {
    return 'Expense(id: $id, title: $title, amount: $amount, dt: $dt, ct: $ct)';
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpense, this.category)
      : expenses =
            allExpense.where((expense) => expense.ct == category).toList();

  final Categories category;
  List<Expense> expenses;

  double get total {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}

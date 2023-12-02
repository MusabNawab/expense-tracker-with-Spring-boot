import 'models/expense.dart';

class DataAnalyticsData {
  final int year;
  List<Expense> expenses;

  DataAnalyticsData({required this.year, required this.expenses});

  double get totalamt {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}

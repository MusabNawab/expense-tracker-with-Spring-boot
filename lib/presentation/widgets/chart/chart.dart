import 'package:flutter/material.dart';

import '../../../data/models/categories.dart';
import '../../../data/models/expense.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Categories.food),
      ExpenseBucket.forCategory(expenses, Categories.entertainment),
      ExpenseBucket.forCategory(expenses, Categories.travel),
      ExpenseBucket.forCategory(expenses, Categories.health),
      ExpenseBucket.forCategory(expenses, Categories.others),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.total > maxTotalExpense) {
        maxTotalExpense = bucket.total;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: width <= 600 ? 250 : height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: buckets.map((bucket) {
                if (bucket.total == 0) {
                  return const ChartBar(fill: 0);
                } else {
                  return ChartBar(fill: bucket.total / maxTotalExpense);
                }
              }).toList(),

              // alternative to map()
              //[
              //   for (final bucket in buckets)
              //     ChartBar(
              //       fill:
              //           bucket.total == 0 ? 0 : bucket.total / maxTotalExpense,
              //     )
              // ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}

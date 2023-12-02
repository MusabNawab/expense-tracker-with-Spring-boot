import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../data/models/expense.dart';

class ExpensesList extends StatefulWidget {
  final List<Expense> expenses;
  final Function removeItem;
  final GlobalKey<AnimatedListState> listKey;
  const ExpensesList(
      {super.key,
      required this.expenses,
      required this.removeItem,
      required this.listKey});

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateformat = DateFormat.yMMMMEEEEd();
    return AnimatedList(
        initialItemCount: widget.expenses.length,
        key: widget.listKey,
        itemBuilder: (context, index, animation) {
          return SlideTransition(
            position: Tween(
                    begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                .animate(CurvedAnimation(
                    parent: animation, curve: Curves.easeInOut)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Slidable(
                key: ValueKey(widget.expenses[index].id),
                endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    dismissible: DismissiblePane(onDismissed: () {
                      widget.removeItem(index);
                    }),
                    children: [
                      SlidableAction(
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          onPressed: (_) {
                            widget.removeItem(index);
                          })
                    ]),
                child: SlideTransition(
                  position: Tween(
                          begin: const Offset(0.0, kIsWeb ? 1.0 : 0.7),
                          end: const Offset(0.0, 0.0))
                      .animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut)),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(categoryIcons[widget.expenses[index].ct]),
                      title: Text(
                        widget.expenses[index].title,
                        style: const TextStyle(overflow: TextOverflow.fade),
                      ),
                      subtitle: Text(
                        dateformat.format(widget.expenses[index].dt).toString(),
                      ),
                      trailing: Chip(
                        label: Text(
                            '₹ ${widget.expenses[index].amount.toStringAsFixed(2)}'),
                        //backgroundColor: Colors.deepPurple.shade400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

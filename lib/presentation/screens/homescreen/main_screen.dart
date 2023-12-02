import 'package:expense_tracker/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import '../../../data/data_analytics.dart';
import '../../../data/models/expense.dart';
import '../../../data/models/categories.dart';
import '../../widgets/chart/chart.dart';
import '../../widgets/drawer.dart';
import '../../widgets/expenses_list.dart';
import '../../widgets/input_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final _expenses = AppConstants.expenses;
  final box = AppConstants.expenseBox;
  final List<DataAnalyticsData> analyticalData = [];
  final _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    final List<Expense> data = box.values.toList();
    if (data.isEmpty) {
      // _expenses = dummyData;
    } else {
      _expenses.addAll(data);
      _expenses.sort((a, b) {
        if (a.dt.year > b.dt.year) {
          return 0;
        }
        return 1;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    analyticalData.clear();
    for (var i = 0; i < _expenses.length; i++) {
      analyticalData.add(DataAnalyticsData(
          year: i,
          expenses: _expenses
              .where((expense) => expense.dt.year == (DateTime.now().year - i))
              .toList()));
    }
    analyticalData.removeWhere((element) => element.expenses.isEmpty);
  }

  void _showInputField() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: kIsWeb ? false : true,
        context: context,
        builder: (ctx) => InputField(addFun: addExpense));
  }

  void addExpense(Expense expense) async {
    // box.put(expense.id, expense);
    // setState(() {
    //   _expenses.insert(0, expense);
    // });
    final response = await AppConstants.dio.post(
        "http://10.0.2.2:8080/expense-tracker/expense/${AppConstants.user.uid}",
        data: {
          "title": expense.title,
          "amt": expense.amount,
          "date": expense.dt.toString(),
          "category": toString(expense.ct),
        });
    if (_listKey.currentState == null) {
      return;
    } else {
      _listKey.currentState!
          .insertItem(0, duration: const Duration(seconds: 1));
    }
    didChangeDependencies();
  }

  void _removeExpense(int index) async {
    final tempItem = _expenses.elementAt(index);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(
          '${tempItem.title} was removed',
        ),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            setState(
              () {
                addExpense(tempItem);
              },
            );
          },
        ),
      ),
    );
    setState(() {
      AppConstants.dio.delete(
          "http://10.0.2.2:8080/expense-tracker/expense/${tempItem.id}");
    });
    _listKey.currentState!.removeItem(
        index,
        (context, animation) => SlideTransition(
            key: UniqueKey(),
            position: Tween(
                    begin: const Offset(1.0, 0.0), end: const Offset(2.0, 0.0))
                .animate(
                    CurvedAnimation(parent: animation, curve: Curves.ease)),
            child: const Card(
              color: Colors.red,
              child: ListTile(
                title: Text('Deleted'),
              ),
            )),
        duration: const Duration(milliseconds: 300));
    didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(onPressed: _showInputField, icon: const Icon(Icons.add))
        ],
      ),
      drawer: CustomDrawer(analyticalData: analyticalData),
      body: _expenses.isEmpty
          ? Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  LottieBuilder.asset(
                    'assets/img/no_data.json',
                    width: kIsWeb ? 500 : 300,
                  ),
                  Text(
                    'Press \'+\' button to add new expenses',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize: 17),
                  ),
                ],
              ),
            )
          : width < 600
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Chart(expenses: _expenses),
                    Expanded(
                      child: ExpensesList(
                        expenses: _expenses,
                        removeItem: _removeExpense,
                        listKey: _listKey,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: Chart(expenses: _expenses)),
                    Expanded(
                      child: ExpensesList(
                        expenses: _expenses,
                        removeItem: _removeExpense,
                        listKey: _listKey,
                      ),
                    ),
                  ],
                ),
    );
  }
}

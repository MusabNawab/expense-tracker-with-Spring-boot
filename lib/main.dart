import 'package:dio/dio.dart';
import 'package:expense_tracker/constants/app_constants.dart';
import 'package:expense_tracker/data/models/users.dart';
import 'package:expense_tracker/presentation/screens/loginscreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'data/models/categories.dart';
import 'data/models/expense.dart';
import 'presentation/screens/homescreen/main_screen.dart';

late bool _loggedIn;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(UsersAdapter());
  AppConstants.expenseBox = await Hive.openBox<Expense>('expenseBox');
  AppConstants.usersBox = await Hive.openBox<Users>('usersBox');
  _loggedIn = AppConstants.usersBox.isEmpty;
  if (!_loggedIn) {
    AppConstants.user = AppConstants.usersBox.values.first;
    final response = await AppConstants.dio.get(
        "http://10.0.2.2:8080/expense-tracker/expense/userExpense/${AppConstants.user.uid}");
    final List expenses = response.data;

    AppConstants.deserializeExpenses(expenses);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: AppConstants.darkAppColor,
        useMaterial3: true,
        chipTheme: const ChipThemeData().copyWith(
            backgroundColor: AppConstants.darkAppColor.inversePrimary,
            elevation: 2),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.appColor.onPrimaryContainer,
              elevation: 2),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: AppConstants.appColor,
        useMaterial3: true,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: AppConstants.appColor.inversePrimary,
          foregroundColor: AppConstants.appColor.inverseSurface,
        ),
        chipTheme: const ChipThemeData().copyWith(
            backgroundColor: AppConstants.appColor.inversePrimary,
            elevation: 2),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.appColor.primaryContainer,
              elevation: 2),
        ),
      ),
      home: _loggedIn ? const LoginScreen() : const HomeScreen(),
    );
  }
}

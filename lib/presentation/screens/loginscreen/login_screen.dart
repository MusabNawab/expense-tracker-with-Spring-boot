import 'package:dio/dio.dart';
import 'package:expense_tracker/constants/app_constants.dart';
import 'package:expense_tracker/data/models/users.dart';
import 'package:expense_tracker/presentation/screens/homescreen/main_screen.dart';
import 'package:expense_tracker/presentation/screens/loginscreen/widgets/login_form.dart';
import 'package:expense_tracker/presentation/screens/loginscreen/widgets/signup_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool auth;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();

  bool login = true;

  final formKey = GlobalKey<FormState>();

  void saveUser(Map userMap) {
    AppConstants.user = Users(
        uid: userMap["userId"],
        firstName: userMap["firstName"],
        lastName: userMap["lastName"],
        email: userMap["email"],
        phoneNumber: userMap["phoneNumber"]);
    AppConstants.usersBox.put(AppConstants.user.uid, AppConstants.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: login
                ? LoginForm(
                    formKey: formKey,
                    email: email,
                    password: password,
                  )
                : SignUpForm(
                    formKey: formKey,
                    email: email,
                    password: password,
                    firstName: firstName,
                    lastName: lastName,
                    phoneNumber: phoneNumber,
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) {
                return;
              }

              if (login) {
                try {
                  final dio = Dio();
                  final response = await dio.get(
                    "http://10.0.2.2:8080/expense-tracker/users/auth",
                    data: {
                      "firstName": firstName.text,
                      "lastName": lastName.text,
                      "email": email.text,
                      "password": password.text,
                      "phoneNumber": phoneNumber.text
                    },
                  );

                  final Map userMap = response.data;
                  saveUser(userMap);
                  AppConstants.deserializeExpenses(userMap["expenses"]);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomeScreen();
                      },
                    ),
                  );
                } catch (e) {
                  print(e);
                  if (!context.mounted) {
                    return;
                  }
                  AppConstants.snackbar(context, "Incorrect email or password");
                }
              } else {
                try {
                  final response = await AppConstants.dio.post(
                      "http://10.0.2.2:8080/expense-tracker/users",
                      data: {
                        "firstName": firstName.text,
                        "lastName": lastName.text,
                        "email": email.text,
                        "password": password.text,
                        "phoneNumber": phoneNumber.text
                      });
                  final userMap = response.data;
                  saveUser(userMap);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomeScreen();
                      },
                    ),
                  );
                } on DioException catch (e) {
                  AppConstants.snackbar(context, "Email already in use");
                  print(e);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const BeveledRectangleBorder(),
              backgroundColor: AppConstants.darkAppColor.onPrimary,
            ),
            child: const Text("Login"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                login = !login;
              });
            },
            child: const Text("Sign Up"),
          ),
        ],
      ),
    );
  }
}

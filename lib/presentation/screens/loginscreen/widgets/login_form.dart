import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm(
      {super.key,
      required this.formKey,
      required this.email,
      required this.password});
  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Email"),
              hintText: "example@email.com",
            ),
            validator: (value) {
              if (value == null) {
                return "Email cannot be null";
              }
              if (!EmailValidator.validate(email.text)) {
                return "Invalid Email";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            controller: email,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Password"),
            ),
            obscureText: true,
            controller: password,
            validator: (value) {
              if (value == null) {
                return "Password cannot be empty";
              }
              if (value.isEmpty) {
                return "Password cannot be empty";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm(
      {super.key,
      required this.formKey,
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});

  final GlobalKey<FormState> formKey;
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text("First Name"),
              hintText: "John",
            ),
            validator: (value) {
              if (value == null) {
                return "FirstName cannot be null";
              }
              if (value.isEmpty) {
                return "FirstName cannot be null";
              }
              return null;
            },
            keyboardType: TextInputType.name,
            controller: firstName,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Last Name"),
              hintText: "Doe",
            ),
            validator: (value) {
              if (value == null) {
                return "LastName cannot be null";
              }
              if (value.isEmpty) {
                return "LastName cannot be null";
              }
              return null;
            },
            keyboardType: TextInputType.name,
            controller: lastName,
          ),
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
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Phone Number"),
            ),
            obscureText: true,
            controller: phoneNumber,
          ),
        ],
      ),
    );
  }
}

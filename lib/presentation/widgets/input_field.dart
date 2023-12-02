import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/categories.dart';
import '../../data/models/expense.dart';

class InputField extends StatefulWidget {
  const InputField({super.key, required this.addFun});
  final Function addFun;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final _titleController = TextEditingController();
  final _amtController = TextEditingController();
  final _amtFocus = FocusNode();
  Categories _selectedCategory = Categories.food;
  DateTime? _selecetedDate;
  final _formKey = GlobalKey<FormState>();

  void _selectDate() async {
    final currentDate = DateTime.now();
    final firstDate =
        DateTime(currentDate.year - 3, currentDate.month, currentDate.day);
    final date = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: firstDate,
        lastDate: currentDate);

    setState(() {
      _selecetedDate = date;
    });
  }

  void _saveData() {
    final valid = _formKey.currentState!.validate();
    if (!valid) {
      return;
    }
    final amount = double.tryParse(_amtController.text) ?? 0;
    if (_selecetedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Please select a date'),
          content: const Row(
            children: [
              Text('Click on this icon to pick a date: '),
              Icon(Icons.calendar_month),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'))
          ],
        ),
      );
      return;
    }
    widget.addFun(Expense(
        id: 0,
        title: _titleController.text,
        amount: amount,
        dt: _selecetedDate!,
        ct: _selectedCategory));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amtController.dispose();
    _amtFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: _titleController,
                maxLength: 30,
                decoration: const InputDecoration(label: Text('Title')),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_amtFocus);
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          label: Text('Amount'), prefixText: '₹ '),
                      controller: _amtController,
                      maxLength: 8,
                      focusNode: _amtFocus,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (_amtController.text.isEmpty) {
                          return 'Enter a amount';
                        }
                        if (double.tryParse(_amtController.text) == null) {
                          return 'Enter a valid amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_selecetedDate == null
                            ? 'Select Date'
                            : DateFormat.yMEd()
                                .format(_selecetedDate!)
                                .toString()),
                        IconButton(
                            onPressed: _selectDate,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  DropdownButton(
                      borderRadius: BorderRadius.circular(20),
                      dropdownColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      value: _selectedCategory,
                      items: Categories.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          _selectedCategory = value;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel')),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: _saveData,
                    child: const Text(
                      'Save',
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

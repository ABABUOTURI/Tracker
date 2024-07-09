import 'package:flutter/material.dart';
import '../models/budget.dart';

class AddBudgetPage extends StatefulWidget {
  final Function(Budget) onSave;

  const AddBudgetPage({required this.onSave});

  @override
  _AddBudgetPageState createState() => _AddBudgetPageState();
}

class _AddBudgetPageState extends State<AddBudgetPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _monthlyBudgetController = TextEditingController();
  List<CategoryBudget> _categoryBudgets = [];
  final List<String> _categories = [
    'Food',
     'Transport',
      'Entertainment',
       'Other'];

  @override
  void initState() {
    super.initState();
    _categoryBudgets = _categories.map((category) => CategoryBudget(category: category, amount: 0)).toList();
  }

  void _saveBudget() {
    if (_formKey.currentState!.validate()) {
      double monthlyBudget = double.tryParse(_monthlyBudgetController.text) ?? 0;
      Budget newBudget = Budget(
        monthlyBudget: monthlyBudget,
        categoryBudgets: _categoryBudgets,
      );
      widget.onSave(newBudget);
      Navigator.pop(context);
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Set Budget',
         style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _monthlyBudgetController,
                decoration: const InputDecoration(labelText: 'Monthly Budget'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a monthly budget';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('Category Budgets', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ..._categoryBudgets.map((categoryBudget) {
                return TextFormField(
                  initialValue: categoryBudget.amount.toString(),
                  decoration: InputDecoration(labelText: categoryBudget.category),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      categoryBudget.amount = double.tryParse(value) ?? 0;
                    });
                  },
                );
              }).toList(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
  onPressed: _saveBudget,
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 3, 40, 104), // Set button background color
  ),
  child: Text(
    'Save',
    style: TextStyle(color: Colors.white), // Set text color
  ),
),
                 ElevatedButton(
  onPressed: _cancel,
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 3, 40, 104), // Set button background color
  ),
  child: Text(
    'Cancel',
    style: TextStyle(color: Colors.white), // Set text color
  ),
),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

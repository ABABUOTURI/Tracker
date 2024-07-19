import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddExpensePage extends StatefulWidget {
  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;

  List<Category> categories = [
    Category(name: 'Households', type: 'Expense'),
    Category(name: 'Education', type: 'Expense'),
    Category(name: 'Vacation', type: 'Expense'),
    Category(name: 'Rent', type: 'Expense'),
    Category(name: 'Groceries', type: 'Expense'),
    Category(name: 'Transportation', type: 'Expense'),
    Category(name: 'Medication', type: 'Expense'),
  ];

  @override
  void initState() {
    super.initState();
    if (categories.isNotEmpty) {
      selectedCategory = categories[0].name;
    }
  }

  void saveExpense() async {
    if (amountController.text.isEmpty ||
        selectedCategory == null ||
        descriptionController.text.isEmpty) {
      // Show error if any field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill all fields'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    double? amount = double.tryParse(amountController.text);
    if (amount == null) {
      // Show error if amount is not a valid number
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter a valid amount'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      String userEmail = user.email ?? 'No email';

      FirebaseFirestore.instance
          .collection('expenses')
          .add({
        'amount': amount,
        'category': selectedCategory,
        'description': descriptionController.text,
        'timestamp': FieldValue.serverTimestamp(), // Add server timestamp
        'userId': userId,
        'userEmail': userEmail,
      }).then((value) {
        amountController.clear();
        descriptionController.clear();
        setState(() {
          selectedCategory = categories.isNotEmpty ? categories[0].name : null;
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Expense added successfully'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add expense: $error'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('No user logged in'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Expense',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.0),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.name,
                  child: Text(category.name),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Category',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: saveExpense,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 3, 40, 104),
              ),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                amountController.clear();
                descriptionController.clear();
                setState(() {
                  selectedCategory = categories.isNotEmpty ? categories[0].name : null;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 3, 40, 104),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
        items: const [
          Icon(Icons.home, color: Colors.black),
          Icon(Icons.attach_money, color: Colors.black),
          Icon(Icons.bar_chart, color: Colors.black),
          Icon(Icons.notification_add, color: Colors.black),
          Icon(Icons.settings, color: Colors.black),
        ],
      ),
    );
  }
}

class Category {
  String name;
  String type;

  Category({required this.name, required this.type});
}

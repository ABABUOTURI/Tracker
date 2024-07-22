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
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void saveExpense() async {
    String category = categoryController.text.trim();

    if (amountController.text.isEmpty ||
        category.isEmpty ||
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
        'category': category,
        'description': descriptionController.text,
        'timestamp': FieldValue.serverTimestamp(), // Add server timestamp
        'userId': userId,
        'userEmail': userEmail,
      }).then((value) {
        amountController.clear();
        descriptionController.clear();
        categoryController.clear();

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
        backgroundColor: Color(0xFF222831),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF222831),
              Color(0xFF393E46),
              Color(0xFFFD7014),
              Color(0xFFEEEEEE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(), // Added border
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Color(0xFFEEEEEE)),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(), // Added border
                ),
                style: TextStyle(color: Color(0xFFEEEEEE)),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(), // Added border
                ),
                style: TextStyle(color: Color(0xFFEEEEEE)),
              ),
              SizedBox(height: 20.0),
              // Arrange buttons in two columns
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: saveExpense,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF222831),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Color(0xFFEEEEEE)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        amountController.clear();
                        descriptionController.clear();
                        categoryController.clear();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF222831),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Color(0xFFEEEEEE)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFFD7014),
        items: const [
          Icon(Icons.dashboard, color: Color(0xFF222831)),
          Icon(Icons.attach_money, color: Color(0xFF222831)),
          Icon(Icons.bar_chart, color: Color(0xFF222831)),
          Icon(Icons.notification_add, color: Color(0xFF222831)),
          Icon(Icons.settings, color: Color(0xFF222831)),
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

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AddExpensePage extends StatefulWidget {
  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;  // Changed to nullable type to handle the initial null state

  // List the categories added in expense
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
      selectedCategory = categories[0].name;  // Initialize with the first category if available
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // the top navigation bar
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Add Expense',
        style: TextStyle(color: Colors.white),),
         backgroundColor: Color.fromARGB(255, 3, 40, 104),
      ),

      // The body of the page where all functionalities go
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            SizedBox(height: 12.0),
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

            // The save button it ensures that the expenses added are saved, displayed, and stored in the database
            ElevatedButton(
              onPressed: () {
                // Save logic
              },
               style: ElevatedButton.styleFrom(
             backgroundColor: Color.fromARGB(255, 3, 40, 104),
            ),
              child: Text('Save',
              style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 8.0),
            
            // The Cancel Button "You can cancel the Expenses instead of saving them"
            TextButton(
              onPressed: () {
                // Cancel logic
                dateController.clear();
                amountController.clear();
                descriptionController.clear();
                setState(() {
                  selectedCategory = categories.isNotEmpty ? categories[0].name : null;
                });
              },
               style: ElevatedButton.styleFrom(
             backgroundColor: Color.fromARGB(255, 3, 40, 104),
            ),
              child: Text('Cancel',
              style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
        items: const [
          Icon(Icons.home, color: Colors.black),
          Icon(Icons.attach_money, color: Colors.black),
          Icon(Icons.list, color: Colors.black),
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

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ExpenseListPage extends StatefulWidget {
  @override
  _ExpenseListPageState createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  List<Expense> expenses = [
    Expense(date: '2024-07-01', amount: 50.0, category: 'Category 1', description: 'Groceries'),
    Expense(date: '2024-07-02', amount: 20.0, category: 'Category 2', description: 'Transport'),
    Expense(date: '2024-07-03', amount: 100.0, category: 'Category 3', description: 'Utilities'),
  ];

  String selectedFilterCategory = 'All';
  DateTime selectedFilterDate = DateTime.now();

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
        title: Text('Expense List'),
        backgroundColor: Colors.blueAccent,
      ),

      // The body of the page where all functionalities go
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter section
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedFilterCategory,
                    onChanged: (newValue) {
                      setState(() {
                        selectedFilterCategory = newValue!;
                      });
                    },
                    items: ['All', 'Category 1', 'Category 2', 'Category 3']
                        .map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Filter by Category',
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Filter by Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedFilterDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedFilterDate = pickedDate;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),

            // Expenses list section
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${expenses[index].date} - ${expenses[index].category}'),
                      subtitle: Text('${expenses[index].amount} - ${expenses[index].description}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Implement editing logic here
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                expenses.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // the curved navigation bar at the bottom
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: const [
          Icon(Icons.home, color: Colors.black),
          Icon(Icons.attach_money, color: Colors.black),
          Icon(Icons.list, color: Colors.black),
          Icon(Icons.bar_chart, color: Colors.black),
          Icon(Icons.notification_add, color: Colors.black),
          Icon(Icons.settings, color: Colors.black),
        ],
        onTap: (index) {
          // Handle button tap
          switch (index) {
            case 0:
              // Navigate to Home Page
              break;
            case 1:
              // Navigate to Add Income Page
              break;
            case 2:
              // Navigate to Expense Tracker Page
              break;
            case 3:
              // Navigate to Charts Page
              break;
            case 4:
              // Navigate to Notifications Page
              break;
            case 5:
              // Navigate to Settings Page
              break;
          }
        },
      ),
    );
  }
}

class Expense {
  String date;
  double amount;
  String category;
  String description;

  Expense({
    required this.date,
    required this.amount,
    required this.category,
    required this.description,
  });
}

class Category {
  String name;
  String type;

  Category({required this.name, required this.type});
}

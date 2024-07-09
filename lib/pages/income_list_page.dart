import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter1/pages/CategorizationPage.dart';
import 'package:flutter1/pages/notification_page.dart';
import 'package:flutter1/pages/security_settings_page.dart';

class IncomeListPage extends StatefulWidget {
  @override
  _IncomeListPageState createState() => _IncomeListPageState();
}

class _IncomeListPageState extends State<IncomeListPage> {
  List<Income> incomes = [
    Income(date: '2024-07-01', amount: 150.0, source: 'Salary', description: 'Monthly Salary'),
    Income(date: '2024-07-05', amount: 200.0, source: 'Freelance', description: 'Project Payment'),
    Income(date: '2024-07-10', amount: 50.0, source: 'Gift', description: 'Birthday Gift'),
  ];

  String selectedFilterSource = 'All';
  DateTime selectedFilterDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The top navigation bar
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Income List'),
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
                    value: selectedFilterSource,
                    onChanged: (newValue) {
                      setState(() {
                        selectedFilterSource = newValue!;
                      });
                    },
                    items: ['All', 'Salary', 'Freelance', 'Gift']
                        .map((source) {
                      return DropdownMenuItem<String>(
                        value: source,
                        child: Text(source),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Filter by Source',
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

            // Incomes list section
            Expanded(
              child: ListView.builder(
                itemCount: incomes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${incomes[index].date} - ${incomes[index].source}'),
                      subtitle: Text('${incomes[index].amount} - ${incomes[index].description}'),
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
                                incomes.removeAt(index);
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

      // The curved navigation bar at the bottom
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
               Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecuritySettingsPage()));
              break;
            case 3:
              // Navigate to Charts Page
               Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChartsPage()));
              break;
            case 4:
              // Navigate to Notifications Page
               Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()));
              break;
            case 5:
              // Navigate to Settings Page
               Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecuritySettingsPage()));
              break;
          }
        },
      ),
    );
  }
}

class Income {
  String date;
  double amount;
  String source;
  String description;

  Income({
    required this.date,
    required this.amount,
    required this.source,
    required this.description,
  });
}

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter1/pages/CategorizationPage.dart';
import 'package:flutter1/pages/DashboardPage.dart';
import '../models/budget.dart';
import 'add_budget_page.dart';
import 'notification_page.dart';
import 'security_settings_page.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final List<Budget> _budgets = [];

  void _addNewBudget(Budget budget) {
    setState(() {
      _budgets.add(budget);
    });
  }
  int _pageIndex = 1;

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
        title: const Text('Your Budgets',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _budgets.length,
                itemBuilder: (context, index) {
                  final budget = _budgets[index];
                  return Card(
                    child: ListTile(
                      title: Text('Monthly Budget: Ksh.${budget.monthlyBudget.toStringAsFixed(2)}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: budget.categoryBudgets.map((categoryBudget) {
                          return Text('${categoryBudget.category}: Ksh.${categoryBudget.amount.toStringAsFixed(2)}');
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBudgetPage(onSave: _addNewBudget)),
          );
        },
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
        child: Icon(Icons.add ,color: Colors.white,),
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

        index: _pageIndex,
        onTap: (index) {
           setState(() {
            _pageIndex = index;
          });
          // Handle button tap
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardPage()));
              break;
            case 1:
              // Navigate to Budget Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BudgetPage()));
              break;
            case 2:
              // Navigate to Categorization Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategorizationPage()));
              break;
            case 3:
              // Navigate to Reports or Charts Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChartsPage()));
              break;
            case 4:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()));
              break;
            case 5:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecuritySettingsPage()));
              break;
          }
        },
      ),
    );
  }
}

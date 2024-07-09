import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter1/pages/CategorizationPage.dart';
import 'package:flutter1/pages/add_expense_page.dart';
import 'package:flutter1/pages/add_income_page.dart';
import 'package:flutter1/pages/budget_page.dart';
import 'package:flutter1/pages/notification_page.dart';
import 'package:flutter1/pages/security_settings_page.dart';


// Define a simple Income class to hold income data
class Income {
  final String title;
  final double amount;

  Income({required this.title, required this.amount});
}

// Define a simple Expense class to hold expense data
class Expense {
  final String title;
  final double amount;

  Expense({required this.title, required this.amount});
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double totalIncome = 0.0;
  double totalExpenses = 0.0;
  double balance = 0.0;

  int _pageIndex = 0;

  List<Income> incomeList = [];
  List<Expense> expenseList = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSummaryCards(),
            SizedBox(height: 20.0),
            _buildActionButtons(screenWidth),
            SizedBox(height: 20.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildListsContainer(),
                  ],
                ),
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
              // Navigate to Dashboard or Home Page
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DashboardPage()));
              break;
            case 1:
              // Navigate to Budget Page
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BudgetPage()));
              break;
            case 2:
              // Navigate to Expense Tracker Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategorizationPage()));
              break;
            case 3:
              // Navigate to Reports or Charts Page
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChartsPage()));
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

  Widget _buildSummaryCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSummaryCard('Total Income', totalIncome.toString()),
        _buildSummaryCard('Total Expenses', totalExpenses.toString()),
        _buildSummaryCard('Balance', balance.toString()),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              value,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(double screenWidth) {
    double buttonWidth = screenWidth > 600 ? 200 : double.infinity;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: buttonWidth,
          child: ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddIncomePage()));
              if (result != null && result is Income) {
                setState(() {
                  incomeList.add(result);
                  totalIncome += result.amount;
                  balance = totalIncome - totalExpenses;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 3, 40, 104),
            ),
            child: const Text(
              'Add Income',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          width: buttonWidth,
          child: ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddExpensePage()));
              if (result != null && result is Expense) {
                setState(() {
                  expenseList.add(result);
                  totalExpenses += result.amount;
                  balance = totalIncome - totalExpenses;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 3, 40, 104),
            ),
            child: Text(
              'Add Expense',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListsContainer() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Income List',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 150, // Adjust height as needed
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: incomeList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(incomeList[index].title),
                        trailing: Text('\$${incomeList[index].amount.toString()}'),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Expense List',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 150, // Adjust height as needed
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: expenseList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(expenseList[index].title),
                        trailing: Text('\$${expenseList[index].amount.toString()}'),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

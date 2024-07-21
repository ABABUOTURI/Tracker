import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/pages/DashboardPage.dart';
import 'package:flutter1/pages/budget_page.dart';
import 'package:flutter1/pages/notification_page.dart';
import 'package:flutter1/pages/security_settings_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key});

  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  int _pageIndex = 2; // Set initial page index to 2 to display ChartsPage by default
  double income = 0.0;
  double expense = 0.0;
  double budget = 0.0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;

      // Fetch income
      QuerySnapshot incomeSnapshot = await FirebaseFirestore.instance
          .collection('incomes')
          .where('userId', isEqualTo: userId)
          .get();
      double totalIncome = incomeSnapshot.docs
          .map((doc) => doc['amount'] as double)
          .fold(0.0, (a, b) => a + b);

      // Fetch expense
      QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
          .collection('expenses')
          .where('userId', isEqualTo: userId)
          .get();
      double totalExpense = expenseSnapshot.docs
          .map((doc) => doc['amount'] as double)
          .fold(0.0, (a, b) => a + b);

      // Fetch budget
      QuerySnapshot budgetSnapshot = await FirebaseFirestore.instance
          .collection('budgets')
          .where('userId', isEqualTo: userId)
          .get();
      double monthlyBudget = budgetSnapshot.docs.isNotEmpty
          ? budgetSnapshot.docs.first['monthlyBudget'] as double
          : 0.0;

      setState(() {
        income = totalIncome;
        expense = totalExpense;
        budget = monthlyBudget;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      DashboardPage(),
      BudgetPage(),
      ChartsPage(), // Charts page at index 2
      NotificationsPage(),
      SecuritySettingsPage(),
    ];

    Widget buildBarChart(double value, Color color) {
      return BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: false,
            ),
            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (context, value) => const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              margin: 16,
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  y: value,
                  colors: [color],
                  width: 22,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Visualize Your Expenditure',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
      ),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Cards displaying information
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Total Income'),
                      subtitle: Text('\$${income.toStringAsFixed(2)}'),
                    ),
                    SizedBox(
                      height: 150,
                      child: buildBarChart(income, Colors.blue),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Total Expense'),
                      subtitle: Text('\$${expense.toStringAsFixed(2)}'),
                    ),
                    SizedBox(
                      height: 150,
                      child: buildBarChart(expense, Colors.red),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Budget'),
                      subtitle: Text('\$${budget.toStringAsFixed(2)}'),
                    ),
                    SizedBox(
                      height: 150,
                      child: buildBarChart(budget, Colors.green),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Remaining Budget'),
                      subtitle: Text('\$${(budget - expense).toStringAsFixed(2)}'),
                    ),
                    SizedBox(
                      height: 150,
                      child: buildBarChart(budget - expense, Colors.orange),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
        index: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });

          // Handle button tap
          switch (index) {
            case 0:
              // Navigate to Home Page
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DashboardPage()));
              break;
            case 1:
              // Navigate to Add Income Page
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BudgetPage()));
              break;
            case 2:
              // Navigate to Charts Page
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChartsPage()));
              break;
            case 3:
              // Navigate to Notifications Page
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NotificationsPage()));
              break;
            case 4:
              // Navigate to Settings Page
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SecuritySettingsPage()));
              break;
          }
        },
      ),
    );
  }
}3

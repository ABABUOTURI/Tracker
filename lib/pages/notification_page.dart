import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/pages/ChartsPage.dart';
import 'package:flutter1/pages/DashboardPage.dart';
import 'package:flutter1/pages/budget_page.dart';
import 'package:flutter1/pages/profile_page.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationModel> _notifications = [];
  int _pageIndex = 3;

  @override
  void initState() {
    super.initState();
    calculateExpenseSummary(); // Initial calculation
  }

  void calculateExpenseSummary() {
    // Replace with your actual logic to calculate expense summaries
    double totalExpensesThisMonth = 1501; // Example total expenses
    double budgetThreshold = 1000; // Example budget threshold

    if (totalExpensesThisMonth > budgetThreshold) {
      setState(() {
        _notifications.add(NotificationModel(
          title: 'Budget Limit Exceeded',
          description: 'You have exceeded your monthly budget limit of Ksh. ${budgetThreshold.toStringAsFixed(2)}.',
          time: DateTime.now(),
        ));
      });
    }

    setState(() {
      _notifications.add(NotificationModel(
        title: 'Expense Summary',
        description: 'You have spent Ksh. ${totalExpensesThisMonth.toStringAsFixed(2)} in total.',
        time: DateTime.now(),
      ));
    });
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
        title: Text('Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF222831), // Matching color with BudgetPage
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
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color(0xFF393E46), // Match card color
              child: ListTile(
                title: Text(_notifications[index].title,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(_notifications[index].description,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text(
                  DateFormat.yMMMd().add_jm().format(_notifications[index].time),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
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
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => BudgetPage()));
              break;
            case 2:
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChartsPage()));
              break;
            case 3:
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotificationsPage()));
              break;
            case 4:
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
              break;
          }
        },
      ),
    );
  }
}

class NotificationModel {
  final String title;
  final String description;
  final DateTime time;

  NotificationModel({
    required this.title,
    required this.description,
    required this.time,
  });
}

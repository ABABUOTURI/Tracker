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
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_notifications[index].title),
            subtitle: Text(_notifications[index].description),
            trailing: Text(DateFormat.yMMMd().add_jm().format(_notifications[index].time)),
          );
        },
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
               Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardPage()));
              break;
            case 1:
              // Navigate to Add Income Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BudgetPage()));
              break;
            case 2:
              // Navigate to Charts Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChartsPage()));
              break;
            case 3:
              // Navigate to Notifications Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()));
              break;
            case 4:
              // Navigate to Settings Page
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

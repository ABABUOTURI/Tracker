import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter1/pages/CategorizationPage.dart';
import 'package:flutter1/pages/DashboardPage.dart';
import 'package:flutter1/pages/budget_page.dart';
import 'package:flutter1/pages/security_settings_page.dart';
import '../models/notification.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      title: 'Budget Limit Reached',
      description: 'You have exceeded your monthly budget limit.',
      time: DateTime.now().subtract(Duration(hours: 1)),
    ),
    NotificationModel(
      title: 'Expense Summary',
      description: 'Your total expenses for this month are Ksh.50000.',
      time: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  int _pageIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Notifications',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.description),
              trailing: Text(_formatTime(notification.time)),
            ),
          );
        },
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
              // Navigate to Home Page
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
              // Navigate to Charts Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChartsPage()));
              break;
            case 4:
              // Navigate to Notifications
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

  String _formatTime(DateTime time) {
    return '${time.day}/${time.month}/${time.year} ${time.hour}:${time.minute}';
  }
}

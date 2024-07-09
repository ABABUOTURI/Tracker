import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter1/pages/CategorizationPage.dart';
import 'package:flutter1/pages/DashboardPage.dart';
import 'package:flutter1/pages/budget_page.dart';
import 'package:flutter1/pages/notification_page.dart';
import 'package:flutter1/pages/profile_page.dart';

class SecuritySettingsPage extends StatefulWidget {
  @override
  _SecuritySettingsPageState createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  int _pageIndex = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Security Settings',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: const Text('Two-Factor Authentication'),
              subtitle: const Text('Enable or disable two-factor authentication.'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Enable/Disable logic here
                },
                 style: ElevatedButton.styleFrom(
             backgroundColor: Color.fromARGB(255, 3, 40, 104),
            ),
                child: const Text('Enable/Disable',
                style: TextStyle(color: Colors.white),),
              ),
            ),
            ListTile(
              title: const Text('Password Management'),
              subtitle: const Text('Change your password and manage security.'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Navigate to change password page or dialog
                },
                 style: ElevatedButton.styleFrom(
             backgroundColor: Color.fromARGB(255, 3, 40, 104),
            ),
                child: const Text('Manage',
                style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              style: ElevatedButton.styleFrom(
             backgroundColor: Color.fromARGB(255, 3, 40, 104),
            ),
              child: const Text('Back to Profile',
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
              // Navigate to Expense Tracker Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategorizationPage()));
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

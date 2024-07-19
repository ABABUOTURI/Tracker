import 'package:flutter/material.dart';
import 'package:flutter1/pages/profile_page.dart';

class SecuritySettingsPage extends StatefulWidget {
  @override
  _SecuritySettingsPageState createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  

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
    );
  }
}

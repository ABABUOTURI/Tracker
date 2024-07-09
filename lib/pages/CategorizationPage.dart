import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter1/pages/DashboardPage.dart';
import 'package:flutter1/pages/budget_page.dart';
import 'package:flutter1/pages/notification_page.dart';
import 'package:flutter1/pages/security_settings_page.dart';

class CategorizationPage extends StatefulWidget {
  @override
  _CategorizationPageState createState() => _CategorizationPageState();
}

class _CategorizationPageState extends State<CategorizationPage> {
  List<Category> categories = [];
  TextEditingController nameController = TextEditingController();
  String selectedType = 'Expense';
  bool isEditing = false;
  late int editingIndex;

  int _pageIndex = 2; // Index for CategorizationPage

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
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index].name),
                  subtitle: Text(categories[index].type),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            isEditing = true;
                            editingIndex = index;
                            nameController.text = categories[index].name;
                            selectedType = categories[index].type;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            categories.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                DropdownButton<String>(
                  value: selectedType,
                  onChanged: (newValue) {
                    setState(() {
                      selectedType = newValue!;
                    });
                  },
                  items: <String>['Expense', 'Income']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
        onPressed: () {
          if (isEditing) {
            setState(() {
              categories[editingIndex] = Category(
                name: nameController.text,
                type: selectedType,
              );
              isEditing = false;
            });
          } else {
            setState(() {
              categories.add(Category(
                name: nameController.text,
                type: selectedType,
              ));
            });
          }
          nameController.clear();
        },
        child: Icon(Icons.add, color: Colors.white),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BudgetPage()));
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategorizationPage()));
              break;
            case 3:
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

class Category {
  String name;
  String type;

  Category({required this.name, required this.type});
}

class ChartsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charts'),
      ),
      body: Center(
        child: Text('Charts Page'),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}

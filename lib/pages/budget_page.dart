import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter1/pages/ChartsPage.dart';
import 'package:flutter1/pages/DashboardPage.dart';
import 'package:flutter1/pages/notification_page.dart';
import 'package:flutter1/pages/profile_page.dart';
import '../models/budget.dart';
import 'add_budget_page.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final List<Budget> _budgets = [];
  int _pageIndex = 1;

  @override
  void initState() {
    super.initState();
    _fetchBudgets();
  }

  void _fetchBudgets() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('budgets')
          .where('userId', isEqualTo: userId)
          .get();

      setState(() {
        _budgets.clear();
        querySnapshot.docs.forEach((doc) {
          double monthlyBudget = doc['monthlyBudget'];
          List<CategoryBudget> categoryBudgets = (doc['categoryBudgets'] as List)
              .map((cb) => CategoryBudget(
                  category: cb['category'], amount: cb['amount']))
              .toList();
          _budgets.add(Budget(
            monthlyBudget: monthlyBudget,
            categoryBudgets: categoryBudgets,
          ));
        });
      });
    }
  }

  void _addNewBudget(Budget budget) {
    setState(() {
      _budgets.add(budget);
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
        title: const Text(
          'Your Budgets',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF222831), // Matching color with DashboardPage
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
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _budgets.length,
                itemBuilder: (context, index) {
                  final budget = _budgets[index];
                  return Card(
                    color: Color(0xFF393E46), // Match card color
                    child: ListTile(
                      title: Text(
                          'Monthly Budget: Ksh.${budget.monthlyBudget.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: budget.categoryBudgets.map((categoryBudget) {
                          return Text(
                              '${categoryBudget.category}: Ksh.${categoryBudget.amount.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.white));
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
            MaterialPageRoute(
                builder: (context) =>
                    AddBudgetPage(onSave: _addNewBudget)),
          );
        },
        backgroundColor: Color(0xFFFD7014), // Match button color
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
         backgroundColor: Color(0xFFFD7014),
        items: const [
          Icon(Icons.dashboard, color: Color(0xFF222831),),
          Icon(Icons.attach_money, color: Color(0xFF222831),),
          Icon(Icons.bar_chart, color:  Color(0xFF222831),),
          Icon(Icons.notification_add, color:  Color(0xFF222831),),
          Icon(Icons.settings, color:  Color(0xFF222831)),
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
              // Navigate to Reports or Charts Page
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

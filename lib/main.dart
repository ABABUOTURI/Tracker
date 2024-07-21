import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter1/pages/add_expense_page.dart';
import 'package:flutter1/pages/add_income_page.dart';
import 'package:flutter1/pages/income_list_page.dart';
import 'package:flutter1/pages/login_page.dart';
import 'package:flutter1/pages/reset_password_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBfhHbo68kQBTYcywwVR8lK9KxsR2qZiMI",
      authDomain: "contactportfolio-ea6bf.firebaseapp.com",
      projectId: "contactportfolio-ea6bf",
      storageBucket: "contactportfolio-ea6bf.appspot.com",
      messagingSenderId: "440719674261",
      appId: "1:440719674261:android:ba2de03a3c7056d61c449c",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        
        '/': (context) => LoginPage(),
        '/reset_password': (context) => ResetPasswordPage(),
        '/add_expense': (context) => AddExpensePage(),
         '/add_income': (context) => AddIncomePage(),
          '/income_list_page': (context) => IncomeListPage(),
        // Add more routes as needed
      },
    );
  }
}

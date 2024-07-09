import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter1/pages/login_page.dart';
//import 'package:flutter1/pages/CategorizationPage.dart';
//import 'pages/Categorizationpage.dart'; // Adjust the path as per your project structure

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
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(), // Ensure LoginPage is correctly imported and defined
    );
  }
}

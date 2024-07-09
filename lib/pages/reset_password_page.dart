import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Example of using arguments
    final userId = args?['userId'] ?? ''; // Example usage

    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Center(
        child: Text('Reset password for user: $userId'), // Example usage of userId
      ),
    );
  }
}

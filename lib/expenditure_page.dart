import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExpenditurePage extends StatefulWidget {
  final List<Map<String, String>> categories;

  ExpenditurePage({required this.categories});

  @override
  _ExpenditurePageState createState() => _ExpenditurePageState();
}

class _ExpenditurePageState extends State<ExpenditurePage> {
  final TextEditingController expenditureController = TextEditingController();
  String? selectedCategory;

  void addExpenditure() async {
    if (selectedCategory != null && expenditureController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('expenditures').add({
        'category': selectedCategory,
        'amount': expenditureController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      expenditureController.clear();
      setState(() {
        selectedCategory = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expenditure'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              isExpanded: true,
              value: selectedCategory,
              hint: Text('Select Category'),
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: widget.categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category['category'],
                  child: Text(category['category'] ?? ''),
                );
              }).toList(),
            ),
            TextField(
              controller: expenditureController,
              decoration: InputDecoration(labelText: 'Expenditure'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addExpenditure,
              child: Text('Add Expenditure'),
            ),
          ],
        ),
      ),
    );
  }
}

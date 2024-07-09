import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AddIncomePage extends StatefulWidget {
  @override
  _AddIncomePageState createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> _sources = ['Salary', 'Business', 'Investment', 'Other'];
  String? _selectedSource;

  @override
  void initState() {
    super.initState();
    _selectedSource = _sources.isNotEmpty ? _sources[0] : null; // Initialize with the first source if available
  }

  @override
  void dispose() {
    _dateController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
        title: Text('Add Income',
         style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 3, 40, 104),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField<String>(
              value: _selectedSource,
              onChanged: (newValue) {
                setState(() {
                  _selectedSource = newValue;
                });
              },
              items: _sources.map((source) {
                return DropdownMenuItem<String>(
                  value: source,
                  child: Text(source),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Source'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement save logic here
                  },
                  style: ElevatedButton.styleFrom(
             backgroundColor: Color.fromARGB(255, 3, 40, 104),
            ),
                  child: Text('Save',
                  style: TextStyle(color: Colors.white),),
                ),
                ElevatedButton(
                  onPressed: () {
                    _dateController.clear();
                    _amountController.clear();
                    _descriptionController.clear();
                    setState(() {
                      _selectedSource = _sources.isNotEmpty ? _sources[0] : null;
                    });
                  },
                    style: ElevatedButton.styleFrom(
             backgroundColor: Color.fromARGB(255, 3, 40, 104),
            ),
                  child: Text('Cancel',
                  style: TextStyle(color: Colors.white),),
                ),
              ],
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
        onTap: (index) {
          // Handle button tap
        },
      ),
    );
  }
}

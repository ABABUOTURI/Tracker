import 'package:flutter/material.dart';
import 'navigation_shell.dart';

class SecondPage extends StatefulWidget {
  final List<Map<String, String>> categories;

  const SecondPage({Key? key, required this.categories}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  void _addCategory() {
    if (_categoryController.text.isNotEmpty && _budgetController.text.isNotEmpty) {
      setState(() {
        widget.categories.add({
          'name': _categoryController.text,
          'budget': _budgetController.text,
        });
      });
      updateParent();
    }
  }

  void updateParent() {
    final navigationShellState = context.findAncestorStateOfType<NavigationShellState>();
    if (navigationShellState != null) {
      navigationShellState.updateCategories(widget.categories);
    } else {
      print("Error: NavigationShellState not found.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          TextField(
            controller: _categoryController,
            decoration: InputDecoration(labelText: 'Category Name'),
          ),
          TextField(
            controller: _budgetController,
            decoration: InputDecoration(labelText: 'Budget Amount'),
          ),
          ElevatedButton(
            onPressed: _addCategory,
            child: Text('Add Category'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.categories[index]['name']!),
                  subtitle: Text('Budget: ${widget.categories[index]['budget']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

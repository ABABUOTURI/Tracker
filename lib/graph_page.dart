import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List<FlSpot> dataPoints = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('expenditures').get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      Map<String, double> dailyExpenses = {};

      for (var doc in docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        DateTime timestamp = (data['timestamp'] as Timestamp).toDate();
        String day = "${timestamp.year}-${timestamp.month}-${timestamp.day}";
        double amount = data['amount'] is String ? double.parse(data['amount']) : data['amount'].toDouble();

        if (dailyExpenses.containsKey(day)) {
          dailyExpenses[day] = dailyExpenses[day]! + amount;
        } else {
          dailyExpenses[day] = amount;
        }
      }

      List<FlSpot> points = [];
      int index = 0;
      dailyExpenses.forEach((day, amount) {
        points.add(FlSpot(index.toDouble(), amount));
        index++;
      });

      setState(() {
        dataPoints = points;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenditure Graph'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: dataPoints.isEmpty
            ? CircularProgressIndicator()
            : LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: dataPoints,
                      isCurved: true,
                      barWidth: 4,
                      colors: [Colors.blue],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

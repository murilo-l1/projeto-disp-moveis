import 'package:expense_tracker/pages/home.dart';
import 'package:flutter/material.dart';

class HistoricalPage extends StatelessWidget {
  const HistoricalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Center(
        child: Text('This is another screen.'),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }
}

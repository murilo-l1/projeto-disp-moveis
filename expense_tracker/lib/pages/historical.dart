import 'package:expense_tracker/pages/home.dart';
import 'package:flutter/material.dart';

class HistoricalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: Text('This is another screen.'),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }
}

//criar um grafico de barras com 12 barras, uma para cada mes do ano

//criar um historico scrollavel com apenas um item por hora como exemplo
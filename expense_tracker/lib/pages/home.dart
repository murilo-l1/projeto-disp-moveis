import 'dart:js';
import 'package:expense_tracker/pages/historical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      // alterar Padding para ajustar a distancia depois que eu colocar o grafico!
      body: Padding(
        padding: const EdgeInsets.only(top: 500, bottom: 20), // Ajuste a quantidade conforme necessário
        child: ListView(
          shrinkWrap: true,
          children: [
            ExpenseItem(category: 'Alimentação'),
            ExpenseItem(category: 'Transporte'),
            ExpenseItem(category: 'Lazer'),
            ExpenseItem(category: 'Saúde'),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    //definicao do titulo e estilizacao dele
    title: const Text(
      'Expense Tracker',
      style: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    backgroundColor: const Color.fromARGB(255, 143, 132, 132),
    elevation: 0.0,
    centerTitle: true,
    // definindo um detector de acoes ocorridas dentro da AppBar com suporte para adicao de metodos em cada interacao com um componente
    leading: GestureDetector(
      onTap: () {
        // switch pro dark mode
      },
      child: Container(
        margin: const EdgeInsets.all(18),
        alignment: Alignment.center,
        // usando um asset que importamos para ser o icone dessa parte da appBar
        child: SvgPicture.asset(
          'assets/icons/dark-theme.svg',
          height: 25,
          width: 25,
        ),
        decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10)),
      ),
    ),
    // aqui as acoes sao definidas em formato de lista
    actions: [
      GestureDetector(
        onTap: () {
          // acoes a serem executadas ao clicar no icone de perfil
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 37,
          child: SvgPicture.asset(
            'assets/icons/profile.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
    ],
  );
}

// quando o usario for inserir numa nova despesa, ele deve clicar no botao que chama esse metodo
void openExpenseBox(BuildContext context) {
  // Variáveis para armazenar os valores inseridos pelo usuário
  String expenseName = '';
  double expenseValue = 0.0;
  DateTime selectedDate = DateTime.now();

  TextEditingController dateController = TextEditingController(text: selectedDate.toString().split(' ')[0]);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Nova Despesa'),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TextField para inserir o nome da despesa
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                onChanged: (value) {
                  expenseName = value;
                },
              ),
              // TextField para inserir o valor da despesa
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  prefixText: 'R\$ ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  expenseValue = double.tryParse(value) ?? 0.0;
                },
              ),
              // TextField com um DatePicker para selecionar a data da despesa
              TextField(
                readOnly: true,
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Data',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                          dateController.text = pickedDate.toString().split(' ')[0];
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

class ExpenseItem extends StatelessWidget {
  final String category;
  double itemValue = 0.0;

  ExpenseItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openExpenseBox(context),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        ),
        child: Row(
          children: [
            Text(
              'R\$' + itemValue.toString(),
              style: TextStyle(fontSize: 18.0),
            ),
            Spacer(),
            Row(
              children: [
                getCategoryIcon(category),
                SizedBox(width: 16.0),
                Text(
                  category,
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}


Icon getCategoryIcon(String category) {
  switch (category) {
    case 'Lazer':
      return Icon(Icons.star); // Change the icon as per your preference
    case 'Saúde':
      return Icon(Icons.local_hospital);
    case 'Transporte':
      return Icon(Icons.directions_car);
    case 'Alimentação':
      return Icon(Icons.restaurant_menu);
    default:
      return Icon(Icons.category);
  }
}

// esse método cria a barra de navegação inferior, usado para navegar entre telas (Home e Histórico)
BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    backgroundColor: Color.fromARGB(255, 213, 203, 155),
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.pie_chart_sharp),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: 'Gastos Anteriores',
      ),
    ],
    onTap: (int index) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistoricalPage()),
        );
      }
    },
  );
}
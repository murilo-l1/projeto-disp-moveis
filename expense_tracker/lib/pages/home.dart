import 'package:expense_tracker/models/enums.dart';
import 'package:expense_tracker/pages/profile/Profile.dart';
import 'package:expense_tracker/pages/profile/components/customBottomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 40.0),
          Container(
            height: 300, // Adjust height as needed
            child: _PieChart(),
          ),
          SizedBox(height: 50.0),
          // Legend
          Legend(),
          SizedBox(height: 80.0),
          
          // ListView
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              shrinkWrap: true,
              children: [
                ExpenseItem(category: 'Alimentação'),
                ExpenseItem(category: 'Transporte'),
                ExpenseItem(category: 'Lazer'),
                ExpenseItem(category: 'Saúde'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: customBottomBarNav(selectedMenu: MenuState.pie_chart),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    //definicao do titulo e estilizacao dele
    title: const Text(
      'Gerenciee',
      style: TextStyle(
          
          color: Color.fromARGB(255, 238, 240, 245), fontSize: 22, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.blue[300],
    elevation: 0.0,
    centerTitle: true,
    // definindo um detector de acoes ocorridas dentro da AppBar com suporte para adicao de metodos em cada interacao com um componente
    actions: [
      GestureDetector(
        onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              ),
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 37,
          child: SvgPicture.asset(
            'assets/icons/profile.svg',
            height: 30,
            width: 30,
          ),
        ),
      ),
    ],
  );
}


// quando o usario for inserir numa nova despesa, essa funcao sera chamada
void openExpenseBox(BuildContext context) {
  // Variáveis para armazenar os valores inseridos pelo usuário
  String expenseName = '';
  double expenseValue = 0.0;
  DateTime selectedDate = DateTime.now();

  TextEditingController dateController =
      TextEditingController(text: selectedDate.toString().split(' ')[0]);

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
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
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
                    icon: const Icon(Icons.date_range),
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
                          dateController.text =
                              pickedDate.toString().split(' ')[0];
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
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fechar o AlertDialog somente, sem salvar infos
          },
          child: Text(
            'Cancelar',
            style: TextStyle(color: Colors.black54), // Texto mais opaco para o botão cancelar
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Lógica para salvar os dados vem aqui posteriormente
            Navigator.of(context).pop(); 
          },
          child: Text('Salvar'),
        ),
      ],
    ),
  );
}

class ExpenseItem extends StatelessWidget {
  final String category;
  double itemValue = 0.0;

  ExpenseItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openExpenseBox(context),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border(
             bottom: BorderSide(color: Color.fromARGB(255, 81, 83, 81),
            ), 
          ),
        ),
        child: Row(
          children: [
            Text(
              'R\$$itemValue',
              style: const TextStyle(fontSize: 18.0),
            ),
            const Spacer(),
            Row(
              children: [
                getCategoryIcon(category),
                const SizedBox(width: 16.0),
                Text(
                  category,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}

Icon getCategoryIcon(String category) {
  switch (category) {
    case 'Lazer':
      return Icon(CupertinoIcons.gamecontroller_fill);
    case 'Saúde':
      return const Icon(Icons.local_hospital);
    case 'Transporte':
      return const Icon(Icons.directions_car);
    case 'Alimentação':
      return const Icon(Icons.restaurant_menu);
    default:
      return const Icon(Icons.category);
  }
}

// gráfico de pizza das despesas
// isso daqui eventualmente tem que estar em outro lugar e procurar arrumar a posicao da legenda
class _PieChart extends StatelessWidget {
   _PieChart();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          'Despesas',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            ),
        ),
        // Pie Chart
        PieChart(
          swapAnimationDuration: Duration(milliseconds: 750),
          swapAnimationCurve: Curves.easeInOut,
          PieChartData(
            sections: [
              // saúde
              PieChartSectionData(
                value: 20, // esses valores serao mudados pela soma total na parte 2
                color: Color.fromARGB(255, 164, 76, 76),
                radius: 80,
                borderSide: BorderSide(color: Colors.black, width: 0.5),
                title: '20%'
                ),
              // lazer
              PieChartSectionData(
                value: 20,
                color: Color.fromARGB(255, 212, 151, 85),
                radius: 80,
                borderSide: BorderSide(color: Colors.black, width: 0.5),
                title: '20%'
                ),
              // transporte
              PieChartSectionData(
                value: 15,
                color: Color.fromARGB(255, 19, 108, 181),
                radius: 80,
                borderSide: BorderSide(color: Colors.black, width: 0.5),
                title: '15%'
              ),
              // alimentação
              PieChartSectionData(
                value: 20,
                color: Color.fromARGB(255, 109, 192, 114),
                radius: 80,
                borderSide: BorderSide(color: Colors.black, width: 0.5),
                title: '20%'
                ),
            ],
          ),
        ),
        ],
  );
  }
}

class Legend extends StatelessWidget {
  const Legend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Legend items
        LegendItem(
          color: Color.fromARGB(255, 164, 76, 76),
          title: 'Saúde',
        ),
        LegendItem(
          color: Color.fromARGB(255, 212, 151, 85),
          title: 'Lazer',
        ),
        LegendItem(
          color: Color.fromARGB(255, 19, 108, 181),
          title: 'Transporte',
        ),
        LegendItem(
          color: Color.fromARGB(255, 109, 192, 114),
          title: 'Alimentação',
        ),
      ],
    );
  }
}

// Selecao das legendas que vao ficar do lado do grafico, essa é a box delas
class LegendItem extends StatelessWidget {
  final Color color;
  final String title;

  const LegendItem({Key? key, required this.color, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          color: color,
        ),
        SizedBox(width: 5),
        Text(title),
      ],
    );
  }
}
import 'package:expense_tracker/pages/historical.dart';
import 'package:expense_tracker/pages/profile/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:expense_tracker/charts/pie_chart.dart';
import 'package:expense_tracker/pages/profile/Profile.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          // Pie Chart Widget
          Positioned(
            top: 100,
            right: 0,
            left: 0,
            height: 300, // Adjust height as needed
            child: Container(
               child: _PieChart(),
            ),
          ),
          // ListView
          Positioned.fill(
            top: 500, // Adjust top position to leave space for the pie chart
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
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
          ),
        ],
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
    backgroundColor: const Color.fromARGB(255, 33, 58, 69),
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
            height: 20,
            width: 20,
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

// esse método cria a barra de navegação inferior, usado para navegar entre telas (Home e Histórico)
// a animação entre troca de telas pode ser mais fluida e manter a aba atual selecionada
BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    backgroundColor: const Color.fromARGB(255, 33, 58, 69),
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.pie_chart_sharp),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chart_bar_fill),
        label: 'Gastos Anteriores',
      ),
    ],
    onTap: (int index) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HistoricalPage()),
        );
      }
    },
  );
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
                //radius: BorderSide.strokeAlignInside

               ),
              // lazer
              PieChartSectionData(
                value: 20,
                color: Color.fromARGB(255, 212, 151, 85),
                
                ),
              // transporte
              PieChartSectionData(
                value: 15,
                color: Color.fromARGB(255, 19, 108, 181),
                
              ),
              // alimentação
              PieChartSectionData(
                value: 20,
                color: Color.fromARGB(255, 109, 192, 114),
                
                ),
            ],
          ),
        ),
        // Legendas
        Positioned(
          left: 20,
          top: 0,
          bottom: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Legend items
              LegendItem(color: Color.fromARGB(255, 164, 76, 76), title: 'Saúde'),
              LegendItem(color: Color.fromARGB(255, 212, 151, 85), title: 'Lazer'),
              LegendItem(color: Color.fromARGB(255, 19, 108, 181), title: 'Transporte'),
              LegendItem(color: Color.fromARGB(255, 109, 192, 114), title: 'Alimentação'),
            ],
          ),
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
          width: 25,
          height: 25,
          color: color,
        ),
        SizedBox(width: 3),
        Text(title),
      ],
    );
  }
}
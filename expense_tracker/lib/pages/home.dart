import 'dart:js';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: ExpenseList(
        categories: [
          Category(nameCategory: 'Alimentação', valueCategory: 50.0),
          Category(nameCategory: 'Transporte', valueCategory: 30.0),
          Category(nameCategory: 'Lazer', valueCategory: 20.0),
          Category(nameCategory: 'Saúde', valueCategory: 40.0),
        ],
      ),
      floatingActionButton: floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

AppBar appBar(BuildContext context) {
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
        Scaffold.of(context).openEndDrawer();
      },
      child: Container(
        margin: const EdgeInsets.all(18),
        alignment: Alignment.center,
        // usando um asset que importamos para ser o icone dessa parte da appBar
        child: SvgPicture.asset(
          'assets/icons/hamburger.svg',
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

FloatingActionButton floatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      openExpenseBox(context);
    },
    child: const Icon(Icons.add),
    backgroundColor: const Color.fromARGB(255, 143, 132, 132),
  );
}

// quando o usario for inserir numa nova despesa, ele deve clicar no botao que chama esse metodo
void openExpenseBox(BuildContext context) {
  // Variável para armazenar a categoria selecionada
  String selectedCategory = '';
  double selectedValue = 0.0;
  DateTime selectedDate = DateTime.now();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Nova Despesa'),
      content: StatefulBuilder(
        // Utilizamos StatefulBuilder para reconstruir a caixa de diálogo ao selecionar uma categoria
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TextFields para Nome, Valor e Data da Despesa
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  prefixText: 'R\$ ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  selectedValue = double.tryParse(value)!;
                },
              ),
              TextField(
                readOnly: true,
                controller: TextEditingController(
                    text: selectedDate.toString().split(' ')[0]),
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
                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                ),
              ),
              // Opções de categoria como RadioListTiles
              ListTile(
                title: const Text('Alimentação'),
                leading: Radio(
                  value: 'Alimentação',
                  groupValue: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Transporte'),
                leading: Radio(
                  value: 'Transporte',
                  groupValue: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Lazer'),
                leading: Radio(
                  value: 'Lazer',
                  groupValue: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Saúde'),
                leading: Radio(
                  value: 'Saúde',
                  groupValue: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

class Category {
  final String nameCategory;
  final double valueCategory;
  Category({required this.nameCategory, required this.valueCategory});
}

class ExpenseList extends StatelessWidget {
  final List<Category> categories;

  ExpenseList({required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: _getIcon(categories[index].nameCategory),
          title: Text(categories[index].nameCategory),
          subtitle:
              Text('R\$ ${categories[index].valueCategory.toStringAsFixed(2)}'),
        );
      },
    );
  }

  // Método para obter o ícone com base na categoria da despesa
  Icon _getIcon(String category) {
    switch (category) {
      case 'Alimentação':
        return Icon(Icons.fastfood);
      case 'Transporte':
        return Icon(Icons.directions_car);
      case 'Lazer':
        return Icon(Icons.local_activity);
      case 'Saúde':
        return Icon(Icons.local_hospital);
      default:
        return Icon(Icons.category);
    }
  }
}

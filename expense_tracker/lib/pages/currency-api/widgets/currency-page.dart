import 'package:expense_tracker/pages/currency-api/services/api_client.dart';
import 'package:expense_tracker/pages/currency-api/widgets/currencies-drop-down.dart';
import 'package:expense_tracker/pages/home.dart';
import 'package:expense_tracker/pages/profile/components/customBottomBar.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/enum/enums.dart';

class CurrencyPage extends StatefulWidget {
  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  ApiClient apiClient = ApiClient();
  // Setting the color of the page
  Color mainColor = Colors.white;
  Color secondaryColor = const Color(0xFF292929);
  List<String>? currencies;

  String? from;
  String? to;

  // Variables to store the conversion rate
  double? rate; // Static conversion rate
  String result = "";

  @override
  void initState() {
    super.initState();
    (() async {
      List<String> list = await apiClient.getCurrencies();
      setState(() {
        currencies = list;
        from = list.isNotEmpty ? list[148] : null;
        to = list.isNotEmpty ? list[19] : null;
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                child: Text(
                  'EasyConvert',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Icon(
                Icons.currency_exchange,
                color: Colors.black,
                size: 70.0,
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Input field for amount
                      Flexible(
                        child: TextField(
                          onSubmitted: (value) async {
                            if (from != null && to != null) {
                              rate = await apiClient.getConversionRate(from!, to!);
                              setState(() {
                                result = (rate! * double.parse(value)).toStringAsFixed(3);
                              });
                            } else {
                              throw Exception("From or to are not set!");
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[300],
                            labelText: "Insira o valor a ser convertido:",
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 22.0,
                              color: Colors.black,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Dropdown for selecting 'from' currency
                          if (currencies != null)
                            customDropDown(currencies!, from ?? "", (val) {
                              setState(() {
                                from = val;
                              });
                            }),
                          FloatingActionButton(
                            foregroundColor: Colors.grey[200],
                            onPressed: () {
                              if (from != null && to != null) {
                                String temp = from!;
                                setState(() {
                                  from = to;
                                  to = temp;
                                });
                              }
                            },
                            child: const Icon(Icons.swap_horiz),
                            elevation: 0.0,
                            backgroundColor: secondaryColor,
                          ),
                          // Dropdown for selecting 'to' currency
                          if (currencies != null)
                            customDropDown(currencies!, to ?? "", (val) {
                              setState(() {
                                to = val;
                              });
                            }),
                        ],
                      ),
                      const SizedBox(height: 50.0),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Resultado",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              result,
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 36.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const customBottomBarNav(selectedMenu: MenuState.currency),
    );
  }
}
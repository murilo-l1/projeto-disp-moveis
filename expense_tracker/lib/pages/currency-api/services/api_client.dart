import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient{
  // colocar apiKey assim que me liberarem!
  final Uri currencyURL = Uri.https("free.currconv.com", "/api/v7/currencies", {"apiKey": "b9bc622a2d94d5d33aa6"});
  
  Future<List<String>> getCurrencies() async{
    http.Response response = await http.get(currencyURL);
    if(response.statusCode == 200){
      var body = jsonDecode(response.body);
      var list = body["results"];
      List <String> currencies = (list.keys).toList();
      currencies.sort();
      print(currencies);
      return currencies;
  }else{
    throw Exception("Failed to load currencies");
  }
}

Future<double> getConversionRate(String from, String to) async{
  final Uri rateURL = Uri.http('free.currconv.com', '/api/v7/convert', 
  {
  'apiKey': 'b9bc622a2d94d5d33aa6', 
  'q': "${from}_${to}", 
  'compact': 'ultra'});
  http.Response response = await http.get(rateURL);
  if(response.statusCode == 200){
    var body = jsonDecode(response.body);
    var rate = body["${from}_${to}"];
    return rate;
  } 
  else{
    throw Exception("Failed to load conversion rate");
  }
}

}
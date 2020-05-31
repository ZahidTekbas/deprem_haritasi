import 'package:http/http.dart' as http;
import 'dart:convert';

getData()async{
  var apiUrl = "https://turkiyedepremapi.herokuapp.com/api?min=3.5";
  var response = await http.get(apiUrl);
  return await jsonDecode(response.body);
}

import 'dart:convert';
import 'dart:async';
import 'package:covid_app/Model/WorldStatesModel.dart';
import 'package:covid_app/services/utilities/api_url.dart';
import 'package:http/http.dart'as http;

class StatesServices 
{
  Future<WorldStatesModel> fetchWorldRecords()async
  {
     final response =await http.get(Uri.parse(AppUrl.worldstatesapi));
     
      if(response.statusCode == 200)
      {
        var data = jsonDecode(response.body);
        return WorldStatesModel.fromJson(data);
      }
      else{
        throw Exception('error occured');
        

      }
  }
  // ignore: prefer_typing_uninitialized_variables
  
  Future<List<dynamic>> fetchCountryRecords() async
  {
     
    final response= await http.get(Uri.parse(AppUrl.coutrieslist));
     
      if(response.statusCode==200)
      {
        var data;
        data= jsonDecode(response.body);
        return data;
      }
      else{
        throw Exception('error');
      }

  }
}


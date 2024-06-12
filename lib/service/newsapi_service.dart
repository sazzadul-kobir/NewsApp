
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/headline_models.dart';

class NewsApiService{

  String _url="https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=91fc0d34374340c59c376daab222b812";

  Future<HeadlineModel> FetchHeadlineData() async{
    final response= await http.get(Uri.parse(_url));

    if(response.statusCode==200){
      final body=jsonDecode(response.body);
      return HeadlineModel.fromJson(body);
    }
    throw Exception("Error");

  }


}
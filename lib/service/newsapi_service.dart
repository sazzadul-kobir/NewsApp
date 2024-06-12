
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/category_news_model.dart';
import 'package:newsapp/models/headline_models.dart';

class NewsApiService{



  Future<HeadlineModel> FetchHeadlineData({required String selectedName}) async{
    String _url="https://newsapi.org/v2/top-headlines?sources=${selectedName}&apiKey=91fc0d34374340c59c376daab222b812";
    final response= await http.get(Uri.parse(_url));

    if(response.statusCode==200){
      final body=jsonDecode(response.body);
      return HeadlineModel.fromJson(body);
    }
    throw Exception("Error");

  }


  Future<CategoryNewsModel> FetchCategoryNews({required String category}) async{
    String _url="https://newsapi.org/v2/everything?q=${category}&apiKey=91fc0d34374340c59c376daab222b812";
    final response= await http.get(Uri.parse(_url));

    if(response.statusCode==200){
      final body=jsonDecode(response.body);
      return CategoryNewsModel.fromJson(body);
    }
    throw Exception("Error");

  }




}
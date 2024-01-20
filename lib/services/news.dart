import 'dart:convert';

import 'package:news_app/model/articlemodel.dart';
import 'package:http/http.dart' as http;

class News{
  List<Articlemodel> news=[];

  Future<void> getnews()async{
    String url="https://newsapi.org/v2/everything?q=tesla&from=2023-12-18&sortBy=publishedAt&apiKey=1f7169242cf14be38b1995d2718de902";
    var response= await  http.get(Uri.parse(url));

    var jsondata=jsonDecode(response.body);
    if(jsondata['status']=='ok'){
      jsondata["articles"].forEach((element){
        if(element["urlToImage"]!=null&& element["description"]!=null){
          Articlemodel articlemodel=Articlemodel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urltoimage: element["urlToImage"],
            content: element["content"],
            author: element["author"],

          );
          news.add(articlemodel);
        }
      });
    }

  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/showcategory.dart';
import 'package:news_app/model/slidermodel.dart';

class Showcategorynews{
  List<Showcategorymodel> categories= [];

  Future<void> getcategoriesnews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=1f7169242cf14be38b1995d2718de902";
    var response = await http.get(Uri.parse(url));

    var jsondata = jsonDecode(response.body);
    if (jsondata['status'] == 'ok') {
      jsondata["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          Showcategorymodel categorymodel = Showcategorymodel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urltoimage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          categories.add(categorymodel);
        }
      });
    }
  }
}

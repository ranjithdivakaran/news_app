import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/slidermodel.dart';

class Sliders{
  List<Slidermodel> sliders = [];

  Future<void> getslider() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=1f7169242cf14be38b1995d2718de902";
    var response = await http.get(Uri.parse(url));

    var jsondata = jsonDecode(response.body);
    if (jsondata['status'] == 'ok') {
      jsondata["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          Slidermodel slidermodel = Slidermodel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urltoimage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          sliders.add(slidermodel);
        }
      });
    }
  }
}

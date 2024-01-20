import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/articlemodel.dart';
import 'package:news_app/model/slidermodel.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';

import 'articleview.dart';

class Allnews extends StatefulWidget {
  String news;
   Allnews({required this.news});

  @override
  State<Allnews> createState() => _AllnewsState();
}

class _AllnewsState extends State<Allnews> {

  List<Slidermodel> sliders = [];
  List<Articlemodel> articles = [];

  @override
  void initState() {

    getslider();
    getnews();
    super.initState();
  }

  getnews() async {
    News newclass = News();
    await newclass.getnews();
    articles = newclass.news;
    setState(() {

    });

  }

  getslider() async {
    Sliders slider = Sliders();
    await slider.getslider();
    sliders = slider.sliders;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news+"News"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: widget.news=="Breaking"?sliders.length:articles.length,
              itemBuilder: (context, index) {
                return Allnewssection(
                  title: widget.news=="Breaking"?sliders[index].title!:articles[index].title!,
                  desc:  widget.news=="Breaking"?sliders[index].description!:articles[index].description!,
                  image:  widget.news=="Breaking"?sliders[index].urltoimage!:articles[index].urltoimage!,
                  url:  widget.news=="Breaking"?sliders[index].url!:articles[index].url!,
                );
              })),
    );
  }
}

class Allnewssection extends StatelessWidget {
  String image, title, desc, url;

  Allnewssection(
      {required this.title,
        required this.image,
        required this.desc,
        required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Articleview(blogurl: url)));
      },
      child: Container(
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            maxLines: 2,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            desc,
            maxLines: 3,
          ),
          SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }
}
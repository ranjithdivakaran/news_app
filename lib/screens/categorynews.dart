import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/showcategory.dart';
import 'package:news_app/screens/articleview.dart';
import 'package:news_app/services/showcategory.dart';

class Categorynews extends StatefulWidget {
  String name;

  Categorynews({required this.name});

  @override
  State<Categorynews> createState() => _CategorynewsState();
}

class _CategorynewsState extends State<Categorynews> {
  List<Showcategorymodel> categories = [];

  bool _loading = true;

  @override
  void initState() {
    getnews();
    super.initState();
  }

  getnews() async {
    Showcategorynews showcategorynews = Showcategorynews();
    await showcategorynews.getcategoriesnews(widget.name.toLowerCase());
    categories = showcategorynews.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Showcategory(
                    title: categories[index].title!,
                    desc: categories[index].description!,
                    image: categories[index].urltoimage!,
                    url: categories[index].url!,
                  );
                }))
    );
  }
}

class Showcategory extends StatelessWidget {
  String image, title, desc, url;

  Showcategory(
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

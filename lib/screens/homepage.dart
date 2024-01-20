import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/articlemodel.dart';
import 'package:news_app/model/categorymodel.dart';
import 'package:news_app/model/slidermodel.dart';
import 'package:news_app/screens/allnews.dart';
import 'package:news_app/screens/articleview.dart';
import 'package:news_app/screens/categorynews.dart';
import 'package:news_app/services/data.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Categorymodel> categories = [];
  List<Slidermodel> sliders = [];
  List<Articlemodel> articles = [];
  bool _loading = true;

  int activeindex = 0;

  @override
  void initState() {
    categories = getcatagories();
    getslider();
    getnews();
    super.initState();
  }

  getnews() async {
    News newclass = News();
    await newclass.getnews();
    articles = newclass.news;
    setState(() {
      _loading = false;
    });
  }

  getslider() async {
    Sliders slider = Sliders();
    await slider.getslider();
    sliders = slider.sliders;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 8),
                      height: 70,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Categorytile(
                              categoryname: categories[index].categoryname,
                              image: categories[index].image,
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Breaking News",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Allnews(news:"Breaking" )));
                            },
                            child: Text(
                              "View All",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CarouselSlider.builder(
                      itemCount: 5,
                      itemBuilder: (context, index, realindex) {
                        String? res = sliders[index].urltoimage;
                        String? res1 = sliders[index].title;
                        return buildimage(res!, index, res1!);
                      },
                      options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          //viewportFraction: 1,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeindex = index;
                            });
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: buildindicator(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Trending News",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Allnews(news:"Trending" )));
                            },
                            child: Text(
                              "View All",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              return Blogtile(
                                  url: articles[index].url!,
                                  title: articles[index].title!,
                                  desc: articles[index].description!,
                                  imageurl: articles[index].urltoimage!);
                            }))
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildimage(
    String image,
    int index,
    String name,
  ) =>
      Container(
        margin: EdgeInsets.all(10),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 250,
              width: MediaQuery.of(context).size.width,
              imageUrl: image,
            ),
          ),
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 110),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(9),
                  bottomRight: Radius.circular(9)),
            ),
            child: Text(
              name,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]),
      );

  Widget buildindicator() => AnimatedSmoothIndicator(
      activeIndex: activeindex,
      count: 5,
      effect: SlideEffect(
          dotWidth: 10, dotHeight: 10, activeDotColor: Colors.blue));
}

class Categorytile extends StatelessWidget {
  final image, categoryname;

  Categorytile({this.categoryname, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categorynews(name: categoryname)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                width: 120,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Center(
                  child: Text(
                categoryname,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class Blogtile extends StatelessWidget {
  String imageurl, title, desc, url;

  Blogtile(
      {required this.title,
      required this.desc,
      required this.imageurl,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Articleview(blogurl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      child: CachedNetworkImage(
                        imageUrl: imageurl,
                        height: 100,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          desc,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

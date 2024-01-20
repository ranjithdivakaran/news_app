import 'package:flutter/material.dart';
import 'package:news_app/screens/homepage.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "Assets/images/business.jpg",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 1.4,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(height: 10,),
            Text("News from around the\n       world for you"),
            SizedBox(height: 10,),
            Text("News from around the world for you"),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Homepage()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                // height: 70,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                child: Center(
                  child: Text("Get Started",style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Articleview extends StatefulWidget {
  String blogurl;
   Articleview({required this.blogurl});

  @override
  State<Articleview> createState() => _ArticleviewState();
}

class _ArticleviewState extends State<Articleview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: WebView(
            initialUrl:widget.blogurl,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}

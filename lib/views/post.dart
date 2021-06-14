import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Post extends StatefulWidget {
  final String imageUrl, title, desc;
  const Post({required this.title, required this.desc, required this.imageUrl});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget postContent(content) {
    return Html(
      data: htmlContent, // optional, type String
      onLaunchFail: (url) {
        // optional, type Function
        print("launch $url failed");
      },
      scrollable: false,
    );
  }

  Widget postContent(htmlContent) {
    return Html(
      data: htmlContent, // optional, type String
      onLaunchFail: (url) {
        // optional, type Function
        print("launch $url failed");
      },
      scrollable: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.imageUrl != null
                  ? Image.network(widget.imageUrl)
                  : Container(),
              SizedBox(height: 8),
              Text(
                widget.title,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 6),
              postContent(
                widget.desc,
              )
            ],
          ),
        ),
      ),
    );
  }
}

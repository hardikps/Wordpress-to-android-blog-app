import 'package:flutter/material.dart';
import 'package:petara/wp-api.dart';
import 'package:petara/views/post.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlutterNerd"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 24),
        child: FutureBuilder(
          future: fetchWpPosts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map wppost = snapshot.data[index];
                    return PostTile(
                        imageApiUrl: wppost['_links']["wp:featuredmedia"][0]
                            ["href"],
                        excerpt: removeAllHtmlTags(wppost['excerpt']['rendered']
                            .replaceAll("&#8217;", "")),
                        desc: wppost['content']['rendered'],
                        title: wppost['title']['rendered']
                            .replaceAll("#038;", ""));
                  });
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class PostTile extends StatefulWidget {
  final String imageApiUrl, title, desc, excerpt;
  const PostTile(
      {required this.imageApiUrl,
      required this.title,
      required this.desc,
      required this.excerpt});

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (imageUrl != "") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Post(
                        title: widget.title,
                        imageUrl: imageUrl,
                        desc: widget.desc,
                      )));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: fetchWpPostImageUrl(widget.imageApiUrl),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    imageUrl = snapshot.data["guid"]["rendered"];
                    return Image.network(imageUrl);
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            SizedBox(height: 8),
            Text(
              widget.title,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(widget.excerpt)
          ],
        ),
      ),
    );
  }
}

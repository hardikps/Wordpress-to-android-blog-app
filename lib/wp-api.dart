import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchWpPosts() async {
  final response = await http.get(
      Uri.parse("https://marathipetara.com/index.php/wp-json/wp/v2/posts"),
      headers: {"Accept": "application/json"});

  var converteDataJson = jsonDecode(response.body);
  return converteDataJson;
}

Future fetchWpPostImageUrl(href) async {
  final response =
      await http.get(Uri.parse(href), headers: {"Accept": "application/json"});

  var converteDataJson = jsonDecode(response.body);
  return converteDataJson;
}

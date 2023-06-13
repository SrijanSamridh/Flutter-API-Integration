import 'package:api_integration/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<List<Post>> fetchPost() async {
    var response = await client.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString);
    } else {
      return [];
    }
  }
}

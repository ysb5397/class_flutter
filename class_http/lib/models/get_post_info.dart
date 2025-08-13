import 'package:http/http.dart' as http;

void main() {}

Future<http.Response> getPostInfo() async {
  String url = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(Uri.parse(url));
  return response;
}

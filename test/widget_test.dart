import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ongkir/app/data/models/user_model.dart';

void main() async {
  Uri url = Uri.parse("https://reqres.in/api/users");
  // final response = await http.get(url);
  final responsePost =
      await http.post(url, body: {"name": "ratri", "job": "IRT"});

  // final data = (json.decode(response.body) as Map<String, dynamic>)["data"]
  //     as Map<String, dynamic>;

  // print(data["first_name"]);
  print(responsePost.body);
  // print((json.decode(response.body) as Map<String, dynamic>)["data"]);

  // final user =
  //     UserModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
  // final data = user.data;
  // // final support = user.support;

  // print("${data!.firstName} ${data.lastName}");
}

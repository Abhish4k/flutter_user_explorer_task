import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_models/user_model.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  Future<dynamic> fetchUsers({int? id}) async {
    try {
      final url = id == null ? '$baseUrl/users' : '$baseUrl/users/$id';
      print('[API] Fetching data from: $url');
      final response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      );
      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print(' Response Body: ${response.body}');
        final data = jsonDecode(response.body);
        // checking response type
        if (data is List) {
          // For List of users we convert each element of list into dart object
          return data.map((e) => UserModel.fromJson(e)).toList();
        } else if (data is Map<String, dynamic>) {
          // For Single user we convert direclty
          return UserModel.fromJson(data);
        } else {
          throw Exception('Unexpected data type');
        }
      } else {
        throw Exception('Failed to fetch: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API error: $e');
    }
  }
}

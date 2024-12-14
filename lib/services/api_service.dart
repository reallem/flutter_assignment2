import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  String categoriesUrl =
      'https://www.themealdb.com/api/json/v1/1/categories.php';
  String mealsUrl =
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=';

  Future<List<dynamic>?> fetchCategories() async {
    final response = await http.get(Uri.parse(categoriesUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['categories'];
    } else {
      return null; // Return null if API call fails
    }
  }

  Future<List<dynamic>?> fetchMeals(String category) async {
    final response = await http.get(Uri.parse('$mealsUrl$category'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['meals'];
    } else {
      return null; // Return null if API call fails
    }
  }
}
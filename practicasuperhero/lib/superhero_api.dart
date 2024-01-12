import 'dart:convert';
import 'package:http/http.dart' as http;

class SuperheroApi {
  final String baseUrl =
      'https://www.superheroapi.com/api.php/1756437904858215';

  Future<List<dynamic>> searchHeroes(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search/$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Error al realizar la solicitud a la API');
    }
  }

  Future<Map<String, dynamic>> getHeroDetails(int heroId) async {
    final response = await http.get(Uri.parse('$baseUrl/$heroId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Error al realizar la solicitud a la API');
    }
  }
}

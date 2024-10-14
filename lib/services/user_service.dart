import 'package:prueba_desis/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Clase que maneja la comunicación con la API para obtener datos de usuarios.
class UserService {
  final String apiUrl = "https://randomuser.me/api/";

  // Función que permite obtener un usuario desde una API, para la conexión se utilizo la dependencia http
  Future<User?> fetchUser() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final userJson = json['results'][0];
      return User.fromJson(userJson);
    }
    return null;
  }
}

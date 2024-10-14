// Clase que representa a la entidad usuario
class User {
  final int? id;
  final String name;
  final String email;
  final String birthDate;
  final String address;
  final String password;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.address,
    required this.password,
  });

  // Crea una instancia de "User" a partir de json.
  factory User.fromJson(Map<String, dynamic> json) {
    String fullName =
        '${json['name']['first']} ${json['name']['last']}'; // Se combinan los datos del json obtenidos de la API
    String jsonAddress = '${json['location']['country']}';
    String birthDate = json['dob']['date'];

    return User(
      id: null,
      name: fullName,
      email: json['email'],
      birthDate: birthDate,
      address: jsonAddress,
      password: json['login']['password'],
    );
  }

  // Convierte la instancia de un "User" a un json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'birthDate': birthDate,
      'address': address,
      'password': password,
    };
  }
}

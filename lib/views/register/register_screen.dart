import 'package:flutter/material.dart';
import 'package:prueba_desis/widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de usuario"),
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        children: [
          CustomButton(onPress: () {}, label: "Registrar", width: 150),
          CustomButton(
              onPress: () {}, label: "Obtener datos desde API", width: 150),
        ],
      ),
    );
  }
}

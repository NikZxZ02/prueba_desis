import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prueba_desis/models/user.dart';
import 'package:prueba_desis/services/user_service.dart';
import 'package:prueba_desis/views/register/widgets/data_table.dart';
import 'package:prueba_desis/widgets/custom_button.dart';
import 'package:prueba_desis/validators/form_validators.dart' as validators;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  String name = '';
  String email = '';
  String password = '';
  String birthday = '';
  String address = '';
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  final userService = UserService();
  List<User> users = [];

  @override
  void initState() {
    loadUsers();
    super.initState();
  }

  void handleRegister() {
    print("Paso");
  }

  void loadUsers() {
    print("Paso");
  }

  void handleGetUser() async {
    final user = await userService.fetchUser();
    users.add(user!);
    setState(() {}); //TODO: Guardar el dato en la bd
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registro de usuario",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                  onSaved: (value) {
                    setState(() {
                      name = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                  validator: validators.nameValidator),
              TextFormField(
                  onSaved: (value) {
                    setState(() {
                      email = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                  ),
                  validator: validators.emailValidator),
              TextFormField(
                onSaved: (value) {
                  setState(() {
                    address = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                ),
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: "Fecha de Nacimiento",
                ),
                readOnly: true,
                onTap: _onSelectedDate,
                validator: validators.birthdayValidator,
              ),
              TextFormField(
                  onSaved: (value) {
                    setState(() {
                      password = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                  ),
                  validator: validators.passwordValidator),
              CustomButton(
                  onPress: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      handleRegister();
                    }
                  },
                  label: "Registrar",
                  width: 150),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                  onPress: () {
                    handleGetUser();
                  },
                  label: "Obtener datos desde API",
                  width: 250),
              DataTableWidget(users: users)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSelectedDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale("es", "ES"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2025));

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    } else {
      setState(() {
        _dateController.text = "Fecha de nacimiento";
      });
    }
  }
}

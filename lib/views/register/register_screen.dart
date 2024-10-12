import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prueba_desis/db/database.dart';
import 'package:prueba_desis/models/user.dart';
import 'package:prueba_desis/services/user_service.dart';
import 'package:prueba_desis/views/register/widgets/data_table.dart';
import 'package:prueba_desis/widgets/custom_button.dart';
import 'package:prueba_desis/validators/form_validators.dart' as validators;
import 'package:prueba_desis/widgets/message_status.dart';

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
  final userService = UserService();
  List<User> users = [];
  DBSqlite database = DBSqlite();
  bool isLoading = false;

  @override
  void initState() {
    loadUsers();
    super.initState();
  }

  void setIsLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void handleRegister() async {
    User user = User(
      name: name,
      email: email,
      birthDate: _dateController.text,
      address: address,
      password: password,
    );
    database.insertUser(user);
    MessagesStatus.successMessage(context, "Usuario registrado con exito");
    await loadUsers();
  }

  Future<void> loadUsers() async {
    final usersData = await database.getUsers();
    setState(() {
      users = usersData;
    });
  }

  void handleGetUser() async {
    setIsLoading(true);
    final user = await userService.fetchUser();
    await database.insertUser(user!);
    loadUsers();
    setIsLoading(false);
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
                width: 250,
                isLoading: isLoading,
                isDisabled: isLoading,
              ),
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
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }
}

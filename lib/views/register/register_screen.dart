import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prueba_desis/db/database.dart';
import 'package:prueba_desis/models/user.dart';
import 'package:prueba_desis/services/user_service.dart';
import 'package:prueba_desis/views/register/widgets/custom_texfield.dart';
import 'package:prueba_desis/views/register/widgets/data_table.dart';
import 'package:prueba_desis/widgets/custom_button.dart';
import 'package:prueba_desis/validators/form_validators.dart' as validators;
import 'package:prueba_desis/widgets/message_status.dart';

// Vista que permite registrar un usuario a travez de un formulario y guardarlo en la base de datos
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final userService = UserService();
  List<User> users = [];
  DBSqlite database = DBSqlite();
  bool isLoading = false;

  @override
  void initState() {
    loadUsers();
    super.initState();
  }

  //Función que permite cambiar el estado de la variable isLoading
  void setIsLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  //Función que permite registrar un usuario segun los datos proporcionados en el formulario, este registro se guarda en la base de datos local realizada en SQLite
  void handleRegister() async {
    User user = User(
      name: _nameController.text,
      email: _emailController.text,
      birthDate: _dateController.text,
      address: _addressController.text,
      password: _passwordController.text,
    );
    database.insertUser(user);
    MessagesStatus.showStatusMessage(
        context, "Usuario registrado con exito", false);
    await loadUsers();
    _nameController.clear();
    _emailController.clear();
    _dateController.clear();
    _addressController.clear();
    _passwordController.clear();
  }

  //Obtiene los usuarios guardados en la base de datos
  Future<void> loadUsers() async {
    final usersData = await database.getUsers();
    setState(() {
      users = usersData;
    });
  }

  //Se obtiene un usuario desde la API y lo agrega en la base de datos para luego mostrarlo en la tabla
  void handleGetUser() async {
    setIsLoading(true);
    try {
      final user = await userService.fetchUser();
      await database.insertUser(user!);
      loadUsers();
      if (mounted) {
        MessagesStatus.showStatusMessage(
            context, "Usuario obtenido con exito", false);
      }
    } catch (error) {
      log("Ocurrio un error al obtener el usuario");
      if (mounted) {
        MessagesStatus.showStatusMessage(
            context, "El usuario no pudo ser obtenido", true);
      }
    } finally {
      setIsLoading(false);
    }
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
            children: [
              CustomTextFormField(
                  controller: _nameController,
                  label: "Nombre Completo",
                  validator: (value) =>
                      validators.nameValidator(context, value)),
              CustomTextFormField(
                  controller: _emailController,
                  label: "Correo Electrónico",
                  validator: (value) =>
                      validators.emailValidator(value, context)),
              CustomTextFormField(
                  controller: _addressController,
                  label: "Dirección",
                  validator: validators.addressValidator),
              CustomTextFormField(
                  controller: _dateController,
                  label: "Fecha de Nacimiento",
                  onTap: _onSelectedDate,
                  readOnly: true,
                  validator: validators.birthdayValidator),
              CustomTextFormField(
                  controller: _passwordController,
                  label: "Contraseña",
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
                height: 5,
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

import 'package:flutter/material.dart';
import 'package:prueba_desis/widgets/message_status.dart';

String? emailValidator(String? value, BuildContext context) {
  if (value == null || value.trim().isEmpty) {
    MessagesStatus.showEmptyFieldError(context, "Correo");
    return 'El campo correo es obligatorio';
  }
  if (!value.contains('@') || !value.contains('.')) {
    return 'Por favor ingrese un correo válido';
  }
  if (value.contains(' ')) {
    return 'El correo no puede contener espacios en blanco';
  }
  return null;
}

String? nameValidator(BuildContext context, String? value) {
  if (value == null || value.isEmpty) {
    MessagesStatus.showEmptyFieldError(context, "Nombre");
    return null;
  }
  if (value.length < 10) {
    return 'El nombre debe tener al menos 10 caracteres';
  }
  return null;
}

String? addressValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'El campo dirección es obligatorio';
  }
  return null;
}

String? birthdayValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'El campo fecha de nacimiento es obligatorio';
  }
  if (value == 'Fecha de nacimiento') {
    return 'El campo fecha de nacimiento es obligatorio';
  }
  if (!value.contains(RegExp(r'^\d{4}-\d{2}-\d{2}$'))) {
    return 'Ingrese una fecha válida en el formato YYYY-MM-DD';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'El campo contraseña es obligatorio';
  }
  if (value.length < 6) {
    return 'La contraseña debe tener al menos 6 caracteres';
  }
  return null;
}

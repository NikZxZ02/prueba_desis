String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Por favor ingrese el correo';
  }
  if (!value.contains('@') || !value.contains('.')) {
    return 'Por favor ingrese un correo válido';
  }
  if (value.contains(' ')) {
    return 'El correo no puede contener espacios en blanco';
  }
  return null;
}

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingrese el nombre';
  }
  if (value.length < 10) {
    return 'La contraseña debe tener al menos 10 caracteres';
  }
  return null;
}

String? birthdayValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingrese la fecha de nacimiento';
  }
  if (value == 'Fecha de nacimiento') {
    return 'Por favor ingrese la fecha de nacimiento';
  }
  if (!value.contains(RegExp(r'^\d{4}-\d{2}-\d{2}$'))) {
    return 'Ingrese una fecha válida en el formato YYYY-MM-DD';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingrese la contraseña';
  }
  if (value.length < 6) {
    return 'La contraseña debe tener al menos 6 caracteres';
  }
  return null;
}

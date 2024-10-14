import 'package:flutter/material.dart';

class MessagesStatus {
  //Función que muestra un mensaje en el fondo de la pantalla
  static void showStatusMessage(
      BuildContext context, String status, bool isError) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: isError ? Colors.red[300] : Colors.green[300],
        content: Text(
          status,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        action: SnackBarAction(
            label: 'Ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  //Función que muestra un mensaje "Dialog" cuando un campo del formulario esta vacio
  static void showEmptyFieldError(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Campo Obligatorio',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text('El campo $error es obligatorio'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}

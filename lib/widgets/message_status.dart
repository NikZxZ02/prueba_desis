import 'package:flutter/material.dart';

class MessagesStatus {
  //Función que muestra un mensaje en el fondo de la pantalla
  static void successMessage(BuildContext context, String status) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.green[300],
        content: Text(
          status,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        action: SnackBarAction(
            label: 'Ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}

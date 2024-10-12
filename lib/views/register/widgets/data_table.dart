import 'package:flutter/material.dart';
import 'package:prueba_desis/models/user.dart';

// Widget que muestra una tabla de usuarios.
class DataTableWidget extends StatefulWidget {
  const DataTableWidget({super.key, required this.users});
  final List<User> users;

  @override
  State<DataTableWidget> createState() => _DataTableState();
}

class _DataTableState extends State<DataTableWidget> {
  int rowsPerPage = 5;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dataTableTheme: const DataTableThemeData(
          headingRowColor: MaterialStatePropertyAll(Colors.blue),
          headingTextStyle: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      child: PaginatedDataTable(
        availableRowsPerPage: const [5, 10, 15],
        showCheckboxColumn: true,
        rowsPerPage: rowsPerPage,
        arrowHeadColor: Colors.blue,
        columns: const [
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Correo')),
          DataColumn(label: Text('Fecha Nacimiento')),
        ],
        onRowsPerPageChanged: (newRowsPerPage) {
          setState(() {
            rowsPerPage = newRowsPerPage!;
          });
        },
        source: _DataSource(widget.users),
      ),
    );
  }
}

// Fuente de datos para la tabla que permite manejar la paginación y el acceso a los datos de los usuarios guardados en la base de datos.
class _DataSource extends DataTableSource {
  final List<User> _users;

  _DataSource(this._users);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    final user = _users[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.name)),
        DataCell(Text(user.email)),
        DataCell(Text(user.birthDate.split('T')[0])),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _users.length;

  @override
  int get selectedRowCount => 0;
}

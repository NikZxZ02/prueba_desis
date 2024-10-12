import 'package:flutter/material.dart';
import 'package:prueba_desis/models/user.dart';

class DataTableWidget extends StatefulWidget {
  const DataTableWidget({super.key, required this.users});
  final List<User> users;

  @override
  State<DataTableWidget> createState() => _DataTableState();
}

class _DataTableState extends State<DataTableWidget> {
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
        rowsPerPage: 5,
        arrowHeadColor: Colors.blue,
        columns: const [
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Correo')),
          DataColumn(label: Text('Fecha Nacimiento')),
        ],
        source: _DataSource(widget.users),
      ),
    );
  }
}

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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restru/state/tablestate.dart';
import 'package:restru/widgets/add_drawer.dart';
import 'package:restru/widgets/singleTable.dart';

class TableScreen extends StatefulWidget {
  static const routeName = '/table';

  const TableScreen({Key? key}) : super(key: key);

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  bool _init = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_init) {
      _isLoading = await Provider.of<TableState>(context, listen: false).getTables();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tables = Provider.of<TableState>(context).tables;

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Tables for Reservation"),
        backgroundColor: Colors.red.shade900,
      ),
      body: _isLoading
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 2,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: tables.length,
              itemBuilder: (ctx, i) => SingleTable(
                id: tables[i].id,
                tname: tables[i].tname,
                imagePath: tables[i].imagePath,
                reserve: tables[i].reserve,
                chairs: tables[i].chairs,
              ),
            )
          : Center(
              child: Text("Something is wrong. Try again!"),
            ),
    );
  }
}
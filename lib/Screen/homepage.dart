import 'package:flutter/material.dart';
import '../Database/helper.dart';
import '../Model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ModelClass1> list = [];
  final dbHelper = DatabaseHelper.instance;
  ModelClass1? model;

  @override
  void initState() {
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text("Ragistration Detail"),
          ),
            body: ListView.separated(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Name :-${list[index].name}'),
                    subtitle: Text('Email :-${list[index].email}'),
                    trailing: Text('Password :-${list[index].pass}'),
                    leading: Text(' Index :-${list[index].key.toString()}'),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 4,
                  thickness: 3,);
              },
            )
        ));
  }


  fetch() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) =>
    {
      model =
          ModelClass1(row["name"], row["email"], row["password"], row["_id"]),
      list.add(model!)
    });
    setState(() {

    });
  }
}

import 'package:database/Database/dbmanager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dbmanager dbmanagerr = Dbmanager();
  List<Student> studlist = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder<List<Student>>(
        future: dbmanagerr.getList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            studlist = snapshot.data!;
            return ListView.builder(
              itemCount: studlist.length,
              itemBuilder: (context, index) {
                Student st = studlist[index];

                return ListTile(
                  title: Text(st.user_id.toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }
}

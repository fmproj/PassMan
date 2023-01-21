import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passman/data/password.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Box<Password> _passwords = Hive.box('passwords');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetch(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: _passwords.length,
            itemBuilder: (context, index) {
              Password? data = _passwords.getAt(index);
              return ListTile(
                title: Text(data!.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.group),
                    Text(data.password),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

    Future _fetch() async {
    if (_passwords.values.isEmpty) {
      _passwords.add(Password('Password1', 'basic', 'heslo'));
      return Future.value(null);
    } else {
      return Future.value(_passwords.toMap());
    }
  }
}

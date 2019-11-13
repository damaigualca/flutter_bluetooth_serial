import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Center(
              child: const Text('Pacientes', style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold
              )),
            ),
          ),
          Column(
            children: <Widget>[
              Text("data"),
              Text("data")
            ],
          )
        ],
      ),
    );
  }
}
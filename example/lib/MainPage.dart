import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/src/models/persona.dart';
import 'package:flutter_bluetooth_serial_example/src/models/terapia.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/dashboard_page.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/profiles_page.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/settings_page.dart';
import 'package:flutter_bluetooth_serial_example/src/pages/stats_page.dart';
import 'package:flutter_bluetooth_serial_example/src/services/persona_service.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

//import './LineChart.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {

  int currentTab = 0;
  final List<Widget> screens = [
    DashboardPage(),
    StatPage(),
    ProfilePage(),
    SettingPage()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashboardPage(); // Our first view in viewport

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: (){
          Navigator.pushNamed(context, 'nueva_terapia');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = DashboardPage(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.dashboard, color: currentTab == 0 ? Colors.blue : Colors.grey,),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = StatPage(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.bubble_chart, color: currentTab == 1 ? Colors.blue : Colors.grey,),
                      ],
                    ),
                  )
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfilePage(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.people,color: currentTab == 2 ? Colors.blue : Colors.grey,),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = SettingPage(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.settings_bluetooth,color: currentTab == 3 ? Colors.blue : Colors.grey,),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      )
    );
  }
}

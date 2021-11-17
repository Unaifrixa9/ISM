import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica/widget/button_widget.dart';
import 'package:practica/widget/navigation_drawer_widget.dart';


class MainPage1 extends StatelessWidget {
  static final String title = 'GPS-Quest';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.lightBlue),
    home: MainPage(),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: NavigationDrawerWidget(),
    // endDrawer: NavigationDrawerWidget(),
    appBar: AppBar(
      title: Text(MainPage1.title),
    ),
    body: Builder(
      builder: (context) => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: ButtonWidget(
          icon: Icons.open_in_new,
          text: 'Abrir menú',
          onClicked: () {
            Scaffold.of(context).openDrawer();
            // Scaffold.of(context).openEndDrawer();
          },
        ),
      ),
    ),
  );
}
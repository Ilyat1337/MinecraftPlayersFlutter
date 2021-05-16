import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minecraft_players/src/pages/list_page.dart';
import 'package:minecraft_players/src/pages/map_page.dart';
import 'package:minecraft_players/src/pages/settings_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final tabs = <Widget>[
    ListPage(),
    MapPage(),
    SettingsPage()
  ];
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: Theme.of(context).primaryColor,
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: AppLocalizations.of(context).players
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: AppLocalizations.of(context).map
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppLocalizations.of(context).settings
          ),
        ],
      ),
    );
  }
}

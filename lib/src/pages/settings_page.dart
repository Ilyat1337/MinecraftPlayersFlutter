import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:minecraft_players/src/models/logged_user_model.dart';
import 'package:minecraft_players/src/models/settings_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        final settings = Provider.of<SettingsModel>(context, listen: true);
        return AlertDialog(
          title: Text(AppLocalizations.of(context).pickColor),
          content: BlockPicker(
            pickerColor: settings.color,
            onColorChanged: settings.setColor,
            availableColors: [
              Colors.red,
              Colors.pink,
              Colors.purple,
              Colors.deepPurple,
              Colors.indigo,
              Colors.blue,
              Colors.lightBlue,
              Colors.cyan,
              Colors.teal,
              Colors.green,
              Colors.lightGreen,
              Colors.lime,
              Colors.yellow,
              Colors.amber,
              Colors.orange,
              Colors.deepOrange,
              Colors.brown,
              Colors.grey,
              Colors.blueGrey,
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsModel>(context, listen: true);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(AppLocalizations.of(context).language),
                Spacer(),
                SizedBox(
                  width: 170,
                  child: DropdownButton(
                    value: settings.language,
                    onChanged: settings.setLanguage,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(value: 'en', child: Text('English')),
                      DropdownMenuItem(value: 'ru', child: Text('Русский')),
                    ]
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context).fontFamily),
                Spacer(),
                SizedBox(
                  width: 170,
                  child: DropdownButton(
                    value: settings.fontFamily,
                    onChanged: settings.setFontFamily,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(value: 'Roboto', child: Text('Roboto')),
                      DropdownMenuItem(value: 'AvenirNext', child: Text('AvenirNext')),
                      DropdownMenuItem(value: 'Helvetica', child: Text('Helvetica')),
                      DropdownMenuItem(value: 'Noteworthy', child: Text('Noteworthy')),
                    ]
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context).fontSize
                    + settings.fontSize.round().toString()),
                Spacer(),
                Slider(
                  value: settings.fontSize,
                  min: 14,
                  max: 24,
                  divisions: 10,
                  onChanged: settings.setFontSize,
                )
              ],
            ),
            GestureDetector(
              onTap: _showColorPicker,
              child: Row(
                children: [
                  Text(AppLocalizations.of(context).color),
                  Spacer(),
                  Icon(Icons.circle, color: settings.color, size: 35),
                ],
              ),
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context).darkTheme),
                Spacer(),
                Switch(
                  value: settings.isDarkTheme,
                  onChanged: settings.setIsDarkTheme
                )
              ],
            ),
            TextButton(
              onPressed: () {
                Provider.of<LoggedUserModel>(context, listen: false).logOut();
              },
              child: Text(AppLocalizations.of(context).logOut,
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}

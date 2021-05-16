import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minecraft_players/src/models/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef LocalizeFunction = String Function(BuildContext context);

class Utils {
  static Map<Object, LocalizeFunction> _localizeEnumMup = {
    OccupationType.survival : (context) => AppLocalizations.of(context).survival,
    OccupationType.redstone : (context) => AppLocalizations.of(context).redstone,
    OccupationType.building : (context) => AppLocalizations.of(context).building,
    OccupationType.pvp : (context) => AppLocalizations.of(context).pvp,
    OccupationType.mapArt : (context) => AppLocalizations.of(context).mapArt,
    OccupationType.speedrun : (context) => AppLocalizations.of(context).speedrun,
    OccupationType.hardcore : (context) => AppLocalizations.of(context).hardcore,
    PrivilegeType.player : (context) => AppLocalizations.of(context).player,
    PrivilegeType.moderator : (context) => AppLocalizations.of(context).moderator,
    PrivilegeType.admin : (context) => AppLocalizations.of(context).admin,
    PrivilegeType.vip : (context) => AppLocalizations.of(context).vip,
    PrivilegeType.vipPlus : (context) => AppLocalizations.of(context).vipPlus,
    PrivilegeType.mvp : (context) => AppLocalizations.of(context).mvp,
    PrivilegeType.mvpPlus : (context) => AppLocalizations.of(context).mvpPlus,
    MobType.creeper : (context) => AppLocalizations.of(context).creeper,
    MobType.zombie : (context) => AppLocalizations.of(context).zombie,
    MobType.skeleton : (context) => AppLocalizations.of(context).skeleton,
    MobType.spider : (context) => AppLocalizations.of(context).spider,
    MobType.enderman : (context) => AppLocalizations.of(context).enderman,
    MobType.blaze : (context) => AppLocalizations.of(context).blaze,
    MobType.slime : (context) => AppLocalizations.of(context).slime,
    MobType.magmaCube : (context) => AppLocalizations.of(context).magmaCube,
  };

  static String translateEnum(BuildContext context, Object enumValue) {
    return _localizeEnumMup[enumValue](context) ?? enumValue.toString();
  }

  static Future<Uint8List> fetchImageData(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    return response.bodyBytes;
  }

  static Future<void> showOkDialog(String title, String message,
      BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

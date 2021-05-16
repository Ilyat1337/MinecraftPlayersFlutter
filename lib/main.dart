import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minecraft_players/src/models/logged_user_model.dart';
import 'package:minecraft_players/src/models/settings_model.dart';
import 'package:minecraft_players/src/models/users_model.dart';
import 'package:minecraft_players/src/pages/main_page.dart';
import 'package:minecraft_players/src/pages/sign_in_page.dart';
import 'package:minecraft_players/src/services/auth_service.dart';
import 'package:minecraft_players/src/services/avatar_service.dart';
import 'package:minecraft_players/src/services/media_service.dart';
import 'package:minecraft_players/src/services/storage_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _registerServices();
  runApp(MinecraftPlayers());
}

void _registerServices() {
  final getIt = GetIt.I;
  getIt.registerSingleton(AvatarService());
  getIt.registerSingleton(AuthService());
  getIt.registerSingleton(StorageService());
  getIt.registerSingleton(MediaService());
}

class MinecraftPlayers extends StatelessWidget {
  // This widget is the root of your application.
  var dakThemeData;

  MinecraftPlayers() {
    dakThemeData = ThemeData.dark();//.copyWith(primaryColor: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoggedUserModel()),
        ChangeNotifierProvider(create: (context) =>
            UsersModel(GetIt.I.get<StorageService>())),
        ChangeNotifierProvider(create: (context) => SettingsModel())
      ],
      child: Consumer<SettingsModel>(
        builder: (context, settingsModel, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(settingsModel.language),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: settingsModel.color,
              fontFamily: settingsModel.fontFamily,
              inputDecorationTheme: InputDecorationTheme(
                focusColor: settingsModel.color,
                hintStyle: TextStyle(
                    color: settingsModel.color
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: settingsModel.color,
                  ),
                )
              ),
              textTheme: TextTheme(
                bodyText2: TextStyle(fontSize: settingsModel.fontSize),
                button: TextStyle(fontSize: settingsModel.fontSize),
                subtitle1: TextStyle(fontSize: settingsModel.fontSize)),
            ),
            theme: ThemeData(
              primarySwatch: settingsModel.color,
              fontFamily: settingsModel.fontFamily,
              textTheme: TextTheme(
                bodyText2: TextStyle(fontSize: settingsModel.fontSize),
                button: TextStyle(fontSize: settingsModel.fontSize),
                subtitle1: TextStyle(fontSize: settingsModel.fontSize))),
            themeMode: settingsModel.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            home: RoutingWidget() //MyHomePage(title: 'Flutter Demo Home Page'),
          );
        })
    );
  }
}

class RoutingWidget extends StatelessWidget {
  const RoutingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoggedUserModel>(
      builder: (context, loggedUserModel, child) {
        print("Checking user id");
        if (loggedUserModel.userId.isEmpty) {
          return SignInPage();
        } else {
          return MainPage();
        }
      },
    );
  }
}

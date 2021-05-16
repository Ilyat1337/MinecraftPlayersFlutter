// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Survival`
  String get survival {
    return Intl.message(
      'Survival',
      name: 'survival',
      desc: '',
      args: [],
    );
  }

  /// `Redstone`
  String get redstone {
    return Intl.message(
      'Redstone',
      name: 'redstone',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get building {
    return Intl.message(
      'Building',
      name: 'building',
      desc: '',
      args: [],
    );
  }

  /// `PvP`
  String get pvp {
    return Intl.message(
      'PvP',
      name: 'pvp',
      desc: '',
      args: [],
    );
  }

  /// `Map art`
  String get mapArt {
    return Intl.message(
      'Map art',
      name: 'mapArt',
      desc: '',
      args: [],
    );
  }

  /// `Speedrun`
  String get speedrun {
    return Intl.message(
      'Speedrun',
      name: 'speedrun',
      desc: '',
      args: [],
    );
  }

  /// `Hardcore`
  String get hardcore {
    return Intl.message(
      'Hardcore',
      name: 'hardcore',
      desc: '',
      args: [],
    );
  }

  /// `Player`
  String get player {
    return Intl.message(
      'Player',
      name: 'player',
      desc: '',
      args: [],
    );
  }

  /// `Moderator`
  String get moderator {
    return Intl.message(
      'Moderator',
      name: 'moderator',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message(
      'Admin',
      name: 'admin',
      desc: '',
      args: [],
    );
  }

  /// `VIP`
  String get vip {
    return Intl.message(
      'VIP',
      name: 'vip',
      desc: '',
      args: [],
    );
  }

  /// `VIP+`
  String get vipPlus {
    return Intl.message(
      'VIP+',
      name: 'vipPlus',
      desc: '',
      args: [],
    );
  }

  /// `MVP`
  String get mvp {
    return Intl.message(
      'MVP',
      name: 'mvp',
      desc: '',
      args: [],
    );
  }

  /// `MVP+`
  String get mvpPlus {
    return Intl.message(
      'MVP+',
      name: 'mvpPlus',
      desc: '',
      args: [],
    );
  }

  /// `Creeper`
  String get creeper {
    return Intl.message(
      'Creeper',
      name: 'creeper',
      desc: '',
      args: [],
    );
  }

  /// `Zombie`
  String get zombie {
    return Intl.message(
      'Zombie',
      name: 'zombie',
      desc: '',
      args: [],
    );
  }

  /// `Skeleton`
  String get skeleton {
    return Intl.message(
      'Skeleton',
      name: 'skeleton',
      desc: '',
      args: [],
    );
  }

  /// `Spider`
  String get spider {
    return Intl.message(
      'Spider',
      name: 'spider',
      desc: '',
      args: [],
    );
  }

  /// `Enderman`
  String get enderman {
    return Intl.message(
      'Enderman',
      name: 'enderman',
      desc: '',
      args: [],
    );
  }

  /// `Blaze`
  String get blaze {
    return Intl.message(
      'Blaze',
      name: 'blaze',
      desc: '',
      args: [],
    );
  }

  /// `Slime`
  String get slime {
    return Intl.message(
      'Slime',
      name: 'slime',
      desc: '',
      args: [],
    );
  }

  /// `Magma cube`
  String get magmaCube {
    return Intl.message(
      'Magma cube',
      name: 'magmaCube',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Sign up`
  String get noAccountMsg {
    return Intl.message(
      'Don\'t have an account? Sign up',
      name: 'noAccountMsg',
      desc: '',
      args: [],
    );
  }

  /// `Credentials`
  String get credentials {
    return Intl.message(
      'Credentials',
      name: 'credentials',
      desc: '',
      args: [],
    );
  }

  /// `Ingame`
  String get ingame {
    return Intl.message(
      'Ingame',
      name: 'ingame',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get nickname {
    return Intl.message(
      'Nickname',
      name: 'nickname',
      desc: '',
      args: [],
    );
  }

  /// `Favourite server`
  String get favouriteServer {
    return Intl.message(
      'Favourite server',
      name: 'favouriteServer',
      desc: '',
      args: [],
    );
  }

  /// `Server address`
  String get serverAddress {
    return Intl.message(
      'Server address',
      name: 'serverAddress',
      desc: '',
      args: [],
    );
  }

  /// `Real world`
  String get realWorld {
    return Intl.message(
      'Real world',
      name: 'realWorld',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `y.o.`
  String get yearsOld {
    return Intl.message(
      'y.o.',
      name: 'yearsOld',
      desc: '',
      args: [],
    );
  }

  /// `Players`
  String get players {
    return Intl.message(
      'Players',
      name: 'players',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Add image`
  String get addImage {
    return Intl.message(
      'Add image',
      name: 'addImage',
      desc: '',
      args: [],
    );
  }

  /// `Delete video`
  String get deleteVideo {
    return Intl.message(
      'Delete video',
      name: 'deleteVideo',
      desc: '',
      args: [],
    );
  }

  /// `Add video`
  String get addVideo {
    return Intl.message(
      'Add video',
      name: 'addVideo',
      desc: '',
      args: [],
    );
  }

  /// `Coordinates`
  String get coordinates {
    return Intl.message(
      'Coordinates',
      name: 'coordinates',
      desc: '',
      args: [],
    );
  }

  /// `Latitude`
  String get latitude {
    return Intl.message(
      'Latitude',
      name: 'latitude',
      desc: '',
      args: [],
    );
  }

  /// `Longitude`
  String get longitude {
    return Intl.message(
      'Longitude',
      name: 'longitude',
      desc: '',
      args: [],
    );
  }

  /// `Images`
  String get images {
    return Intl.message(
      'Images',
      name: 'images',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Pick a color`
  String get pickColor {
    return Intl.message(
      'Pick a color',
      name: 'pickColor',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Font family`
  String get fontFamily {
    return Intl.message(
      'Font family',
      name: 'fontFamily',
      desc: '',
      args: [],
    );
  }

  /// `Font size `
  String get fontSize {
    return Intl.message(
      'Font size ',
      name: 'fontSize',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get darkTheme {
    return Intl.message(
      'Dark theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Pick location`
  String get pickLocation {
    return Intl.message(
      'Pick location',
      name: 'pickLocation',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Occupation`
  String get occupation {
    return Intl.message(
      'Occupation',
      name: 'occupation',
      desc: '',
      args: [],
    );
  }

  /// `Favourite mob`
  String get favouriteMob {
    return Intl.message(
      'Favourite mob',
      name: 'favouriteMob',
      desc: '',
      args: [],
    );
  }

  /// `Privilege`
  String get privilege {
    return Intl.message(
      'Privilege',
      name: 'privilege',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
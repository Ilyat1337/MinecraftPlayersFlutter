import 'package:enum_to_string/enum_to_string.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum OccupationType {
  survival,
  redstone,
  building,
  pvp,
  mapArt,
  speedrun,
  hardcore,
}

enum PrivilegeType {
  player,
  moderator,
  admin,
  vip,
  vipPlus,
  mvp,
  mvpPlus
}

enum MobType {
  creeper,
  zombie,
  skeleton,
  spider,
  enderman,
  blaze,
  slime,
  magmaCube
}

class Position {
  final double latitude;
  final double longitude;

  Position(this.latitude, this.longitude);
}

class User {
  String id;
  String email;
  String password;

  String nickname;
  OccupationType occupation;
  MobType favouriteMob;

  String favouriteServerAddress;
  PrivilegeType privilege;

  String realworldName;
  String country;
  String city;
  int age;

  String avatarUrl;

  LatLng position;
  List<String> imageUrls = [];
  String videoUrl;

  User(
      this.id,
      this.email,
      this.password,
      this.nickname,
      this.occupation,
      this.favouriteMob,
      this.favouriteServerAddress,
      this.privilege,
      this.realworldName,
      this.country,
      this.city,
      this.age,
      this.avatarUrl);

  Map<String, dynamic> toData() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'nickname': nickname,
      'occupation': EnumToString.convertToString(occupation),
      'favouriteMob': EnumToString.convertToString(favouriteMob),
      'favouriteServerAddress': favouriteServerAddress,
      'privilege': EnumToString.convertToString(privilege),
      'realworldName': realworldName,
      'country': country,
      'city': city,
      'age': age,
      'avatarUrl': avatarUrl,
      'latitude': position?.latitude,
      'longitude': position?.longitude,
      'imageUrls': imageUrls,
      'videoUrl': videoUrl
    };
  }

  static User fromData(Map<String, dynamic> data) {
    var user = User(
        data['id'],
        data['email'],
        data['password'],
        data['nickname'],
        EnumToString.fromString(OccupationType.values, data['occupation']),
        EnumToString.fromString(MobType.values, data['favouriteMob']),
        data['favouriteServerAddress'].toString(),
        EnumToString.fromString<PrivilegeType>(PrivilegeType.values, data['privilege']),
        data['realworldName'],
        data['country'],
        data['city'],
        data['age'],
        data['avatarUrl']
    );

    if (data['latitude'] != null) {
      user.position = LatLng(data['latitude'], data['longitude']);
    }
    user.imageUrls = (data['imageUrls'] as List<dynamic>).cast<String>();
    user.videoUrl = data['videoUrl'];

    print("Converted user from data ${user.nickname}");

    return user;
  }
}

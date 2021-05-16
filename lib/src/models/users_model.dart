import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:minecraft_players/src/models/user.dart';
import 'package:minecraft_players/src/services/storage_service.dart';

class UsersModel extends ChangeNotifier {
  List<User> _users = [];
  UnmodifiableListView<User> get users => UnmodifiableListView(_users);
  StreamSubscription _subscription;

  UsersModel(StorageService storage) {
    _subscription = storage.subscribeOnChanges().listen((snapshot) {
      _users = snapshot.docs
          .map((doc) => User.fromData(doc.data()))
          .toList();
      _users.sort((u1, u2) => u1.nickname.compareTo(u2.nickname));
      // if (_users.length != 0) {
      //   _users[0].imageUrls = [
      //     "https://i.picsum.photos/id/429/150/300.jpg?hmac=Bh9wghd3kGclhTp0AmpMBonpCFpzEUCNGecLL7Sn7bI",
      //     "https://i.picsum.photos/id/22/300/300.jpg?hmac=hpHOD_a9-i6VAVANAhXPGG6fEyYK_-TNpMOM6aBQfgE",
      //     "https://i.picsum.photos/id/1012/300/150.jpg?hmac=eSEwHIgJQmTwGj3bbFui3Klo81t4jYYr61PxbqSht_0",
      //     "https://i.picsum.photos/id/429/150/300.jpg?hmac=Bh9wghd3kGclhTp0AmpMBonpCFpzEUCNGecLL7Sn7bI",
      //     "https://i.picsum.photos/id/22/300/300.jpg?hmac=hpHOD_a9-i6VAVANAhXPGG6fEyYK_-TNpMOM6aBQfgE",
      //     "https://i.picsum.photos/id/1012/300/150.jpg?hmac=eSEwHIgJQmTwGj3bbFui3Klo81t4jYYr61PxbqSht_0"
      //   ];
      //
      //   _users[0].videoUrl = 'https://bit.ly/swswift';
      // }
      notifyListeners();
    });
  }

  @override
  void dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}
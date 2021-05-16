import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minecraft_players/src/models/user.dart';

class StorageService {
  static const UsersCollectionName = 'users';
  final usersRef = FirebaseFirestore.instance.collection(UsersCollectionName);

  Stream<QuerySnapshot> subscribeOnChanges() {
    return usersRef.snapshots();
  }

  Future<void> addUser(User user) async {
    await usersRef.doc(user.id).set(user.toData());
  }

  Future<void> updateUser(User user) async {
    await usersRef.doc(user.id).update(user.toData());
  }
}
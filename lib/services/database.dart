import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  // on stoks les users
  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  // on enregistre un user
  Future<void> saveUser(String name, String email) async {
    //doc va créer un nouveau uid de databaseService
    return await userCollection.doc(uid).set({'name': name, 'email': email});
  }

  // crée et modifie un user
  Future<void> saveToken(String? token) async {
    return await userCollection.doc(uid).update({'token': token});
  }

  // on convertit un snapshot en user
  // snapshot est une réponse de firebase
  MyUserData _userFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return MyUserData(
      uid: snapshot.id,
      name: data['name'],
      email: data['email'],
    );
  }

  //stream qui récupre le user courant donc
  // besoin de doc(uid)
  Stream<MyUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  //querySnapshot peut contenir 0 ou plusieurs query de snapshot
  List<MyUserData> _userListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    // on parcours tout les docs et
    // on les convertie en user
    // on fait un toList car le map envoie un Iterable
    // alors que l'on veut une list
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  // on récupere tout les users
  Stream<List<MyUserData>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}

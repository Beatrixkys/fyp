import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/models/persona.dart';
import 'package:fyp/models/user.dart';

//Change to User Getter Class

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  //collection to store the users
  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference<Map<String, dynamic>> personaCollection =
      FirebaseFirestore.instance.collection("persona");

  final CollectionReference<Map<String, dynamic>> accountsCollection =
      FirebaseFirestore.instance.collection("accounts");
  //CREATE
  // we register a user
  Future<void> saveUser(String name, String email) async {
    //doc will create a new uid of Database service
    return await userCollection.doc(uid).set({'name': name, 'email': email});
  }

  //UPDATE
  // create and modify a user
  Future<void> updateUser(
      String? personaname, String? personaDescription) async {
    return await userCollection.doc(uid).update(
        {'personaname': personaname, 'personaDescription': personaDescription});
  }

//create new account
  /*Future<void> saveAccount(String name, String amount) async {
    //doc will create a new uid of Database service
    return await accountsCollection
        .doc(uid)
        .set
        .collection('accounts')
        .doc({'name': name, 'amount': amount});
  }*/

  Future<void> updateAccount(String name, int amount) async {
    //doc will create a new uid of Database service
    return await accountsCollection
        .doc(uid)
        .collection('accountsdetails')
        .doc()
        .set({'name': name, 'amount': amount});
  }

//READ

//TODO!Convert to use this function instead

//Convert a SINGLE user snapshot
//we convert a user snapshot
//snapshot is a response from firebase

  MyUserData _userFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return MyUserData(
      uid: snapshot.id,
      name: data['name'],
      email: data['email'],
      personaID: data['personaID'],
      personaname: data['personaname'],
      personaDescription: data['personaDescription'],
    );
  }

//Create a SINGLE user stream
  //stream qui récupre le user courant donc
  // besoin de doc(uid)
  Stream<MyUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

//Create a LIST of users
  //querySnapshot peut contenir 0 ou plusieurs query de snapshot
  //Create user list
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

//Create a stream of users
  // on récupere tout les users
  Stream<List<MyUserData>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  PersonaData _personaFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("persona not found");
    return PersonaData(
      personaid: snapshot.id,
      name: data['name'],
      description: data['description'],
    );
  }

  //change to persona collection
  Stream<PersonaData> get persona {
    return personaCollection.doc(uid).snapshots().map(_personaFromSnapshot);
  }
}

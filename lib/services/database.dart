import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/models/finance.dart';
import 'package:fyp/models/goals.dart';
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

  final CollectionReference<Map<String, dynamic>> goalsCollection =
      FirebaseFirestore.instance.collection("goals");

  final CollectionReference<Map<String, dynamic>> recordsCollection =
      FirebaseFirestore.instance.collection("records");

  //USER
  //create a user
  Future<void> saveUser(String name, String email) async {
    //doc will create a new uid of Database service
    return await userCollection.doc(uid).set({'name': name, 'email': email});
  }

  //PERSONA
//save persona the first time to user
  Future<void> savePersona(
      String? personaname, String? personaDescription) async {
    return await userCollection.doc(uid).set(
        {'personaname': personaname, 'personaDescription': personaDescription},
        SetOptions(merge: true));
  }

  //UPDATE
  // modify a persona in the user class
  Future<void> updatePersona(
      String? personaname, String? personaDescription) async {
    return await userCollection.doc(uid).update(
        {'personaname': personaname, 'personaDescription': personaDescription});
  }

//create new account

  Future<void> saveAccount(String name, int amount) async {
    //doc will create a new uid of Database service
    return await accountsCollection
        .doc(uid)
        .collection('accountsdetails')
        .doc()
        .set({'name': name, 'amount': amount});
  }

  Future<void> updateAccount(String name, int amount) async {
    //doc will create a new uid of Database service
    return await accountsCollection
        .doc(uid)
        .collection('accountsdetails')
        .doc()
        .set({'name': name, 'amount': amount});
  }

  Future<void> deleteAccount(String docid) async {
    //doc will create a new uid of Database service
    return await accountsCollection
        .doc(uid)
        .collection('accountsdetails')
        .doc(docid)
        .delete();
  }

//GOAL
//add a new goal
  Future<void> saveGoal(int amount, String target, String title,
      Timestamp enddate, int progress) async {
    //doc will create a new uid of Database service
    return await goalsCollection.doc(uid).collection('goalsdetails').doc().set({
      'amount': amount,
      'target': target,
      'title': title,
      'enddate': enddate,
      'progress': progress,
    });
  }

  Future<void> updateGoal(
    String name,
    int amount,
    String target,
    String title,
    Timestamp enddate,
  ) async {
    //doc will create a new uid of Database service
    return await goalsCollection
        .doc(uid)
        .collection('goalsdetails')
        .doc()
        .update({
      'name': name,
      'amount': amount,
      'target': target,
      'title': title,
      'enddate': enddate
    });
  }


  Future<void> deleteGoal(String docid) async {
    //doc will create a new uid of Database service
    return await goalsCollection
        .doc(uid)
        .collection('goalsdetails')
        .doc(docid)
        .delete();
  }


  //RECORD
//add a new goal
  Future<void> saveRecord(String name, int amount, String recordtype,
      String recordcategory, String accname) async {
    //doc will create a new uid of Database service
    return await recordsCollection
        .doc(uid)
        .collection('recordsdetails')
        .doc()
        .set({
      'name': name,
      'amount': amount,
      'recordtype': recordtype,
      'recordcategory': recordcategory,
      'accname': accname,
    });
  }

  Future<void> updateRecord(String name, int amount, String recordtype,
      String recordcategory, String accname) async {
    //doc will create a new uid of Database service
    return await recordsCollection
        .doc(uid)
        .collection('recordsdetails')
        .doc()
        .update({
      'name': name,
      'amount': amount,
      'recordtype': recordtype,
      'recordcategory': recordcategory,
      'accname': accname,
    });
  }

   Future<void> deleteRecord(String docid) async {
    //doc will create a new uid of Database service
    return await recordsCollection
        .doc(uid)
        .collection('recordsdetails')
        .doc(docid)
        .delete();
  }

//READ

//TODO!Convert to use this function instead of Stream Builder


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

  //READ GOALS

  List<GoalsData> _goalsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return GoalsData(
        goalsid: doc.id,
        title: (doc.data() as dynamic)['title'] ?? '',
        target: (doc.data() as dynamic)['target'] ?? '',
        amount: (doc.data() as dynamic)['amount'] ?? 0,
        progress: (doc.data() as dynamic)['progress'] ?? 0,
        enddate: (doc.data() as dynamic)['enddate'] ?? Timestamp.now(),
      );
    }).toList();
  }

  Stream<List<GoalsData>> get goals {
    final CollectionReference<Map<String, dynamic>> goalsdetailsCollection =
        goalsCollection.doc(uid).collection("goalsdetails");

    return goalsdetailsCollection.snapshots().map(_goalsListFromSnapshot);
  }

//READ ACCOUNTS
  List<AccountsData> _accountsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AccountsData(
        accountid: doc.id,
        name: (doc.data() as dynamic)['name'] ?? '',
        amount: (doc.data() as dynamic)['amount'] ?? 0,
      );
    }).toList();
  }

  Stream<List<AccountsData>> get accounts {
    final CollectionReference<Map<String, dynamic>> accountsdetailsCollection =
        accountsCollection.doc(uid).collection("accountsdetails");
    return accountsdetailsCollection.snapshots().map(_accountsListFromSnapshot);
  }

  //READ RECORDS

  List<RecordsData> _recordsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return RecordsData(
        recordid: doc.id,
        name: (doc.data() as dynamic)['name'] ?? '',
        amount: (doc.data() as dynamic)['amount'] ?? 0,
        recordtype: (doc.data() as dynamic)['recordtype'] ?? '',
        recordcategory: (doc.data() as dynamic)['recordcategory'] ?? '',
        accname: (doc.data() as dynamic)['accname'] ?? '',
      );
    }).toList();
  }

  Stream<List<RecordsData>> get records {
    final CollectionReference<Map<String, dynamic>> recordsdetailsCollection =
        recordsCollection.doc(uid).collection("recordsdetails");
    return recordsdetailsCollection.snapshots().map(_recordsListFromSnapshot);
  }

  //TODO! Delete

}

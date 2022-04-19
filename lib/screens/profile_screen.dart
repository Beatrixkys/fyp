import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/cards.dart';
import 'package:fyp/components/header.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/models/user.dart';
import 'package:fyp/services/auth.dart';
import 'package:fyp/services/database.dart';
import 'package:fyp/services/menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = ScrollController();

  final FirebaseAuth _authUser = FirebaseAuth.instance;

//TODO!
//1. Create a ListTile for User
//2. Create a ListBuilder for User (do in the same file)

  final AuthService _auth = AuthService();
//push data into firebase here
  @override
  Widget build(BuildContext context) {
    final User? userFirebase = _authUser.currentUser;
    MyUserData? userData;
    //PersonaData? myPersonaData;

    Stream<MyUserData?> myUserData = DatabaseService(userFirebase!.uid).user;
    //persona
    String personaPic = 'assets/owl.png';

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: kApricot,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            MyHeader(
              height: 200,
              width: width,
              color: kApricot,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: kApricot,
                            radius: 80,
                            backgroundImage: AssetImage(personaPic),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              StreamBuilder<MyUserData?>(
                                stream: myUserData,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    userData = snapshot.data;
                                    var value = userData!.name;
                                    return Text(
                                      value,
                                      textAlign: TextAlign.start,
                                      style: kHeadingTextStyle,
                                    );
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                              StreamBuilder<MyUserData?>(
                                stream: myUserData,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    userData = snapshot.data;
                                    var value = userData!.email;
                                    return Text(
                                      value,
                                      textAlign: TextAlign.start,
                                      style: kSubTextStyle,
                                    );
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                              ),
                              space,
                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: kCream,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    await _auth.signOut();
                                    Navigator.pushNamed(context, '/');
                                  },
                                  child: const Center(
                                    child: Text(
                                      'Log Out',
                                      style: kButtonTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),

            space,

            const Text('PERSONA TYPE', style: kTitleTextstyle),
            //use dtb to draw information on persona stype
            StreamBuilder<MyUserData?>(
              stream: myUserData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  userData = snapshot.data;
                  var value = userData!.personaname;
                  return Text(
                    value,
                    textAlign: TextAlign.start,
                    style: kHeadingTextStyle,
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),

            StreamBuilder<MyUserData?>(
              stream: myUserData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  userData = snapshot.data;
                  var value = userData!.personaDescription;
                  return Text(
                    value,
                    textAlign: TextAlign.start,
                    style: kSubTextStyle,
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),

/*
            StreamBuilder<PersonaData>(
              stream: DatabaseService('P002').persona,
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  myPersonaData = snapshot.data;
                  var value = myPersonaData!.name;
                  return Text(
                    value,
                    style: kHeadingTextStyle,
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            StreamBuilder<PersonaData>(
              stream: DatabaseService('P001').persona,
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  myPersonaData = snapshot.data;
                  var value = myPersonaData!.description;
                  return Text(
                    value,
                    style: kSubTextStyle,
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ), */
            const Divider(
              height: 80.0,
              color: kSteelBlue,
            ),

            const Text('Change Persona', style: kTitleTextstyle),
            space,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PersonaCard(
                    icon: "assets/eagle.png",
                    title: "Eagle",
                    user: userFirebase.uid,
                    personaname: "Eagle",
                    personaDescription: "Amount Based",
                  ), //switch cases in the page below
                  PersonaCard(
                    icon: "assets/pigeon.png",
                    title: "Pigeon",
                    user: userFirebase.uid,
                    personaname: "Pigeon",
                    personaDescription: "Percentage Based",
                  ),
                  PersonaCard(
                    icon: "assets/owl.png",
                    title: "Owl",
                    user: userFirebase.uid,
                    personaname: "Owl",
                    personaDescription: "Consistency Based",
                  ),
                ],
              ),
            ),
            space,
          ],
        ),
      ),
    );
  }
}

//change goals pop up


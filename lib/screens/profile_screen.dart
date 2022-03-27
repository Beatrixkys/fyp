import 'package:flutter/material.dart';

import 'package:fyp/components/cards.dart';
import 'package:fyp/components/header.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/services/auth.dart';
import 'package:fyp/services/menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = ScrollController();

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    //user
    String personaPic = 'assets/owl.png';
    String userName = 'Beatrix Kang';
    String email = 'beatrixkys@gmail.com';

    //persona
    String personaName = 'Owl';
    String personaType = '-Consistency focused';

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
                              Text(
                                userName,
                                textAlign: TextAlign.start,
                                style: kHeadingTextStyle,
                              ),
                              Text(
                                email,
                                textAlign: TextAlign.start,
                                style: kSubTextStyle,
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
            Text(personaName, style: kHeadingTextStyle),
            Text(personaType, style: kSubTextStyle),
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
                children: const [
                  PersonaCard(
                      icon: "assets/eagle.png",
                      title: "Eagle",
                      action: '/eaglePersona'), //switch cases in the page below
                  PersonaCard(
                      icon: "assets/pigeon.png",
                      title: "Pigeon",
                      action: '/pigonPersona'),
                  PersonaCard(
                      icon: "assets/owl.png",
                      title: "Owl",
                      action: '/owlPersona'),
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

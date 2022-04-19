import 'package:flutter/material.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/services/biometric_auth.dart';

class BioAuthScreen extends StatefulWidget {
  const BioAuthScreen({Key? key}) : super(key: key);

  @override
  State<BioAuthScreen> createState() => _BioAuthScreenState();
}

class _BioAuthScreenState extends State<BioAuthScreen> {
  bool isAuthenticated = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: kSteelBlue,
          child: Center(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                  child: Column(
                    children: [
                      const Text(
                        'Click Lock to Scan for Double Authentication',
                        style: kTitleTextstyle,
                        textAlign: TextAlign.center,
                      ),
                      space,
                     
                      IconButton(
                        icon: const Icon(Icons.fingerprint),
                        iconSize: 100,
                        color: kSubTitleTextColor,
                        highlightColor: Colors.white,
                        onPressed: () async {
                          isAuthenticated = await LocalAuthApi.authenticate();
                          if (isAuthenticated) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

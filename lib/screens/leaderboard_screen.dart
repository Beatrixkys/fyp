import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/header.dart';
import 'package:fyp/components/progress_bar.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/models/friends.dart';
import 'package:fyp/models/user.dart';
import 'package:fyp/services/database.dart';
import 'package:fyp/services/dtblists/friendlist.dart';
import 'package:fyp/services/menu.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    final controller = ScrollController();
    final sscontroller = ScreenshotController();
    double width = MediaQuery.of(context).size.width;
    MyUserData? userData;
    Stream<MyUserData?> myUserData = DatabaseService(uid).user;

    void _showSearchFriends() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 400,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SearchPopUp(uid: uid),
            );
          });
    }

    return MultiProvider(
        providers: [
          StreamProvider<List<FriendsData>>.value(
              value: DatabaseService(uid).friends, initialData: const []),
          StreamProvider<List<FriendRequestData>>.value(
              value: DatabaseService(uid).friendreqs, initialData: const [])
        ],
        builder: (context, snapshot) {
          return Screenshot(
            controller: sscontroller,
            child: Scaffold(
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
                      height: 150,
                      width: width,
                      color: kApricot,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Leaderboard',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: kSubTitleTextColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: kCream,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: TextButton(
                                      onPressed: () => _showSearchFriends(),
                                      child: const Center(
                                        child: Text(
                                          'Add Friend',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  smallSpace,
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: kCream,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {
                                        final image =
                                            await sscontroller.capture();
                                        await saveImage(image!);
                                        await saveShare(image);
                                      },
                                      child: const Center(
                                        child: Text(
                                          'Share',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          space,
                          StreamBuilder<MyUserData?>(
                            stream: myUserData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                userData = snapshot.data;
                                var value = userData!.progress;
                                return ProgressBar(
                                  percent: value / 100.toDouble(),
                                  progress: '$value%',
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ],
                      ),
                    ),
                    //convert to single scroll within the columns/list view
                    space,
                    const SizedBox(
                      height: 400,
                      width: 350,

                      child: LeaderboardList(),
                      //populate with numbers from the database
                    ),

                    space,

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                          color: kTan, borderRadius: BorderRadius.circular(40)),
                      height: 350,
                      width: 400,
                      child: Column(
                        children: const [
                          Text(
                            'Pending Friend Requests',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: kSubTitleTextColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          space,
                          SizedBox(
                            height: 250,
                            width: 350,

                            child: FriendRequestList(),
                            //populate with numbers from the database
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class SearchPopUp extends StatefulWidget {
  const SearchPopUp({Key? key, required this.uid}) : super(key: key);

  final String uid;
  @override
  State<SearchPopUp> createState() => _SearchPopUpState();
}

class _SearchPopUpState extends State<SearchPopUp> {
  final TextEditingController _searchController = TextEditingController();

  List<MyUserData> userList = [];
  List<MyUserData> newList = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void getUsers() async {
    List<MyUserData> list = await DatabaseService(widget.uid).usersSearch.first;
    userList = list;
  }

  void searchUsers(String query) {
    final newList = userList.where((friend) {
      final friends = friend.email.toString().toLowerCase();
      final input = query.toLowerCase();
      return friends.contains(input);
    }).toList();

    setState(() {
      userList = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    String searchText = '';

    getUsers();

    return SizedBox(
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Search Friends",
              style: kHeadingTextStyle,
            ),
            TextField(
              controller: _searchController,
              onChanged: (String? value) {
                setState(() {
                  searchText = value!;
                  searchUsers(searchText);
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            space,
            SizedBox(
              width: 350,
              height: 220,
              child: FriendList(friends: userList),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> saveImage(Uint8List bytes) async {
  await (Permission.storage).request();
  final time = DateTime.now()
      .toIso8601String()
      .replaceAll('.', '-')
      .replaceAll(':', '-');
  final name = 'screenshot_$time';
  final result = await ImageGallerySaver.saveImage(bytes, name: name);
  return result['filePath'];
}

Future saveShare(Uint8List bytes) async {
  final directory = await getApplicationDocumentsDirectory();
  final image = File('${directory.path}/progress.png');
  image.writeAsBytesSync(bytes);
  await Share.shareFiles([image.path]);
}

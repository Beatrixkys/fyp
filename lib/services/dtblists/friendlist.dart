import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/friends.dart';
import 'package:fyp/services/database.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class LeaderboardList extends StatefulWidget {
  const LeaderboardList({Key? key}) : super(key: key);

  @override
  State<LeaderboardList> createState() => _LeaderboardListState();
}

class _LeaderboardListState extends State<LeaderboardList> {
  @override
  Widget build(BuildContext context) {
    final friends = Provider.of<List<FriendsData>>(context);

    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        return LeaderboardTile(friend: friends[index], index: index);
      },
    );
  }
}

class LeaderboardTile extends StatelessWidget {
  const LeaderboardTile({Key? key, required this.friend, required this.index})
      : super(key: key);

  final FriendsData friend;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Text(
            '${index + 1}',
            style: kHeadingTextStyle,
          ),
          title: Text(
            friend.fname,
            style: kHeadingTextStyle,
          ),
          subtitle: Text(friend.femail),
          trailing: Text(
            '${friend.fprogress}',
            style: kHeadingTextStyle,
          ),
        ),
      ),
    );
  }
}

class FriendRequestList extends StatefulWidget {
  const FriendRequestList({Key? key}) : super(key: key);

  @override
  State<FriendRequestList> createState() => _FriendRequestListState();
}

class _FriendRequestListState extends State<FriendRequestList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final friends = Provider.of<List<FriendRequestData>>(context);
    final User? user = _auth.currentUser;
    final uid = user!.uid;

    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        return FriendRequestTile(friend: friends[index], uid: uid);
      },
    );
  }
}

class FriendRequestTile extends StatelessWidget {
  const FriendRequestTile({Key? key, required this.friend, required this.uid})
      : super(key: key);

  final FriendRequestData friend;

  final String uid;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(
            friend.fname,
            style: kHeadingTextStyle,
          ),
          subtitle: Text(friend.femail),
          trailing: SizedBox(
            width: 96,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.check_outlined),
                  onPressed: () async {
                    await DatabaseService(uid).saveFriend(friend.fname,
                        friend.femail, friend.fprogress, friend.fid);
                    await DatabaseService(uid).deleteFriendRequest(friend.fid);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close_outlined),
                  onPressed: () async {
                    await DatabaseService(uid).deleteFriendRequest(friend.fid);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

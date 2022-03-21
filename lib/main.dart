import 'package:flutter/material.dart';
import 'package:fyp/screens/authentication_screen.dart';
//to add when adding back end //import 'package:provider/provider.dart';
import 'package:fyp/screens/finance_screen.dart';
import 'package:fyp/screens/goals_screen.dart';
import 'package:fyp/screens/home_screen.dart';
import 'package:fyp/screens/leaderboard_screen.dart';
import 'package:fyp/screens/profile_screen.dart';
import 'package:fyp/screens/setup_profile_accounts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soar Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(), //AuthenticationWrapper(),
        '/home': (context) => const HomeScreen(),
        '/finance': (context) => const FinanceScreen(),
        '/setupprofile': (context) => const SetUpProfileAndAccountsScreen(),
        '/profile': (context) => ProfileScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
        '/goals': (context) => const GoalsScreen(),
        '/managefinance': (context) => const ManageFinanceScreen(),
        '/addfinance': (context) => const AddFinanceScreen(),
        '/managegoals': (context) => const ManageGoalsScreen(),
        '/addgoals': (context) => const AddGoalsScreen(),
      },
    );
  }
}

//to add as backend in the future
/*
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return const AuthScreen();
    } else {
      return const HomeScreen();
    }
  }
}
*/
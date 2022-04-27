import 'package:flutter/material.dart';
import 'package:fyp/models/user.dart';
import 'package:fyp/screens/authentication_screen.dart';
import 'package:fyp/screens/bio_auth_screen.dart';
//to add when adding back end //import 'package:provider/provider.dart';
import 'package:fyp/screens/finance_screen.dart';
import 'package:fyp/screens/goals_screen.dart';
import 'package:fyp/screens/home_screen.dart';
import 'package:fyp/screens/leaderboard_screen.dart';
import 'package:fyp/screens/profile_screen.dart';
import 'package:fyp/screens/setup_profile_accounts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Soar Application',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthenticationWrapper(),
          '/resetpassword': (context) => const ResetPasswordScreen(),
          '/biosignin': (context) => const BioAuthScreen(),
          '/home': (context) => const HomeScreen(),
          '/finance': (context) => const FinanceScreen(),
          '/setupprofile': (context) => const SetUpProfileAndAccountsScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/leaderboard': (context) => const LeaderboardScreen(),
          '/goals': (context) => const GoalsScreen(),
          '/managefinance': (context) => const ManageFinanceScreen(),
          '/addfinance': (context) => const AddFinanceScreen(),
          '/managegoals': (context) => ManageGoalsScreen(),
          '/addgoals': (context) => const AddGoalsScreen(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return const AuthScreen();
    } else {
      return const BioAuthScreen();
    }
  }
}

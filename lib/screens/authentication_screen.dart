import 'package:flutter/material.dart';
import 'package:fyp/components/round_text_field.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/services/validator.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //Auth
  String error = '';
  String email = "";
  String password = "";
  String name = "";

  //Form
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final controller = ScrollController();
  bool showSignIn = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: Image.asset('assets/bird.png'),
            ),
            const Center(
              child: Text("Hi There!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              child: Text(
                showSignIn ? "Sign In" : "Register",
                style: kHeadingTextStyle,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  if (showSignIn == false)
                    (RoundTextField(
                        controller: nameController,
                        title: "Name",
                        isPassword: false,
                        onSaved: (String? value) {
                          name != value;
                        },
                        validator: (value) =>
                            EPValidator.validateName(name: value))),
                  space,
                  RoundTextField(
                    controller: emailController,
                    title: "Email",
                    isPassword: false,
                    onSaved: (String? value) {
                      email != value;
                    },
                    validator: (value) =>
                        EPValidator.validateEmail(email: value),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundTextField(
                    controller: passwordController,
                    title: "Password",
                    isPassword: true,
                    onSaved: (String? value) {
                      password != value;
                    },
                    validator: (value) =>
                        EPValidator.validatePassword(password: value),
                  ),

                  smallSpace,
                  if (showSignIn == true)
                    TextButton(
                      onPressed: () {},
                      child: const Text("Forget Password?"),
                    ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: 300,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          child: Text(
                            showSignIn ? 'Log In' : 'Register',
                            style: kButtonTextStyle,
                          ),
                          style: kButtonStyle,
                        ),
                        const Divider(
                          height: 20.0,
                          color: kSteelBlue,
                        ),
                        const Center(
                          child: Text(
                            "Don't Have An Account?",
                            style: TextStyle(
                              fontSize: 16,
                              color: kTitleTextColor,
                            ),
                          ),
                        ),
                        smallSpace,
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          }, //=>toggleView()
                          child: Text(
                            showSignIn ? 'Register' : 'Sign In',
                            style: kButtonTextStyle,
                          ),
                          style: kButtonStyle,
                        ),
                      ],
                    ),
                  ),

                  space,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fyp/components/loading.dart';
import 'package:fyp/components/round_text_field.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/services/auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //Auth
  final AuthService _auth = AuthService();
  String error = '';
  String email = "";
  String password = "";
  String name = "";

  //Form
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final nameVal =
      MultiValidator([RequiredValidator(errorText: 'Name is Required')]);

  final emailVal = MultiValidator([
    RequiredValidator(errorText: 'Email is Required'),
    EmailValidator(errorText: 'Email must be a Valid Email')
  ]);

  final passwordVal = MultiValidator([
    RequiredValidator(errorText: 'Password is Required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 Characters')
  ]);
  //Visuals and conditions
  final controller = ScrollController();
  bool showSignIn = true;
  bool loading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState!.reset();
      error = '';
      emailController.text = '';
      passwordController.text = '';
      nameController.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            body: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 70,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(5),
                    child: Image.asset('assets/bird.png'),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(5),
                    child: const Center(
                      child: Text("Hi There!",
                          style: TextStyle(
                            fontSize: 16,
                            color: kTextColor,
                          )),
                    ),
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
                            validator: nameVal,
                          )),
                        space,
                        RoundTextField(
                          controller: emailController,
                          title: "Email",
                          isPassword: false,
                          onSaved: (String? value) {
                            email != value;
                          },
                          validator: emailVal,
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
                          validator: passwordVal,
                        ),

                        smallSpace,
                        if (showSignIn == true)
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/resetpassword');
                            },
                            child: const Text("Forget Password?"),
                          ),
                        // ignore: sized_box_for_whitespace
                        Container(
                          width: 300,
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    var password =
                                        passwordController.value.text;
                                    var email = emailController.value.text;
                                    var name = nameController.value.text;

                                    dynamic result = showSignIn
                                        ? await _auth
                                            .signInWithEmailAndPassword(
                                                email, password, context)
                                        : await _auth.register(
                                            email, password, name, context);

                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error = "Please supply valid email";
                                      });
                                    }
                                  }
                                  Navigator.pushNamed(context,
                                      showSignIn ? '/home' : '/setupprofile');

                                  //to change to biometric template page
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
                                onPressed: () => toggleView(),
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

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _auth = FirebaseAuth.instance;
  final controller = ScrollController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final emailVal = MultiValidator([
    RequiredValidator(errorText: 'Email is Required'),
    EmailValidator(errorText: 'Email must be a Valid Email')
  ]);

  bool loading = false;
  String email = " ";
  String error = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 100),
            SizedBox(
              height: 50,
              child: Image.asset('assets/bird.png'),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(5),
              child: const Center(
                child: Text("Forgot Password?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(5),
              child: const Text(
                "Reset Below",
                style: kHeadingTextStyle,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(5),
              child: Form(
                key: _formKey,
                child: RoundTextField(
                  controller: emailController,
                  title: "Email",
                  isPassword: false,
                  onSaved: (String? value) {
                    email != value;
                  },
                  validator: emailVal,
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    var email = emailController.value.text;

                    dynamic result = _auth.sendPasswordResetEmail(email: email);

                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = "Please supply valid email";
                      });
                    }

                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Reset Password',
                  style: kButtonTextStyle,
                ),
                style: kButtonStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pethub/services/auth.dart';
// import 'package:pethub/pages/mainPages/index.dart';
// import '../mainPages/home.dart';
import '../mainPages/index.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _erorrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFC727),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'PetHub',
                      style: TextStyle(
                        fontSize: 80,
                        fontFamily: 'Rubik Bubbles',
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset('assets/images/Paw.png'),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                         key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              validator: (val) =>
                                  val!.isEmpty ? "Enter an email" : null,
                              onChanged: (val) {
                                setState(() => _emailController.text = val);
                              },
                              decoration: InputDecoration(
                                hintText: 'Username',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _passwordController,
                              validator: (val) => val!.length < 6
                                  ? "Enter a password 6+ chars long"
                                  : null,
                              onChanged: (val) {
                                setState(() => _passwordController.text = val);
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 400),
                            child: RegisterPage(),
                          ),
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: 'Does not have an account? ',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Register here!',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _erorrController.text,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                       if (_formKey.currentState!.validate()) {
                          dynamic result =
                              await _auth.signInWithEmailAndPasssword(
                                  _emailController.text,
                                  _passwordController.text);
                          if (result == null) {
                            setState(() => _erorrController.text =
                                'Could not sign in!');
                          } 
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFA96D25),
                        onPrimary: Colors.white,
                        minimumSize: Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontFamily: 'Roboto'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        dynamic result = await _auth.signInAnon();
                        if (result == null) {
                          print("eror signing in");
                        } else {
                          print("sign in");
                          print(result.uid);
                        }
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: 'Or Sign In as Guest / Anonymous ',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

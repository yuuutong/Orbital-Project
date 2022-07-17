import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sleeplah/forgot_password_page/ConfirmEmail.dart';
import 'package:sleeplah/login_page/LogIn.dart';
import 'package:sleeplah/login_page/LoginScreen.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'forgot-password';
  final String message =
      "An email has just been sent to you\n \nClick the link in email\nto complete password reset";

  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  late String _email;

  Future<void> _passwordReset() async {
    try {
      _formKey.currentState!.save();
      //final user = await _auth.sendPasswordResetEmail(email: _email);
      try {
        await _auth.sendPasswordResetEmail(email: _email);
      } on FirebaseAuthException catch (e) {
        print(e);
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ConfirmEmail(
            message: widget.message,
          );
        }),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid Email Format'),
      ));
    }
  }

  /* Future<void> resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const Positioned.fill(
        child: Image(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter Your Email',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              TextFormField(
                onSaved: (newEmail) {
                  _email = newEmail!;
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  icon: Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  errorStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Send Email'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _passwordReset();
                  }
                },
              ),
              TextButton(
                child: const Text('Back To Sign In',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                },
              )
            ],
          ),
        ),
      ),
    ]));
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_demo/login/passwordField.dart';
import 'package:dio/dio.dart';

import '../pokedex/index.dart';
import '../storage/index.dart';
import 'emailField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

void onLogin(BuildContext context) async {
  log('onLogin');
  try {
    Response response = await Dio().post(
        'http://api.beta.radiantgalaxy.io/sdk/v1/auth/login/credential',
        data: {'email': 'chhh@gmail.com', 'password': '123qweA@'});

    StorageApp.accessToken = response.data['accessToken'];

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PokedexPage()),
    );
  } catch (e) {
    log('err: $e');
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
              border: Border.all(color: Colors.white)),
          width: screenSize.width - 40,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: <Widget>[
                const Text("Hello",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(height: 8),
                const Text("Please Login to Your Account",
                    style:
                        TextStyle(color: Color.fromARGB(221, 157, 150, 150))),
                const SizedBox(height: 12),
                const EmailField(),
                const SizedBox(height: 8),
                const PasswordField(),
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('Forget Password',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(color: Color.fromARGB(221, 224, 70, 70))),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    onLogin(context);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.red, Colors.yellow]),
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text("Or Login using Social Media Account",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 12),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const <Widget>[
                      Image(
                          image: AssetImage('assets/images/icon-facebook.png'),
                          width: 50,
                          height: 50),
                      Image(
                          image: AssetImage('assets/images/icon-google.png'),
                          width: 50,
                          height: 50),
                    ])
              ])),
        )
      ]),
    );
  }
}

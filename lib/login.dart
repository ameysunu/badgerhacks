import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'homewidget.dart';

String name;
String email;
String imageUrl;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#FFFFFF'),
      appBar: AppBar(
        backgroundColor: HexColor('#FFFFFF'),
        elevation: 0,
        title: Text(
          "Login",
          style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 1,
                child: Image.asset('images/login.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Welcome to Vacay ➜",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 25,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: HexColor('#9296F0'),
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 25,
                          width: 25,
                          child: Image.asset("images/google.png"),
                        ),
                      ),
                      Text(
                        "Sign in with Google",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  signInWithGoogle().then((result) {
                    if (result != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeWidget();
                          },
                        ),
                      );
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

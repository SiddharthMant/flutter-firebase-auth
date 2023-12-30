import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth_final/signup.dart';

class Dashboard extends StatelessWidget {
  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
            body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFFBA557),
                elevation: 0,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                )),
            onPressed: () async {
              await auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => SignUpForm(),
                  ),
                  (route) => false);
            },
            child: Text("Logout"),
          ),
        ));
      }),
    );
  }
}

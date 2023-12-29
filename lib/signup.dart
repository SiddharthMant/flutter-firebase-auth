// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth_final/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isHidden = true;
  String? _password;
  String? _confirmpassword;
  String? _email;
  final _formKey = GlobalKey<FormState>();

  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (BuildContext context) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 150,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 15,
                      child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "Create Your Account",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: TextFormField(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  validator: (input) => !input!.contains('@')
                                      ? 'Please enter a valid email'
                                      : null,
                                  onSaved: (input) => _email = input,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Color(0xFFFBA557)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Color(0xFFFBA557)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Color(0xFFFBA557)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Color(0xFFFBA557)),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 24),
                                    hintText: 'Email',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: TextFormField(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  validator: (input) => input!.length < 6
                                      ? 'Must be at least 6 characters'
                                      : null,
                                  onChanged: (input) => _password = input,
                                  obscureText: _isHidden,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Color(0xFFFBA557)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Color(0xFFFBA557)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Color(0xFFFBA557)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Color(0xFFFBA557)),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 24),
                                    hintText: 'Password',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: TextFormField(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  validator: (input) => input! != _password
                                      ? 'Passwords do not match'
                                      : null,
                                  onChanged: (input) =>
                                      _confirmpassword = input,
                                  obscureText: _isHidden,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Color(0xFFFBA557)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Color(0xFFFBA557)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Color(0xFFFBA557)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      borderSide: BorderSide(
                                          width: 1.5, color: Color(0xFFFBA557)),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 24),
                                    suffixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: InkWell(
                                          onTap: _togglePasswordView,
                                          child: Icon(_isHidden
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        )),
                                    hintText: 'Confirm Password',
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 40),
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xFFFBA557),
                                        elevation: 0,
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        )),
                                    onPressed: () async {
                                      await signUp(
                                          userEmail: _email,
                                          password: _confirmpassword,
                                          context: context);
                                      // Logout as this is debug build and helps in testing
                                      await auth.signOut();
                                    },
                                    child: Text("SIGN UP"),
                                  )),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Divider(
                                                color: Colors.black,
                                                thickness: 1.0,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'or continue with',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Divider(
                                                color: Colors.black,
                                                thickness: 1.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await signInWithGoogle(
                                                      context: context);
                                                  // Logout as this is debug build and helps in testing
                                                  await auth.signOut();
                                                },
                                                child: Ink.image(
                                                    width: 50,
                                                    height: 50,
                                                    image: AssetImage(
                                                      'assets/images/btn_google.png',
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await signInWithFacebook(
                                                      context: context);
                                                  // Logout as this is debug build and helps in testing
                                                  await auth.signOut();
                                                },
                                                child: Ink.image(
                                                    width: 48,
                                                    height: 48,
                                                    image: AssetImage(
                                                      'assets/images/btn_fb.png',
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Coming Soon. Once I have an apple device.')));
                                                },
                                                child: Ink.image(
                                                    width: 50,
                                                    height: 50,
                                                    image: AssetImage(
                                                      'assets/images/btn_apple.png',
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Already have an account? "),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => LoginForm(),
                                            ),
                                          );
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              Color(0xFFFBA557), // Text Color
                                        ),
                                        child: const Text(
                                          'Login ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          )))
                ],
              ),
            ));
      }),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future<User?> signUp(
      {required String? userEmail,
      required String? password,
      required BuildContext context}) async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: userEmail!, password: password!);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registered & Logged In.')));
        return userCredential.user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    User? user;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      user = userCredential.user;
      // Push home page
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registered & Logged In with Google')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('The account already exists with a different credential'),
        ));
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Error occurred while accessing credentials. Try again.'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Error occurred using Google Sign In. Try again.',
        )),
      );
    }
    // Once signed in, return the UserCredential
    return user;
  }

  Future<UserCredential> signInWithFacebook(
      {required BuildContext context}) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Push home page
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered & Logged In with Facebook')));

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}

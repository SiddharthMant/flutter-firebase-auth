// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isHidden = true;
  String? _password;
  String? _email;
  final _formKey = GlobalKey<FormState>();

  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;

  passwordReset(String? email, BuildContext context) async {
    // Better to handle reset password in seperate screen ?
    try {
      _formKey.currentState!.save();
      if (email != null && email.contains("@")) {
        final user = await auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Password Reset Email sent to your email ID if user exists.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter Email ID.')));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<User?> login(
      String? email, String? password, BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        UserCredential userCred = await auth.signInWithEmailAndPassword(
            email: email!, password: password!);
        // if succesfull leave auth screen and go to homepage
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Logged In.')));

        // Logout as this is debug build and helps in testing
        await auth.signOut();
      }
    } on FirebaseAuthException catch (e) {
      // On error
      // If user is not found
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')));
      }
      // If password is wrong
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Wrong password.')));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(minutes: 1),
          content: Text(
              'Error: Most Likely incorrect credentials. Validation of this error not handled as Google Play Protect not yet enabled (empty reCAPTCHA token)')));
    }
  }

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
                      flex: 4,
                      child: Align(
                        alignment: Alignment.center,
                        child:
                            Image(image: AssetImage('assets/images/logo.png')),
                      )),
                  Expanded(
                      flex: 6,
                      child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "Login to your Account",
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
                                  onChanged: (input) => _email = input,
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
                                        vertical: 12, horizontal: 24),
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
                                        vertical: 12, horizontal: 24),
                                    suffixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: InkWell(
                                          onTap: _togglePasswordView,
                                          child: Icon(_isHidden
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        )),
                                    hintText: 'Password',
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CheckboxRememberMe(),
                                      Text(
                                        "Remember Me",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  )),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 40),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color(0xFFFBA557),
                                    elevation: 0,
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    )),
                                onPressed: () async {
                                  await login(_email, _password, context);
                                },
                                child: Text("SIGN IN"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: TextButton(
                                  onPressed: () async {
                                    _formKey.currentState!.save();
                                    await passwordReset(_email, context);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Color(0xFFFBA557), // Text Color
                                  ),
                                  child: const Text(
                                    'Forgot the Password ? ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
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
}

class CheckboxRememberMe extends StatefulWidget {
  const CheckboxRememberMe({super.key});

  @override
  State<CheckboxRememberMe> createState() => _CheckboxRememberMeState();
}

class _CheckboxRememberMeState extends State<CheckboxRememberMe> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.selected,
      };
      if (states.any(interactiveStates.contains)) {
        return Color(0xFFFBA557);
      }
      return Colors.white;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
      side: BorderSide(
        // ======> CHANGE THE BORDER COLOR HERE <======
        color: Color(0xFFFBA557),
        // Give your checkbox border a custom width
        width: 1.5,
      ),
    );
  }
}

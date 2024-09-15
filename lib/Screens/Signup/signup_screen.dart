import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Screens/HomeScreen/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  runApp(MaterialApp(home: SignUpPage()));
}

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

final _auth = FirebaseAuth.instance;

class _SignUpPageState extends State<SignUpPage> {
  String email = "";
  String password = "";
  String userName = "";
  @override
  void initState() {
    super.initState();
  }

  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("User");

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void registerToFb() {
    _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((result) {
      dbRef.child(result.user!.uid).set({
        "email": _emailController.text,
        "address": [],
        "cart": [],
        "orderHistory": [],
        "wishList": [],
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(uid: result.user!.uid)),
      );
      print("Signed Up");
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 150, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
            ),
            const Text(
              'Enter your credentials to continue',
              style: TextStyle(fontSize: 12),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 17),
                hintText: 'Username',
                prefixIcon: Icon(Icons.person),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              controller: _emailController,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 17),
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 17),
                hintText: 'Password',
                prefixIcon: Icon(Icons.password),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'By continuing you agree to our Terms of Service and Privacy Policy.',
                      style: TextStyle(fontSize: 12),
                    ))),
            ElevatedButton(
              onPressed: () {
                registerToFb();
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(450, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff40aa54))),
              child: Text("Login".toUpperCase(),
                  style: const TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w300,
                      fontSize: 20)),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Already have an account? Sign up',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center)))
          ],
        ),
      ),
    );
  }
}

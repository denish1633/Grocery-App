import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_page/Screens/Login/login_screen.dart';
import 'package:login_page/Screens/Signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(children: [
              SvgPicture.asset('assets/images/welcomeScreen.svg'),
              const Text('Welcome to Indian Grocery Store!',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w500)),
              const Text(
                'Welcome to Indian Grocery Store! Welcome to Indian Grocery Store!',
                style: TextStyle(fontSize: 12),
              ),
              Hero(
                  tag: "login_btn",
                  child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                       
                        
                        children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LoginPage();
                                  },
                                ),
                              );
                            },
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(450, 50)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0))),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff40aa54))),
                            child: Text("Login".toUpperCase(),
                                style: const TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,5,0,0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SignUpPage();
                                  },
                                ),
                              );
                            },
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(450, 50)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0))),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff40aa54))),
                            child: Text("Sign Up".toUpperCase(),
                                style: const TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,color: Colors.black)),
                          ),
                        )
                      ])))
            ])));
  }
}

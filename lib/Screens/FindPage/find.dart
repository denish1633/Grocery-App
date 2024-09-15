import 'package:flutter/material.dart';
import 'package:login_page/Screens/FindPage/category.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_page/Screens/HomeScreen/homeScreen.dart';

class FindPage extends StatelessWidget {
  String uid = '';
  FindPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print(
              'Backbutton pressed (device or appbar button), do whatever you want.');
          //trigger leaving and use own data
          Navigator.pop(
            context,
            false
          );
          //we need to return a future
          return Future.value(false);
        },
        child: MaterialApp(
            home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            bottomOpacity: 0.0,
            elevation: 0.0,
            title: const Text(
              'Find Product',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),
          body: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F3F2),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 17),
                        hintText: 'Search Store',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  GroceryCategory()
                ],
              )),
        )));
  }




}

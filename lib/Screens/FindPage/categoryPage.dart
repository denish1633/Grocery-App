import 'package:flutter/material.dart';
import 'package:login_page/Screens/Product/ProductTile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

import '../Product/ProductPage.dart';

class categoryPage extends StatefulWidget {
  final String categoryName = '';

  categoryPage({
    Key? key,
    required String categoryName,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

getProductCollection(String collectionName) async {
  DatabaseReference reference = FirebaseDatabase.instance.ref();

  final snapshot = await reference.child(collectionName).get();

  if (snapshot.exists) {
    final map = snapshot.value as List<dynamic>;

    return map;
  } else {
    print('No data available.');
  }
}

class _MyAppState extends State<categoryPage> {
  late Future<dynamic> categoryCollection;

  @override
  void initState() {
    super.initState();
    categoryCollection = getProductCollection('vegetables');
  }

  Future<String> getData(String productName) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.unsplash.com/search/photos?page=1&query=${productName}&per_page=1&client_id=KKbmPU7Sp9eW9Bzeb4IDQk0jueve2pM1GkYjRZJh2Gg'));
    Map<String, dynamic> imageData = json.decode(response.body);

    return imageData['results'][0]['urls']['regular'];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: FutureBuilder(
            future: categoryCollection,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Column(children: 
                snapshot.data.map<Widget>((item) => {
                     Text(
        item['name'],
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w300,
          color: Colors.black,
        )
      )
                    })
              );
            }));
  }
}

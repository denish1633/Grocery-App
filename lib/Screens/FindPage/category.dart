import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_page/Screens/FindPage/categoryPage.dart';

class Data {
  final IconData icon;
  final String text;
  final Color color;
  final Color borderColor;
  Data(
      {required this.icon,
      required this.text,
      required this.color,
      required this.borderColor});
}

class GroceryCategory extends StatefulWidget {
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<GroceryCategory> {
  Future<String> getData(String productName) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.unsplash.com/search/photos?page=1&query=${productName}&per_page=1&client_id=KKbmPU7Sp9eW9Bzeb4IDQk0jueve2pM1GkYjRZJh2Gg'));
    Map<String, dynamic> imageData = json.decode(response.body);

    print(imageData['results'][0]['urls']['small']);

    return imageData['results'][0]['urls']['regular'];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<List<Data>> dataList = [
      [
        Data(
            icon: Icons.local_grocery_store,
            text: 'Fruits',
            color: const Color(0xFFFAF3F0).withOpacity(0.25),
            borderColor: const Color(0xFFFAF3F0)),
        Data(
            icon: Icons.local_grocery_store,
            text: 'Vegetables',
            color: const Color(0xFFD4E2D4).withOpacity(0.25),
            borderColor: const Color(0xFFD4E2D4))
      ],
      [
        Data(
            icon: Icons.local_grocery_store,
            text: 'Dairy',
            color: const Color(0xFFFFCACC).withOpacity(0.25),
            borderColor: const Color(0xFFFFCACC)),
        Data(
            icon: Icons.local_grocery_store,
            text: 'Meat',
            color: const Color(0xFFDBC4F0).withOpacity(0.25),
            borderColor: const Color(0xFFDBC4F0))
      ],
      [
        Data(
            icon: Icons.local_grocery_store,
            text: 'Bakery',
            color: const Color(0xFFF9F5F6).withOpacity(0.25),
            borderColor: const Color(0xFFF9F5F6)),
        Data(
            icon: Icons.local_grocery_store,
            text: 'Canned Goods',
            color: const Color(0xFFF8E8EE).withOpacity(0.25),
            borderColor: const Color(0xFFF8E8EE))
      ],
      [
        Data(
            icon: Icons.local_grocery_store,
            text: 'Beverages',
            color: const Color(0xFF73BBC9).withOpacity(0.25),
            borderColor: const Color(0xFF73BBC9)),
        Data(
            icon: Icons.local_grocery_store,
            text: 'Snacks',
            color: const Color(0xFF8CC0DE).withOpacity(0.25),
            borderColor: const Color(0xFF8CC0DE))
      ],
      [
        Data(
            icon: Icons.local_grocery_store,
            text: 'Personal Care',
            color: const Color(0xFFFFD9C0).withOpacity(0.25),
            borderColor: const Color(0xFFFFD9C0)),
        Data(
            icon: Icons.local_grocery_store,
            text: 'Cleaning Supplies',
            color: const Color(0xFFCCEEBC).withOpacity(0.25),
            borderColor: const Color(0xFFCCEEBC))
      ],
      [
        Data(
            icon: Icons.local_grocery_store,
            text: 'Pet Care',
            color: const Color(0xFFB2A4FF).withOpacity(0.25),
            borderColor: const Color(0xFFB2A4FF)),
        Data(
            icon: Icons.local_grocery_store,
            text: 'Frozen Foods',
            color: const Color(0xFFFFB4B4).withOpacity(0.25),
            borderColor: const Color(0xFFFFB4B4))
      ],
    ];

    return SizedBox(
      height: 650,
      width: 500,
      child: SingleChildScrollView(
          child: Column(
        children: dataList.map((rowList) {
          return SingleChildScrollView(
              child: SizedBox(
                  width: 650,
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: rowList.map((data) {
                      Future<String> imageLink = getData(data.text);
                      return FutureBuilder<dynamic>(
                          future: imageLink,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return GestureDetector(
                                onTap:() {Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return categoryPage(
                                    categoryName: data.text
                                  );
                                },
                              ),
                            );},
                                child: SizedBox(
                                                          
                                  width: 125,
                                  height: 125,
                                  child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: data.color,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: data.borderColor)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              snapshot.data,
                                              height: 90,
                                              width: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                            data.text,
                                            style: const TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w300,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              );
                            }
                          });
                    }).toList(),
                  )));
        }).toList(),
      )),
    );
  }

}

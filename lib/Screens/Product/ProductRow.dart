import 'package:flutter/material.dart';
import 'package:login_page/Screens/Product/ProductTile.dart';
import 'ProductPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

class ProductRow extends StatefulWidget {
  final String rowTitle;
  String uid = '';
  final List<dynamic> productList;
  ProductRow(
      {Key? key,
      required this.rowTitle,
      required this.productList,
      required this.uid})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<ProductRow> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> getData(String productName) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.unsplash.com/search/photos?page=1&query=${productName}&per_page=1&client_id=KKbmPU7Sp9eW9Bzeb4IDQk0jueve2pM1GkYjRZJh2Gg'));
    Map<String, dynamic> imageData = json.decode(response.body);

    return imageData['results'][0]['urls']['regular'];
  }

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> cart;
    return SizedBox(
        child: Column(children: [
      Text(
        widget.rowTitle,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
      ),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: widget.productList.sublist(0, 5).map(
            (item) {
              Future<String> imageUrl = getData(item['name']);
              return FutureBuilder<dynamic>(
                  future: imageUrl,
                  builder:
                  
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    item = {...item, "imageLink": snapshot.data};
                   

                    return Padding(
                        padding: EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductPage(
                                    productData: item,
                                    cart: [],
                                    uid: widget.uid,
                                  );
                                },
                              ),
                            );
                          },
                          child: ProductTitle(
                            image: snapshot.data,
                            productName: '${item['name']}',
                            productComparedPrice: '\$${item['price_per_100g']}',
                            productMRP: '\$${item['price']}',
                          ),
                        ));
                  });
            },
          ).toList()))
    ]));
  }
}

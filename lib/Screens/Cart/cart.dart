import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_page/Screens/Product/cartTile.dart';

import '../Product/ProductPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Cart(uid: 'fbS1SFRC15Vw3Y1VOgiK3xRc9Pi1'));
}

class Cart extends StatefulWidget {
  String uid = '';

  Cart({Key? key, required this.uid}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

addToCart(String userUid) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  DataSnapshot snapshot = await ref.child('User/${userUid}').get();
  if (snapshot.exists) {
    final map = snapshot.value;
    print('flutter cart: ${map}');
    return map;
  } else {
    print('No data available.');
  }
}

class _CartState extends State<Cart> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // addToCart('fbS1SFRC15Vw3Y1VOgiK3xRc9Pi1');
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              bottomOpacity: 0.0,
              elevation: 0.0,
              title: const Text(
                'Cart',
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
            body: FutureBuilder<dynamic>(
                future: addToCart('fbS1SFRC15Vw3Y1VOgiK3xRc9Pi1'),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    print('snapshot.data: ${snapshot.data['cart']}');
                    List<dynamic> productList = snapshot.data['cart'];
                    return Container(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                  children: productList.map(
                                (item) {
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
                                        child: CartTile(
                                          image: item['imageLink'],
                                          productName: '${item['name']}',
                                          productComparedPrice:
                                              '\$${item['price_per_100g']}',
                                          productMRP: '\$${item['price']}',
                                        ),


                                      ));
                                },
                              ).toList(),
                              )),
                          ElevatedButton(
                            onPressed: () {},
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Sign Out".toUpperCase(),
                                      style: const TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20)),
                                ),
                                const Icon(Icons.logout_outlined)
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                })));
  }
}

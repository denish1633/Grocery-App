// ignore_for_file: file_names

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.shopping_cart_outlined,
    title: 'Add To Cart',
  ),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class ProductPage extends StatefulWidget {
  Map<dynamic, dynamic> productData;
  List<dynamic> cart;
  String uid = '';

  ProductPage(
      {Key? key,
      required this.productData,
      required this.cart,
       uid})
      : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _counter = 0;
  double _price = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _price = widget.productData['price'] * _counter;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter == 0) {
        _counter = 0;
        _price = widget.productData['price'];
      } else if (_counter == 1) {
        _counter = 0;
        _price = widget.productData['price'];
      } else {
        _counter--;
        _price = widget.productData['price'] * _counter;
      }
    });
  }

  Future<void> addToCart() async {
    List<dynamic> map;
    List<dynamic> newList = [];
    final ref = FirebaseDatabase.instance.ref().child('User/${widget.uid}');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      map = [snapshot.value];
      if (map[0]['cart'] == null) {
        widget.productData['quantityOrdered'] = _counter;
        map[0]['cart'] = widget.productData;
        await ref.update({
          "cart": [widget.productData],
        });
      } else {
        widget.productData['quantityOrdered'] = _counter;
        widget.cart = {...widget.cart, widget.productData}.toList();
        newList = [...map[0]['cart'], widget.cart[0]];
        map[0]['cart'] = newList;
        print('flutter cart: $newList');
        await ref.update({
          "cart": newList,
        });
      }
    } else {
      print('No data available.');
    }
  }

  int visit = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget detailPage(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                  child: Column(
                children: [
                  const Divider(
                    height: 1,
                    thickness: 2,
                    indent: 1,
                    endIndent: 0,
                    color: Colors.grey,
                  ),
                  ExpandablePanel(
                      header: const Text("Product Detail",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Gilroy',
                            color: Colors.black,
                          )),
                      collapsed: const Text(
                        "",
                      ),
                      expanded: const Text(
                        "body",
                        softWrap: true,
                      )),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 1,
                    endIndent: 0,
                    color: Colors.grey,
                  ),
                  ExpandablePanel(
                      header: const Text("Nutrition",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Gilroy',
                            color: Colors.black,
                          )),
                      collapsed: const Text(
                        "",
                      ),
                      expanded: const Text(
                        "body",
                        softWrap: true,
                      )),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 1,
                    endIndent: 0,
                    color: Colors.grey,
                  ),
                  ExpandablePanel(
                      header: const Text("Review",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Gilroy',
                            color: Colors.black,
                          )),
                      collapsed: const Text(
                        "",
                      ),
                      expanded: const Text(
                        "body",
                        softWrap: true,
                      )),
                  ExpandablePanel(
                      header: const Text("Review",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Gilroy',
                            color: Colors.black,
                          )),
                      collapsed: const Text(
                        "",
                      ),
                      expanded: const Text(
                        "body",
                        softWrap: true,
                      )),
                  ExpandablePanel(
                      header: const Text("Review",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Gilroy',
                            color: Colors.black,
                          )),
                      collapsed: const Text(
                        "",
                      ),
                      expanded: const Text(
                        "body",
                        softWrap: true,
                      )),
                  ExpandablePanel(
                      header: const Text("Review",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Gilroy',
                            color: Colors.black,
                          )),
                      collapsed: const Text(
                        "",
                      ),
                      expanded: const Text(
                        "body",
                        softWrap: true,
                      ))
                ],
              )),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const IconData shopping_bag = IconData(0xe59a, fontFamily: 'MaterialIcons');
    const IconData arrow_back =
        IconData(0xe092, fontFamily: 'MaterialIcons', matchTextDirection: true);

    return Scaffold(
      body: SafeArea(
        child: Column(children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffF2F3F2),
                      borderRadius: BorderRadius.circular(10)),
                  width: 400,
                  height: 370,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Image.network(
                        widget.productData['imageLink'],
                        height: 80,
                        width: 170,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(arrow_back),
                        Icon(
                          shopping_bag,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.all(17),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${widget.productData['name']}',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 28,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '\$${widget.productData['price_per_100g']}',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Gilroy',
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 70,
                          width: 157,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: _decrementCounter,
                                      iconSize: 35,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      width: 55,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Text(
                                        '$_counter',
                                        style: const TextStyle(fontSize: 25),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      color: Colors.green,
                                      onPressed: _incrementCounter,
                                      iconSize: 35,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          '\$$_price',
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 30,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                        height: 219,
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            const Divider(
                              height: 1,
                              thickness: 2,
                              indent: 1,
                              endIndent: 0,
                              color: Colors.grey,
                            ),
                            ExpandablePanel(
                                header: const Text("Product Detail",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Gilroy',
                                      color: Colors.black,
                                    )),
                                collapsed: const Text(
                                  "",
                                ),
                                expanded: const Text(
                                  "body",
                                  softWrap: true,
                                )),
                            const Divider(
                              height: 20,
                              thickness: 2,
                              indent: 1,
                              endIndent: 0,
                              color: Colors.grey,
                            ),
                            ExpandablePanel(
                                header: const Text("Nutrition",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Gilroy',
                                      color: Colors.black,
                                    )),
                                collapsed: const Text(
                                  "",
                                ),
                                expanded: const Text(
                                  "body",
                                  softWrap: true,
                                )),
                            const Divider(
                              height: 20,
                              thickness: 2,
                              indent: 1,
                              endIndent: 0,
                              color: Colors.grey,
                            ),
                            ExpandablePanel(
                                header: const Text("Review",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Gilroy',
                                      color: Colors.black,
                                    )),
                                collapsed: const Text(
                                  "",
                                ),
                                expanded: const Text(
                                  "body",
                                  softWrap: true,
                                )),
                          ],
                        ))),
                  ])),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // widget.cart = {...widget.productData, widget.productData};

                addToCart();
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(450, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff40aa54))),
              child: Text("add to cart".toUpperCase(),
                  style: const TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w300,
                      fontSize: 20)),
            ),
          )
        ]),
      ),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.only(bottom: 10, right: 32, left: 32),
      //   child: BottomBarFloating(
      //     items: items,
      //     backgroundColor: Colors.white,
      //     color: Colors.black,
      //     colorSelected: Colors.green,
      //     indexSelected: visit,
      //     paddingVertical: 10,
      //     onTap: (int index) => {
      //       print(widget.productData['price_per_100g'] * _counter);
      //       widget.cart={...widget.cart,widget.productData}.toList()

      //     },
      //     borderRadius: BorderRadius.circular(65),
      //   ),
      // ),
    );
  }
}

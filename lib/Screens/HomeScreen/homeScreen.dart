import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:login_page/Screens/Account/account.dart';
import 'package:login_page/Screens/HomeScreen/bannerPage.dart';
import 'package:login_page/Screens/Product/ProductRow.dart';
import 'package:login_page/Screens/FindPage/find.dart';
import 'package:login_page/Screens/Login/login_screen.dart';

import '../Cart/cart.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home,
    title: 'Home',
  ),
  TabItem(
    icon: Icons.search_sharp,
    title: 'Shop',
  ),
  TabItem(
    icon: Icons.favorite_border,
    title: 'Wishlist',
  ),
  TabItem(
    icon: Icons.shopping_cart_outlined,
    title: 'Cart',
  ),
  TabItem(
    icon: Icons.account_box,
    title: 'profile',
  ),
];

class MyHomePage extends StatefulWidget {
  String uid = '';
  MyHomePage({Key? key, required this.uid}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
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

class _MyHomePageState extends State<MyHomePage> {
  int visit = 0;

  late Future<dynamic> vegetableCollection;
  late Future<dynamic> fruitCollection;
  late Future<dynamic> bakeryProductCollection;
  late Future<dynamic> beveragesCollection;
  late Future<dynamic> cannedGoodsCollection;
  late Future<dynamic> cleaningSuppliesCollection;
  late Future<dynamic> dairyProductsCollection;
  late Future<dynamic> frozenFoodCollection;
  late Future<dynamic> meatCollection;
  late Future<dynamic> personalCareCollection;
  late Future<dynamic> petCareCollection;
  late Future<dynamic> snacksCollection;

  @override
  void initState() {
    super.initState();
    vegetableCollection = getProductCollection('vegetables');
    fruitCollection = getProductCollection('fruits');
    bakeryProductCollection = getProductCollection('bakery_products');
    beveragesCollection = getProductCollection('beverages');
    cannedGoodsCollection = getProductCollection('canned_goods');
    cleaningSuppliesCollection = getProductCollection('cleaning_supplies');
    dairyProductsCollection = getProductCollection('dairy_products');
    frozenFoodCollection = getProductCollection('frozen_food');
    meatCollection = getProductCollection('meat');
    personalCareCollection = getProductCollection('personal_care');
    petCareCollection = getProductCollection('pet_care');
    snacksCollection = getProductCollection('snacks');
  }

  @override
  Widget build(BuildContext context) {
               

    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: Future.wait([
          vegetableCollection,
          fruitCollection,
          // bakeryProductCollection,
          // beveragesCollection,
          // cannedGoodsCollection,
          // cleaningSuppliesCollection,
          // dairyProductsCollection,
          // frozenFoodCollection,
          // meatCollection,
          // personalCareCollection,
          // petCareCollection,
          // snacksCollection
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final vegetableList = snapshot.data[0];
            final fruitList = snapshot.data[1];

            return Scaffold(
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
                  child: SingleChildScrollView(
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
                      const SizedBox(
                        height: 220,
                        child: bannerPage(),
                      ),
                      ProductRow(
                          rowTitle: "Fresh vegetables",
                          uid: widget.uid,
                          productList: snapshot.data[0]),
                      ProductRow(
                        rowTitle: "Fresh Fruits",
                        productList: snapshot.data[1],
                        uid: widget.uid,
                      ),

                    ],
                  ))),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.only(bottom: 30, right: 32, left: 32),
                child: BottomBarFloating(
                  items: items,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                  colorSelected: Colors.green,
                  indexSelected: visit,
                  paddingVertical: 20,
                  onTap: (int index) {
                    switch (index) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                        break;
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return FindPage(uid: widget.uid);
                            },
                          ),
                        );
                        break;

                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return FindPage(uid: widget.uid);
                            },
                          ),
                        );
                        break;

                      case 3:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Cart(uid: widget.uid);
                            },
                          ),
                        );
                        break;

                      case 4:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Account();
                            },
                          ),
                        );
                        break;
                    }
                  },
                  borderRadius: BorderRadius.circular(65),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

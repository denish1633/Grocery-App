import 'package:flutter/material.dart';

class CartTile extends StatefulWidget {
  final String image;
  final String productName;
  final String productComparedPrice;
  final String productMRP;
  List<dynamic> cart = [];

  CartTile(
      {Key? key,
      required this.image,
      required this.productName,
      required this.productComparedPrice,
      required this.productMRP})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<CartTile> {
  int _counter = 0;
  double _price = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      // _price = widget.productData['price'] * _counter;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter == 0) {
        _counter = 0;
        // _price = widget.productData['price'];
      } else if (_counter == 1) {
        _counter = 0;
        // _price = widget.productData['price'];
      } else {
        _counter--;
        // _price = widget.productData['price'] * _counter;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 125,
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Image.network(
                widget.image,
                height: 110,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20
                      ,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.productComparedPrice,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w100,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 62,
                        width: 157,
                        child: Column(
                          children: <Widget>[
                            Row(

                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: _decrementCounter,
                                  iconSize: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  width: 20,
                                  child: Text(
                                    '$_counter',
                                    style: const TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  color: Colors.green,
                                  onPressed: _incrementCounter,
                                  iconSize: 20,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.productMRP,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w100,
                          color: Colors.black,
                        ),
                      ),
                      // SizedBox(
                      //   width: 30,
                      //   height: 30,
                      //   child: FittedBox(
                      //     child: FloatingActionButton(
                      //       heroTag: '',
                      //       backgroundColor: Colors.green,
                      //       foregroundColor: Colors.white,
                      //       onPressed: () => {},
                      //       child: const Icon(
                      //         Icons.add,
                      //         size: 40,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),const Divider(
              height: 5,
              thickness: 5
              ,
              indent: 1,
              endIndent: 0,
              color: Colors.grey,
            )
          ]),
    );
  }
}

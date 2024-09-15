import 'package:flutter/material.dart';

class ProductTitle extends StatefulWidget {
  final String image;
  final String productName;
  final String productComparedPrice;
  final String productMRP;
  List<dynamic> cart = [];
  ProductTitle(
      {Key? key,
      required this.image,
      required this.productName,
      required this.productComparedPrice,
      required this.productMRP})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<ProductTitle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
              width: 130,
              height: 158,
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      child: Image.network(
                        widget.image,
                        height: 90,
                        width: 170,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      widget.productName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 17,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.productComparedPrice,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w100,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.productMRP,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w100,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: FittedBox(
                            child: FloatingActionButton(
                              heroTag: '',
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              onPressed: () => {},
                              child: const Icon(
                                Icons.add,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
            );
  }
}

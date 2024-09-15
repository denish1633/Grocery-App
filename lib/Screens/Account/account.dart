import 'package:flutter/material.dart';

main() {
  runApp(const Account());
}

class Data {
  final IconData icon;
  final String title;
  Data({
    required this.icon,
    required this.title,
  });
}

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List<Data> items = [
    Data(icon: Icons.shopping_bag_outlined, title: 'Orders'),
    Data(icon: Icons.badge_outlined, title: 'My Details'),
    Data(icon: Icons.location_on_outlined, title: 'Delivery Address'),
    Data(icon: Icons.payment, title: 'Payment Method'),
    Data(icon: Icons.discount_outlined, title: 'Promo Code'),
    Data(icon: Icons.notifications_none_outlined, title: 'Notification'),
    Data(icon: Icons.help_outline_outlined, title: 'Help'),
    Data(icon: Icons.info_outline, title: 'About')
  ];
  Widget settings() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map(
              (item) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: ListTile(
                    leading: Icon(
                      item.icon,
                      color: Colors.black,
                      size: 30,
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 25,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              bottomOpacity: 0.0,
              elevation: 0.0,
              title: const Text(
                'Account',
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
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                          radius: 40,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Denish_1633',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  settings(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(450, 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff40aa54))),
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
            )));
  }
}

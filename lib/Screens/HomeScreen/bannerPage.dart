import 'package:flutter/material.dart';
import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';

class bannerPage extends StatefulWidget {
  const bannerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<bannerPage> {
  static  final List<String> _images = [
   'assets/images/banner1.jpg',
    'assets/images/banner2.png',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            ///Indicator
            const SliverPadding(
              padding: EdgeInsets.all(16),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 164,
                child: ScrollPageView(
                  controller: ScrollPageController(),
                  delay: const Duration(seconds: 3),
                  indicatorAlign: Alignment.bottomCenter,
                  indicatorColor: Colors.white,
                  checkedIndicatorColor: Colors.green,
                  children: (_images.reversed)
                      .map((image) => _imageView(image))
                      .toList(),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  ///Image
  Widget _imageView(String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(image),
      ),
    );
  }
}

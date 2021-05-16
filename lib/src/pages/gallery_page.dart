import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final List<String> imageUrls;
  final int selectedTab;

  const GalleryPage({Key key, @required this.imageUrls,
    @required this.selectedTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              initialPage: selectedTab
              // autoPlay: false,
            ),
            items: imageUrls.map((item) => Container(
              child: Center(
                  child: Image.network(item, fit: BoxFit.contain, height: height)
              ),
            )).toList(),
          );
        },
      ),
    );
  }
}

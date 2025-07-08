import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const urlImages = [
    Image(image: AssetImage('assets/home.png')),
    Image(image: AssetImage('assets/home.png')),
    Image(image: AssetImage('assets/home.png')),
    Image(image: AssetImage('assets/home.png')),
    Image(image: AssetImage('assets/home.png')),
  ];

  @override
  Widget build(BuildContext context) {
    Scaffold(
      body: Center(
        child: CarouselSlider.builder(
          itemCount: urlImages.length,
          itemBuilder: (context, index, realIndex) {
            return buildImage(urlImages, index);
          },
          options: CarouselOptions(
            height: 400,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
          ),
        ),
      ),
    );
  }
   Widget buildImage(List<Image> images, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: images[index],
    );
  }
}
 

import 'package:begining/products/iphone_15.dart';
import 'package:begining/provider/carousel_provider.dart';
import 'package:begining/provider/password_provider.dart';
import 'package:begining/screen/navigation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  // Track the active index for the carousel
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
    final carouselProvider = Provider.of<CarouselProvider>(context);
    int activeIndex = carouselProvider.activeIndex;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    'Shop',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF007FFF)),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        focusColor: Color(0xFF007FFF),
                        labelText: 'Search',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 210, 210, 210),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 248, 248, 248),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: urlImages.length,
                      itemBuilder: (context, index, realIndex) {
                        return buildImage(urlImages, index);
                      },
                      options: CarouselOptions(
                        height: 90,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        onPageChanged: (index, reason) {
                          carouselProvider.setIndex(
                            index,
                          ); // Handle page change if needed
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    buildIndicator(activeIndex),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'New Items',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Color(0xFFF4F4F4),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Iphone15(),
                                ), // Thay NewPage bằng trang bạn muốn chuyển đến
                              );
                            },
                            child: SizedBox(
                              width: 100,
                              child: Column(
                                children: [
                                  Card(
                                    child: Image.asset('assets/products/iphone_15.png'),
                                  ),
                                  Text(
                                    'iPhone 15',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Nunito Sans',
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    '\$999',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                Card(
                                  child: Image.asset('assets/products/iphone_16.png'),
                                ),
                                Text(
                                  'iPhone 16',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito Sans',
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  '\$1099',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                Card(child: Image.asset('assets/products/Car.png')),
                                Text(
                                  'Car Model',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  '\$20,000',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                Card(child: Image.asset('assets/products/laptop.png')),
                                Text(
                                  'Laptop',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito Sans',
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  '\$1500',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Color(0xFFF4F4F4),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                Card(
                                  child: Image.asset('assets/products/iphone_15.png'),
                                ),
                                Text(
                                  'iPhone 15',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito Sans',
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  '\$999',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                Card(
                                  child: Image.asset('assets/products/iphone_16.png'),
                                ),
                                Text(
                                  'iPhone 16',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito Sans',
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  '\$1099',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                Card(child: Image.asset('assets/products/Car.png')),
                                Text(
                                  'Car Model',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito Sans',
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  '\$20,000',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            child: Column(
                              children: [
                                Card(child: Image.asset('assets/products/laptop.png')),
                                Text(
                                  'Laptop',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito Sans',
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  '\$1500',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navigation(),
    );
  }

  Widget buildImage(List<Image> images, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: images[index],
    );
  }

  Widget buildIndicator(int activeIndex) => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: urlImages.length,
    effect: const JumpingDotEffect(
      dotWidth: 10,
      dotHeight: 10,
      activeDotColor: Colors.blue,
      dotColor: Colors.grey,
    ),
  );
}

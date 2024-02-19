import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/BusinessNews.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'PopularNews.dart';
import 'RecentNews.dart';
import 'TopNews.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  int activeIndex = 0;

  @override
  void initState() {
    categories = getCategories();
    sliders = getSliders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 188, 238, 190),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Daily ",
              style: TextStyle(
                color: Color.fromARGB(255, 233, 173, 84),
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            Text(
              "News   ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            CarouselSlider.builder(
              itemCount: sliders.length,
              itemBuilder: (context, index, realIndex) {
                String? res = sliders[index].image;
                String? res1 = sliders[index].name;
                return buildImage(res!, index, res1!);
              },
              options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(child: buigIndicator()),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      image: categories[index].image,
                      categoryName: categories[index].categoryName,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Popular News",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PopularNews(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Background color of the button
                      onPrimary: Colors.blue, // Text color
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recent News",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecentNews()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Background color of the button
                      onPrimary: Colors.blue, // Text color
                      elevation: 5, // Elevation of the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Business News",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BusinessNews()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Background color of the button
                      onPrimary: Colors.blue, // Text color
                      elevation: 5, // Elevation of the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top News",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TopNews()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Background color of the button
                      onPrimary: Colors.blue, // Text color
                      elevation: 5, // Elevation of the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(top: 130),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Center(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buigIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: sliders.length,
      );
}

class CategoryTile extends StatelessWidget {
  final String? image;
  final String? categoryName;

  CategoryTile({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                image!,
                width: 200,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 200,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black38,
              ),
              child: Center(
                child: Text(
                  categoryName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryModel {
  String? categoryName;
  String? image;
}

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.categoryName = "Business";
  categoryModel.image = "images/business.png";
  categories.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryModel.image = "images/entertainment.jpg";
  categories.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "General";
  categoryModel.image = "images/general.jpg";
  categories.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Health";
  categoryModel.image = "images/health.jpg";
  categories.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Sports";
  categoryModel.image = "images/sports.jpg";
  categories.add(categoryModel);

  return categories;
}

class SliderModel {
  String? image;
  String? name;
}

List<SliderModel> getSliders() {
  List<SliderModel> slider = [];

  SliderModel categoryModel = SliderModel();
  categoryModel.image = "images/business.png";
  categoryModel.name =
      "Stay savvy in business with quick news updates on our app.";
  slider.add(categoryModel);

  categoryModel = SliderModel();
  categoryModel.image = "images/entertainment.jpg";
  categoryModel.name =
      "Enjoy the latest in entertainment quick updates on movies, music, and more.";
  slider.add(categoryModel);

  categoryModel = SliderModel();
  categoryModel.image = "images/general.jpg";
  categoryModel.name =
      "Stay updated with our app for quick, global news bites.";
  slider.add(categoryModel);

  categoryModel = SliderModel();
  categoryModel.image = "images/health.jpg";
  categoryModel.name =
      "Stay healthy, stay informed quick health news updates in one app.";
  slider.add(categoryModel);

  categoryModel = SliderModel();
  categoryModel.image = "images/sports.jpg";
  categoryModel.name =
      "Fuel  sports passion with quick updates on our app stay in the game.";
  slider.add(categoryModel);

  return slider;
}

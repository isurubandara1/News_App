import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];

  @override
  void initState() {
    categories = getCategories();
    sliders = getSliders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              "News",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
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
          CarouselSlider.builder(
            itemCount: sliders.length,
            itemBuilder: (context, index, realIndex) {
              String? res = sliders[index].image;
              String? res1 = sliders[index].name;
              return buildImage(res!, index, res1!);
            },
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
        child: Image.asset(image,
            fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
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
                  style: TextStyle(
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
  categoryModel.image = "images/business.jpg";
  categories.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryModel.image = "images/entertainment.jpg";
  categories.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "General";
  categoryModel.image = "images/general.png";
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
  categoryModel.image = "images/business.jpg";
  categoryModel.name = "Business";
  slider.add(categoryModel);

  categoryModel = SliderModel();
  categoryModel.image = "images/entertainment.jpg";
  categoryModel.name = "Entertainment";
  slider.add(categoryModel);

  categoryModel = SliderModel();
  categoryModel.image = "images/general.png";
  categoryModel.name = "General";
  slider.add(categoryModel);

  categoryModel = SliderModel();
  categoryModel.image = "images/health.jpg";
  categoryModel.name = "Health";
  slider.add(categoryModel);

  categoryModel = SliderModel();
  categoryModel.image = "images/sports.jpg";
  categoryModel.name = "Sports";
  slider.add(categoryModel);

  return slider;
}

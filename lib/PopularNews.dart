import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PopularNews extends StatefulWidget {
  @override
  _PopularNewsState createState() => _PopularNewsState();
}

class _PopularNewsState extends State<PopularNews> {
  List<NewsArticle> _newsArticles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final apiKey = "3064c6263d7649ce9cd06f05adc66cf1";
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=apple&from=2024-02-17&to=2024-02-17&sortBy=popularity&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'ok') {
        List articles = data['articles'];
        setState(() {
          _newsArticles = articles
              .where((article) => article['urlToImage'] != null)
              .map((article) => NewsArticle.fromJson(article))
              .toList();
        });
      }
    }
  }

  void _showNewsDetails(NewsArticle newsArticle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailsScreen(newsArticle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 188, 238, 190),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Popular News 🌟🔥🌐🚀',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _newsArticles.length,
        itemBuilder: (context, index) {
          Color backgroundColor = index % 2 == 0
              ? const Color.fromARGB(255, 114, 113, 113)
              : Colors.black54;
          return Card(
            color: backgroundColor,
            child: ListTile(
              title: Text(
                _newsArticles[index].title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  _newsArticles[index].imageUrl,
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.fill,
                ),
              ),
              onTap: () => _showNewsDetails(_newsArticles[index]),
            ),
          );
        },
      ),
    );
  }
}

class NewsArticle {
  final String title;
  final String description;
  final String imageUrl;
  final String url;
  final String publishedAt;

  NewsArticle({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      description: json['description'],
      imageUrl: json['urlToImage'],
      url: json['url'],
      publishedAt: json['publishedAt'],
    );
  }
}

class NewsDetailsScreen extends StatelessWidget {
  final NewsArticle newsArticle;

  NewsDetailsScreen(this.newsArticle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Back',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.brown),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                newsArticle.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  newsArticle.imageUrl,
                  width: double.infinity,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  'Published at: ${newsArticle.publishedAt}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              SizedBox(height: 8),
              Text(
                newsArticle.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Content:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () => _openNewsUrl(newsArticle.url),
                child: Text(
                  newsArticle.url,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openNewsUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error
      print('Could not launch $url');
    }
  }
}

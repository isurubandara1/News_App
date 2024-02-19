import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RecentNews extends StatefulWidget {
  @override
  _RecentNewsState createState() => _RecentNewsState();
}

class _RecentNewsState extends State<RecentNews> {
  List<NewsArticle> _newsArticles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final apiKey = "3064c6263d7649ce9cd06f05adc66cf1";
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2024-01-19&sortBy=publishedAt&apiKey=$apiKey'));

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

  Future<void> _refreshNews() async {
    await fetchNews();
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
          'Recent News 🌟🔥🚀',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: _refreshNews,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: ListView.builder(
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
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['urlToImage'] ?? 'https://example.com/default-image.jpg',
      url: json['url'] ?? 'https://example.com',
      publishedAt: json['publishedAt'] ?? 'No Date',
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

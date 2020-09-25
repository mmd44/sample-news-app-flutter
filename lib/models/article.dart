class Article {
  final ArticleSource source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: ArticleSource(json['source']['id'], json['source']['name']),
      author: json['author'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

  static List<Article> fromJsonList(List json) =>
      json.map((variable) => Article.fromJson(variable)).toList();
}

class ArticleSource {
  final String id;
  final String name;

  ArticleSource(this.id, this.name);
}

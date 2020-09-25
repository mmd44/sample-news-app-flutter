import 'package:topnews/models/article.dart';
import 'package:topnews/network/api.dart';
import 'package:topnews/network/network.dart';

class ArticlesService {
  Future<List<Article>> getTopNewsArticles({int pageSize, int page}) async {
    Map<String, dynamic> params = {
      'pageSize': pageSize ?? 10,
      'page' : page ?? 1,
    };
    return HttpRequest.get(API.topHeadlines, params: params)
        .then((dynamic res) => Article.fromJsonList((res as Map)['articles']));
  }
}

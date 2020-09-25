import 'package:rxdart/rxdart.dart';
import 'package:topnews/models/article.dart';
import 'package:topnews/services/articles_service.dart';

class MainController {
  BehaviorSubject<bool> _isFetching;
  BehaviorSubject<List<Article>> _articles;

  ArticlesService _service;

  /// Articles per page
  int pageSize;

  /// Page Number (Pagination)
  int pageNumber;

  MainController({
    this.pageSize = 10,
    this.pageNumber = 1,
  }) {
    _articles = BehaviorSubject<List<Article>>.seeded(null);
    _isFetching = BehaviorSubject<bool>.seeded(false);
    init();
  }

  Stream<List<Article>> get articlesStream => _articles.stream;

  List<Article> get articles => _articles.value;

  Stream<bool> get isFetchingStream => _isFetching.stream;

  bool get isFetching => _isFetching.value;

  /// Fetches the articles
  void init({bool isReset = false}) async {
    _service = ArticlesService();
    if (isReset) if (!_articles.isClosed) _articles.add(null);
    pageNumber = 1;
    try {
      if (!_isFetching.isClosed) _isFetching.add(true);
      List<Article> res = await _service.getTopNewsArticles(
          page: pageNumber, pageSize: pageSize);
      if (!_articles.isClosed) _articles.add(res);
      if (!_isFetching.isClosed) _isFetching.add(false);
    } catch (e) {
      if (!_isFetching.isClosed) {
        _isFetching.addError(e);
      }
    }
  }

  Future<List<Article>> loadMoreArticles() {
    pageNumber++;

    return _service.getTopNewsArticles(
      pageSize: pageSize,
      page: pageNumber,
    );
  }

  void dispose() {
    if (!_articles.isClosed) _articles.close();
    if (!_isFetching.isClosed) _isFetching.close();
  }
}

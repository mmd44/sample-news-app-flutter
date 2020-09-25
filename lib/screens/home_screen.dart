import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:topnews/controllers/main_controller.dart';
import 'package:topnews/models/article.dart';
import 'package:topnews/screens/article_details_screen.dart';
import 'package:topnews/utils/strings.dart';

import 'articles_list_view.dart';

class HomeScreen extends StatefulWidget {
  final MainController controller;

  @override
  _HomeScreenState createState() => new _HomeScreenState();

  HomeScreen({this.controller}) : assert(controller != null);
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  MainController _controller;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _controller = widget.controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Hero(
              tag: 'logo_hero',
              child: Image.asset(
                'assets/images/topnews_logo.png',
                color: Colors.black,
                width: 50,
                height: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(Strings.name),
            ),
          ],
        ),
        actions: <Widget>[],
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        child: SafeArea(
          bottom: false,
          child: Container(
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/topnews_logo.png',
                          color: Colors.black,
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          Strings.name,
                          style:
                              TextStyle(color: Colors.deepPurple, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.deepPurple,
                    indent: 25,
                    endIndent: 25,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.notification_important,
                      color: Colors.deepPurple,
                      size: 25,
                    ),
                    title: Align(
                      alignment: Alignment(-1.3, 0),
                      child: Text(
                        Strings.topHeadlines,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    onTap: () {
                      _controller.init(isReset: true);
                      Navigator.of(context).pop();
                    },
                  ),
                  Divider(
                    color: Colors.deepPurple,
                    indent: 10,
                    endIndent: 10,
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<bool>(
        stream: _controller.isFetchingStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white12,
                strokeWidth: 2,
              ),
            );
          } else {
            if (snapshot.hasError)
              return Center(
                child: Text('An Error has Occurred!'),
              );
            return Padding(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
              child: PaginationView<Article>(
                preloadedItems: _controller.articles,
                separatorBuilder: (c, i) => Divider(height: 0.25),
                itemBuilder:
                    (BuildContext context, Article article, int index) =>
                        Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return ArticleDetailsScreen(article.url);
                      }),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: article.urlToImage ?? '',
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fitHeight,
                                  colorFilter: ColorFilter.mode(
                                      Colors.blueGrey, BlendMode.dstOver)),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            width: 100,
                            height: 200,
                            child: Icon(
                              Icons.image,
                              size: 100,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 100,
                            height: 200,
                            child: Icon(
                              Icons.error,
                              size: 100,
                            ),
                          ),
                          fadeInCurve: Curves.fastLinearToSlowEaseIn,
                          fadeInDuration: Duration(seconds: 1),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(article.title),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      article.description,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                paginationViewType: PaginationViewType.listView,
                pageFetch: (count) => _controller.loadMoreArticles(),
                onError: (dynamic error) => Center(
                  child: Text('An Error has Occurred!'),
                ),
                onEmpty: Center(
                  child: Text('Sorry! No articles for today!'),
                ),
                bottomLoader: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white12,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                initialLoader: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white12,
                    strokeWidth: 2,
                  ),
                ),
              ),
            );
          }
        });
  }
}

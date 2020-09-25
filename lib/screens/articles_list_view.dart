/*
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topnews/controllers/main_controller.dart';
import 'package:topnews/models/article.dart';

class ArticlesListView extends StatefulWidget {
  final MainController controller;

  ArticlesListView({
    @required this.controller,
  });

  @override
  _ArticlesListViewState createState() => _ArticlesListViewState();
}

class _ArticlesListViewState extends State<ArticlesListView> {
  ScrollController _scrollController;
  MainController _controller;

  void _scrollListener() {
    if (_scrollController.offset / _scrollController.position.maxScrollExtent * 100>80) _controller.loadMoreArticles();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _controller = widget.controller;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _controller.init();
      },
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 11),
        child: Container(
          color: Colors.white,
          child: NotificationListener(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int i) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            dense: true,
                            leading: Container(
                              width: 50,
                              height: 60,
                              child: CachedNetworkImage(
                                imageUrl: _controller.articles[i].urlToImage ?? '',
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.red, BlendMode.colorBurn)),
                                  ),
                                ),
                                placeholder: (context, url) => Icon(Icons.image),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                            title: Text(_controller.articles[i].title),
                          ),
                          Divider(height: 0.25),
                        ],
                      );
                    },
                    childCount: _controller.articles.length,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(30.0),
                  sliver: SliverToBoxAdapter(
                    child: StreamBuilder<bool>(
                      stream: _controller.isLoadingMoreStream,
                      initialData: _controller.isLoadingMore,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.hasData && snapshot.data)
                          return Center(
                            child: CircularProgressIndicator(backgroundColor: Colors.deepPurple,),
                          );
                        if (_controller.articles.length < _controller.pageSize)
                          return SizedBox.shrink();
                        return Center(
                          child: Text('No more articles to load'),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/

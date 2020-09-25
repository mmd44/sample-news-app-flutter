import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topnews/utils/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final String articleURL;

  ArticleDetailsScreen(this.articleURL);

  @override
  _ArticleDetailsScreenState createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.name),
        actions: <Widget>[],
      ),
      body: _buildWebview(),
    );
  }

  Widget _buildWebview() {
    return Stack(
      children: <Widget>[
        WebView(
          initialUrl: widget.articleURL,
          onPageFinished: (finish) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
        _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white12,
                  strokeWidth: 2,
                ),
              )
            : Stack(),
      ],
    );
  }
}

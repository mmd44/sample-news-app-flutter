import 'dart:async';

import 'package:flutter/material.dart';
import 'package:topnews/controllers/main_controller.dart';
import 'package:topnews/models/article.dart';
import 'package:topnews/utils/custom_navigator.dart';
import 'package:topnews/utils/strings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  MainController _controller = MainController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Article>>(
        stream: _controller.articlesStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Timer(Duration(seconds: 2),
                () => CustomNavigator.goToHome(context, _controller));
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text(Strings.genericError, style: TextStyle(fontSize: 24),)),
            );
          }
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: Colors.deepPurple),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50.0,
                              child: Hero(
                                  tag: 'logo_hero',
                                  child: Image.asset(
                                    'assets/images/topnews_logo.png',
                                    color: Colors.black,
                                    width: 75,
                                    height: 75,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
                            Text(
                              Strings.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 2,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                          ),
                          Text(
                            Strings.name_slogan,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}

import 'package:http/http.dart' as http;
import 'package:topnews/network/network.dart';

class NetworkSetup {
  NetworkSetup();


  void setNetworkLanguage(String languageCode) async {
    HttpRequest.defaultParams['language'] = languageCode;
  }

  void setNetworkHeaders() {
    HttpRequest.beforeMiddleware = beforeMiddleware;
    HttpRequest.afterMiddleware = afterMiddleware;
    addTokenHeader();
    addDefaultCountry('us');
  }

  void addTokenHeader() {
    String token = '4449d9ebdf2b40e388a83ff3d7fa8bbd';
    HttpRequest.defaultHeaders['Authorization'] = 'Bearer $token';
  }

  void addDefaultCountry (String countryCode) async {
    HttpRequest.defaultParams['country'] = countryCode;
  }

  void beforeMiddleware(String url, {Object body, Map headers}) {
    print('Calling: GET ${Uri.encodeFull(url)}');
  }

  void afterMiddleware(http.Response response) async {
    final String body = response.body;
    final int statusCode = response.statusCode;
    final uuid = response.headers['x-correlation-id'];
    print('RESPONSE FOR[$uuid]: ${response.request.url}');
    print('STATUS CODE: $statusCode');
    print('HEADERS: ${response.headers}');
    print('=================================');
    print('BODY: $body');
  }
}

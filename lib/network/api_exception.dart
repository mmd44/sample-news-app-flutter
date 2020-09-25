class APIException implements Exception {

  static APIException generic = APIException(
      'generic_error', 'An error has occurred, please try again later.');

  static String get genericError => generic.toString();

  /// A code returned from the API.
  String code;

  /// A message returned from the API.
  String message;

  /// A detailed message returned from the API.
  String details;

  APIException(this.code, this.message);

  APIException.fromJson(Map<String, dynamic> json) {

    code = json['code'];
    message = json['message'];
    details = json['details'];
    if ((message!=null && message!='')) {
      message = 'An error has occurred!';
    }
  }

  @override
  String toString() => message;
}

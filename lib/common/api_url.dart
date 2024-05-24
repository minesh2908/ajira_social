class ApiURL {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/';
  static const String userUrl = '${baseUrl}users?id=1';
  static const String albumUrl = '${baseUrl}albums?userId=1';
  static const String postUrl = '${baseUrl}posts?userId=1';

  static const String photosUrl = '${baseUrl}photos';
  static const String commentsUrl = '${baseUrl}comments';
}

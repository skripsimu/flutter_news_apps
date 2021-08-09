import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/news_model.dart';

class NewsProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String _apiUrl =
      'https://newsapi.org/v2/everything?q=tesla&from=2021-07-09&sortBy=publishedAt&apiKey=APIKEY';
  List<NewsModel> _news = [];
  bool isLoading = false;

  List<NewsModel> get news => _news;

  getNewsApi() async {
    print('getNewsApi called $_apiUrl');
    isLoading = true;
    try {
      var response = await Dio().get(_apiUrl);
      print(response.data);
      _news = newsModelFromJson(response.data['articles']);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      print('getNewsApi error $e');
    }
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('theme', news.toString()));
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_tutorial/article.dart';
import 'package:flutter_testing_tutorial/news_change_notifier.dart';
import 'package:flutter_testing_tutorial/news_service.dart';
import 'package:mocktail/mocktail.dart';

class BadMockNewsService implements NewsService {
  bool getArticlesCalled = false;

  @override
  Future<List<Article>> getArticles() async {
    return [
      Article(title: 'test 1', content: 'test 1 content'),
      Article(title: 'test 2', content: 'test 2 content'),
      Article(title: 'test 3', content: 'test 3 content'),
      Article(title: 'test 4', content: 'test 4 content'),
    ];
  }
}

class MockNewsService extends Mock implements NewsService{}

void main() {
  late NewsChangeNotifier sut;

  setUp(() {
    sut = NewsChangeNotifier(BadMockNewsService as NewsService);
  });
}

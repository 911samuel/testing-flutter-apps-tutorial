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

class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsChangeNotifier sut;
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
    sut = NewsChangeNotifier(mockNewsService);
  });

  test('initial values are correct', () {
    expect(sut.articles, []);
    expect(sut.isLoading, false);
  });

  group('get articles', () {
    final articlesFromService = [
      Article(title: 'test 1', content: 'test 1 content'),
      Article(title: 'test 2', content: 'test 2 content'),
      Article(title: 'test 3', content: 'test 3 content'),
      Article(title: 'test 4', content: 'test 4 content'),
    ];

    void arrangeNewArticlesReturn3Articles() {
      when(() => mockNewsService.getArticles())
          .thenAnswer((_) async => articlesFromService);
    }

    test(
      "gets Articles using NewsService",
      () async {
        arrangeNewArticlesReturn3Articles();
        await sut.getArticles();
        verify(() => mockNewsService.getArticles()).called(1);
      },
    );

    test(
      "indicates loading of data, sets articles to the ones from service, indicates that data is not loading anymore",
      () async {
        arrangeNewArticlesReturn3Articles();
        final future = sut.getArticles();
        expect(sut.isLoading, true);
        await future;
        expect(sut.articles, articlesFromService);
        expect(sut.isLoading, false);

      },
    );
  });
}

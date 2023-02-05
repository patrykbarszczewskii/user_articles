import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:user_articles/data/remote_data_sources/articles_remote_data_source.dart';
import 'package:user_articles/domain/models/article_model.dart';
import 'package:user_articles/domain/repositories/articles_repository.dart';

class MockArticlesDataSource extends Mock
    implements ArticlesRemoteRetrofitDataSource {}

void main() {
  late ArticlesRepository sut;
  late MockArticlesDataSource dataSource;

  setUp(() {
    dataSource = MockArticlesDataSource();
    sut = ArticlesRepository(remoteDataSource: dataSource);
  });

  group('getArticlesForAuthorId', () {
    test('should call remoteDataSource.getArticles() method', () async {
      //1
      when(() => dataSource.getArticles()).thenAnswer((_) async => []);
      //2

      await sut.getArticlesForAuthorId(555);

      //3

      verify(() => dataSource.getArticles()).called(1);
    });
    test('should filter data source results with provaided author id',
        () async {
      //1

      when(() => dataSource.getArticles()).thenAnswer(
        (_) async => [
          ArticleModel(1, 555, 'content1', 'picture1'),
          ArticleModel(1, 555, 'content2', 'picture2'),
          ArticleModel(1, 555, 'content3', 'picture3'),
        ],
      );
      //2

      final result = await sut.getArticlesForAuthorId(555);

      //3

      expect(
        result,
        [
          ArticleModel(1, 555, 'content1', 'picture1'),
          ArticleModel(1, 555, 'content2', 'picture2'),
          ArticleModel(1, 555, 'content3', 'picture3'),
        ],
      );
    });
  });
}

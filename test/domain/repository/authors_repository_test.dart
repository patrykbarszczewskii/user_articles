import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:user_articles/data/remote_data_sources/authors_remote_data_source.dart';
import 'package:user_articles/domain/models/author_model.dart';
import 'package:user_articles/domain/repositories/authors_repository.dart';

class MockAuthorsDataSource extends Mock
    implements AuthorsRemoteRetrofitDataSource {}

void main() {
  late AuthorsRepository sut;
  late MockAuthorsDataSource dataSource;

  setUp(() {
    dataSource = MockAuthorsDataSource();
    sut = AuthorsRepository(remoteDataSource: dataSource);
  });

  group('getAuthorModels', () {
    test('should return name and surname of author id and image', () async {
      //1
      when(() => dataSource.getAuthors()).thenAnswer((_) async => [
            AuthorModel(1, 'picture1', 'Janek', 'Kowalski'),
            AuthorModel(2, 'picture2', 'Marek', 'Malarski'),
            AuthorModel(3, 'picture3', 'Rafał', 'Psiarski'),
            AuthorModel(4, 'picture4', 'Tomek', 'Dzik'),
          ]);
      //2
      final result = await sut.getAuthorModels();
      //3

      expect(result, [
        AuthorModel(1, 'picture1', 'Janek', 'Kowalski'),
        AuthorModel(2, 'picture2', 'Marek', 'Malarski'),
        AuthorModel(3, 'picture3', 'Rafał', 'Psiarski'),
        AuthorModel(4, 'picture4', 'Tomek', 'Dzik'),
      ]);
    });
  });
}

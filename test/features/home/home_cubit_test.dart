import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';
import 'package:user_articles/app/core/enums.dart';
import 'package:user_articles/domain/models/author_model.dart';
import 'package:user_articles/domain/repositories/authors_repository.dart';
import 'package:user_articles/features/home/cubit/home_cubit.dart';

class MockAuthorsReposiotry extends Mock implements AuthorsRepository {}

void main() {
  late HomeCubit sut;
  late MockAuthorsReposiotry reposiotry;

  setUp(() {
    reposiotry = MockAuthorsReposiotry();
    sut = HomeCubit(authorsRepository: reposiotry);
  });

  group('fetchData', () {
    group('success', () {
      setUp(() {
        when(() => reposiotry.getAuthorModels()).thenAnswer((_) async => [
              AuthorModel(1, 'picture1', 'Franek', 'Janek'),
              AuthorModel(2, 'picture2', 'Józek', 'Gryf'),
              AuthorModel(3, 'picture3', 'Janina', 'Dopadło'),
            ]);
      });

      blocTest<HomeCubit, HomeState>(
        'emits Status.loading then Status.success with results',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          HomeState(status: Status.loading),
          HomeState(
            status: Status.success,
            results: [
              AuthorModel(1, 'picture1', 'Franek', 'Janek'),
              AuthorModel(2, 'picture2', 'Józek', 'Gryf'),
              AuthorModel(3, 'picture3', 'Janina', 'Dopadło'),
            ],
          ),
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => reposiotry.getAuthorModels()).thenThrow(
          Exception('test-exception-error'),
        );
      });

      blocTest<HomeCubit, HomeState>(
        'emits Status.loading then Status.error with error message',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          HomeState(status: Status.loading),
          HomeState(
            status: Status.error,errorMessage: 'Exception: test-exception-error'
          ),
        ],
      );
    });
  });
}

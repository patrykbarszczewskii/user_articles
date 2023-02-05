import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:user_articles/domain/models/author_model.dart';

void main() {
  test('should getter name retur first adn second name combined', () {
    //1

    final model = AuthorModel(1, 'picture1', 'Maciek', 'Kowalski');

    //2

    final result = model.name;

    //3

    expect(result, 'Maciek Kowalski');
  });
}

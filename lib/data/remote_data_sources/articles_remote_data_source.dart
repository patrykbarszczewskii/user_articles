import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:user_articles/domain/models/article_model.dart';

part 'articles_remote_data_source.g.dart';

@RestApi(baseUrl: 'https://my-json-server.typicode.com/adamsmaka/json-demo')
abstract class ArticlesRemoteRetrofitDataSource {
  factory ArticlesRemoteRetrofitDataSource(Dio dio, {String baseUrl}) =
      _ArticlesRemoteRetrofitDataSource;

  @GET("/articles")
  Future<List<ArticleModel>> getArticles();
}

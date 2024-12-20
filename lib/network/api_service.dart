import 'package:dio/dio.dart';
import 'package:dio_setup/models/post_model.dart';
import 'package:dio_setup/models/post_request.dart';
import 'package:dio_setup/network/api_exception.dart';
import 'package:dio_setup/network/constant.dart';
import 'package:dio_setup/network/dio_config.dart';

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();
  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await DioConfig.dio.get(endPoint);
      if (response.statusCode != 200) {
        throw Exception(ApiException(response.statusCode ?? 0,
            response.statusMessage ?? 'Failed to load posts'));
      }
      final List<PostModel> posts = [];
      for (final item in response.data) {
        posts.add(PostModel.fromJson(item));
      }
      return posts;
    } on DioException catch (e) {
      print(e);
      throw Exception('Failed to load posts');
    } on Exception catch (e) {
      print(e);
      throw Exception('Failed to load posts');
    }
  }

  Future<PostModel> fetchPost() async {
    try {
      final response = await DioConfig.dio.get(endPoint);
      if (response.statusCode != 200) {
        throw Exception('Failed to load post');
      }
      return PostModel.fromJson(response.data);
    } on Exception catch (e) {
      print(e);
      throw Exception('Failed to load post');
    }
  }

  //2- create a method to post data
  Future<PostModel> createPost( PostRequest post) async {
    try {
      final response = await DioConfig.dio.post(
        endPoint,
        data: post,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to create post');
      }
      print('staus code: ${response.statusCode}');
      print('staus message: ${response.statusMessage}');
      return PostModel.fromJson(response.data);
    } on Exception catch (e) {
      print(e);
      throw Exception('Failed to create post');
    }
  }
}

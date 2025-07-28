import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:zzal_hole/core/component/config.dart';

import '../models/zzal_list_model.dart';

class ZzalRepository {
  factory ZzalRepository() => _instance;

  ZzalRepository._internal();

  static final ZzalRepository _instance = ZzalRepository._internal();

  static Dio dio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    return dio;
  }

  Future<List<ZzalModel>> fetchZzalList() async {
    try {
      final response = await dio().get('/zzal');
      final data = response.data as List;
      log('fetchZzalList response: $data');
      return data
          .map((e) => ZzalModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      log('fetchZzalList DioException: ${e.response?.data}');
      rethrow;
    } catch (e) {
      log('fetchZzalList Unknown error: $e');
      rethrow;
    }
  }

  Future<void> postZzal({
    required String username,
    required String name,
    required String description,
    required File videoFile,
  }) async {
    try {
      final formData = FormData.fromMap({
        'username': username,
        'name': name,
        'description': description,
        'video': await MultipartFile.fromFile(
          videoFile.path,
          filename: videoFile.path.split('/').last,
        ),
      });
      final response = await dio().post(
        '/zzal',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      log('postZzal response: ${response.data}');
    } on DioException catch (e) {
      log('postZzal DioException: ${e.response?.data}');
      rethrow;
    } catch (e) {
      log('postZzal Unknown error: $e');
      rethrow;
    }
  }

  Future<List<ZzalModel>> fetchZzalRank() async {
    try {
      final response = await dio().get('/zzal/rank');
      final data = response.data as List;
      log('fetchZzalRank response: $data');
      return data
          .map((e) => ZzalModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      log('fetchZzalRank DioException: ${e.response?.data}');
      rethrow;
    } catch (e) {
      log('fetchZzalRank Unknown error: $e');
      rethrow;
    }
  }

  Future<bool> fetchLike(int id, String username) async {
    try {
      final response = await dio().get('/zzal/$id/like?username=$username');
      log('fetchLike response: ${response.data}');
      return response.data['liked'] as bool;
    } on DioException catch (e) {
      log('fetchLike DioException: ${e.response?.data}');
      rethrow;
    } catch (e) {
      log('fetchLike Unknown error: $e');
      rethrow;
    }
  }

  Future<void> likeZzal(int id, String username) async {
    try {
      final result = await dio().patch(
        '/zzal/$id/like',
        data: {'username': username},
      );
      log('likeZzal response: ${result.data}');
    } on DioException catch (e) {
      log('likeZzal DioException: ${e.response?.data}');
      rethrow;
    } catch (e) {
      log('likeZzal Unknown error: $e');
      rethrow;
    }
  }
}

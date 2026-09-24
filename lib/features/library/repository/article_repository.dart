import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/article_model.dart';

class ArticleRepository {
  final AppStorage _storage = AppStorage();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _storage.getToken();
    final Map<String, String> headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<ArticleResponse> getArticles({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? tag,
  }) async {
    try {
      final headers = await _getHeaders();
      
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }
      if (tag != null && tag.isNotEmpty) {
        queryParams['tag'] = tag;
      }

      final uri = Uri.parse(ApiEndPoint.articles).replace(queryParameters: queryParams);
      
      debugPrint("📡 [API] Requesting Articles: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return ArticleResponse.fromJson(data);
      } else {
        return ArticleResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
          data: ArticleData(items: [], meta: Meta(total: 0, page: page, limit: limit, totalPages: 0)),
        );
      }
    } catch (e) {
      debugPrint("❌ [API] Articles Exception: $e");
      return ArticleResponse(
        success: false,
        message: e.toString(),
        data: ArticleData(items: [], meta: Meta(total: 0, page: page, limit: limit, totalPages: 0)),
      );
    }
  }

  Future<ArticleTagsResponse> getArticleTags() async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.articleTags);
      
      debugPrint("📡 [API] Requesting Article Tags: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return ArticleTagsResponse.fromJson(data);
      } else {
        return ArticleTagsResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
          data: [],
        );
      }
    } catch (e) {
      debugPrint("❌ [API] Article Tags Exception: $e");
      return ArticleTagsResponse(
        success: false,
        message: e.toString(),
        data: [],
      );
    }
  }

  Future<ArticleDetailResponse> getArticleDetails(String slug) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.articleDetails(slug));
      
      debugPrint("📡 [API] Requesting Article Details: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return ArticleDetailResponse.fromJson(data);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("❌ [API] Article Details Exception: $e");
      rethrow;
    }
  }
}

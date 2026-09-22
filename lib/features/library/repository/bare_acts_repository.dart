import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/bare_acts_model.dart';

class BareActsRepository {
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

  Future<BareActCategoriesResponse> getCategories() async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.bareActCategories);
      
      debugPrint("📡 [API] Requesting Bare Act Categories: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return BareActCategoriesResponse.fromJson(data);
      } else {
        return BareActCategoriesResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
          data: [],
        );
      }
    } catch (e) {
      debugPrint("❌ [API] Categories Exception: $e");
      return BareActCategoriesResponse(
        success: false,
        message: e.toString(),
        data: [],
      );
    }
  }

  Future<BareActsListResponse> getBareActs({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? sourceType,
    String sortBy = 'created_at',
    String sortOrder = 'desc',
  }) async {
    try {
      final headers = await _getHeaders();
      
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        'sort_by': sortBy,
        'sort_order': sortOrder,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }
      if (sourceType != null && sourceType.isNotEmpty) {
        queryParams['source_type'] = sourceType;
      }

      final uri = Uri.parse(ApiEndPoint.bareActs).replace(queryParameters: queryParams);
      
      debugPrint("📡 [API] Requesting Bare Acts: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return BareActsListResponse.fromJson(data);
      } else {
        return BareActsListResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
          items: [],
        );
      }
    } catch (e) {
      debugPrint("❌ [API] Bare Acts Exception: $e");
      return BareActsListResponse(
        success: false,
        message: e.toString(),
        items: [],
      );
    }
  }

  Future<BareActDetailResponse> getBareActDetail(String id) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse('${ApiEndPoint.bareActs}/$id');
      
      debugPrint("📡 [API] Requesting Bare Act Detail: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return BareActDetailResponse.fromJson(data);
      } else {
        return BareActDetailResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("❌ [API] Detail Exception: $e");
      return BareActDetailResponse(
        success: false,
        message: e.toString(),
      );
    }
  }

  Future<String?> getDownloadUrl(String id) async {
    // Since it's a GET request that returns a file, 
    // we can return the full URL with the token if needed, 
    // or just return the endpoint.
    return ApiEndPoint.bareActDownload(id);
  }
}

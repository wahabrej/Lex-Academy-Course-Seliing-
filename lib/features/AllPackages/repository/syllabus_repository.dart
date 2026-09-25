import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/syllabus_model.dart';

class SyllabusRepository {
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

  Future<SyllabusListResponse> getSyllabuses({
    required String packageId,
    int page = 1,
    int limit = 10,
    String? search,
    String? track,
    String sortBy = 'created_at',
    String sortOrder = 'desc',
  }) async {
    try {
      final headers = await _getHeaders();
      final Map<String, String> queryParams = {
        'package_id': packageId,
        'page': page.toString(),
        'limit': limit.toString(),
        'sort_by': sortBy,
        'sort_order': sortOrder,
      };
      if (search != null && search.isNotEmpty) queryParams['search'] = search;
      if (track != null && track.isNotEmpty) queryParams['track'] = track;

      final uri = Uri.parse(ApiEndPoint.baseSyllabuses).replace(queryParameters: queryParams);
      
      debugPrint("📡 [SyllabusRepo] GET Request: $uri");
      final response = await http.get(uri, headers: headers);
      dev.log("📦 [SyllabusRepo] Response: ${response.body}");

      if (response.statusCode == 200) {
        return SyllabusListResponse.fromJson(jsonDecode(response.body));
      } else {
        return SyllabusListResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
          items: [],
        );
      }
    } catch (e) {
      debugPrint("❌ [SyllabusRepo] Exception: $e");
      return SyllabusListResponse(
        success: false,
        message: e.toString(),
        items: [],
      );
    }
  }

  Future<SyllabusDetailResponse> getSyllabusDetails(String id) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.syllabusDetails(id));
      
      debugPrint("📡 [SyllabusRepo] GET Details: $uri");
      final response = await http.get(uri, headers: headers);
      dev.log("📦 [SyllabusRepo] Detail Response: ${response.body}");

      if (response.statusCode == 200) {
        return SyllabusDetailResponse.fromJson(jsonDecode(response.body));
      } else {
        return SyllabusDetailResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("❌ [SyllabusRepo] Detail Exception: $e");
      return SyllabusDetailResponse(
        success: false,
        message: e.toString(),
      );
    }
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/legal_research_model.dart';

class LegalResearchRepository {
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

  Future<LegalResearchListResponse> getResearchPapers({
    int page = 1,
    int limit = 10,
    String? search,
    String? tag,
    String sortBy = 'created_at',
    String sortOrder = 'desc',
  }) async {
    try {
      final headers = await _getHeaders();
      
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        'sortBy': sortBy,
        'sortOrder': sortOrder,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (tag != null && tag.isNotEmpty) {
        queryParams['tag'] = tag;
      }

      final uri = Uri.parse(ApiEndPoint.legalResearch).replace(queryParameters: queryParams);
      
      debugPrint("📡 [API] Requesting Legal Research: $uri");
      final response = await http.get(uri, headers: headers);
      debugPrint("📩 [API] Research Response Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return LegalResearchListResponse.fromJson(data);
      } else {
        return LegalResearchListResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
          items: [],
        );
      }
    } catch (e) {
      debugPrint("❌ [API] Research Exception: $e");
      return LegalResearchListResponse(
        success: false,
        message: e.toString(),
        items: [],
      );
    }
  }

  Future<LegalResearchDetailResponse> getResearchDetail(String id) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse('${ApiEndPoint.legalResearch}/$id');
      
      debugPrint("📡 [API] Requesting Research Detail: $uri");
      final response = await http.get(uri, headers: headers);
      debugPrint("📩 [API] Research Detail Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return LegalResearchDetailResponse.fromJson(data);
      } else {
        return LegalResearchDetailResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("❌ [API] Research Detail Exception: $e");
      return LegalResearchDetailResponse(
        success: false,
        message: e.toString(),
      );
    }
  }
}

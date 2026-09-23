import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/case_reference_model.dart';

class CaseReferenceRepository {
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

  Future<CaseReferenceListResponse> getCaseReferences({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? court,
    int? year,
    String? tag,
    String sortBy = 'published_at',
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

      if (search != null && search.isNotEmpty) queryParams['search'] = search;
      if (category != null && category.isNotEmpty) queryParams['category'] = category;
      if (court != null && court.isNotEmpty) queryParams['court'] = court;
      if (year != null) queryParams['year'] = year.toString();
      if (tag != null && tag.isNotEmpty) queryParams['tag'] = tag;

      final uri = Uri.parse(ApiEndPoint.caseReferences).replace(queryParameters: queryParams);
      
      debugPrint("📡 [API] Case References: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return CaseReferenceListResponse.fromJson(jsonDecode(response.body));
      } else {
        return CaseReferenceListResponse(success: false, message: 'Server error: ${response.statusCode}', items: []);
      }
    } catch (e) {
      return CaseReferenceListResponse(success: false, message: e.toString(), items: []);
    }
  }

  Future<StringListResponse> getCategories() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse(ApiEndPoint.caseReferenceCategories), headers: headers);
      if (response.statusCode == 200) {
        return StringListResponse.fromJson(jsonDecode(response.body));
      }
      return StringListResponse(success: false, message: 'Error', data: []);
    } catch (e) {
      return StringListResponse(success: false, message: e.toString(), data: []);
    }
  }

  Future<StringListResponse> getCourts() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse(ApiEndPoint.caseReferenceCourts), headers: headers);
      if (response.statusCode == 200) {
        return StringListResponse.fromJson(jsonDecode(response.body));
      }
      return StringListResponse(success: false, message: 'Error', data: []);
    } catch (e) {
      return StringListResponse(success: false, message: e.toString(), data: []);
    }
  }

  Future<CaseReferenceDetailResponse> getCaseDetail(String idOrSlug) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse("${ApiEndPoint.caseReferences}/$idOrSlug"), headers: headers);
      if (response.statusCode == 200) {
        return CaseReferenceDetailResponse.fromJson(jsonDecode(response.body));
      }
      return CaseReferenceDetailResponse(success: false, message: 'Error');
    } catch (e) {
      return CaseReferenceDetailResponse(success: false, message: e.toString());
    }
  }
}

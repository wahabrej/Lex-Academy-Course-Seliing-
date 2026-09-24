import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/note_model.dart';

class NoteRepository {
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

  Future<NoteResponse> getNotes({
    int page = 1,
    int limit = 10,
    String? search,
    String? subject,
    String? tier,
    String? packageId,
  }) async {
    try {
      final headers = await _getHeaders();
      
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (search != null && search.isNotEmpty) queryParams['search'] = search;
      if (subject != null && subject.isNotEmpty) queryParams['subject'] = subject;
      if (tier != null && tier.isNotEmpty) queryParams['tier'] = tier;
      if (packageId != null && packageId.isNotEmpty) queryParams['package_id'] = packageId;

      final uri = Uri.parse(ApiEndPoint.notes).replace(queryParameters: queryParams);
      
      debugPrint("📡 [API] Requesting Notes: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return NoteResponse.fromJson(data);
      } else {
        return NoteResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
          data: NoteData(items: [], meta: NoteMeta(total: 0, page: page, limit: limit, totalPages: 0)),
        );
      }
    } catch (e) {
      debugPrint("❌ [API] Notes Exception: $e");
      return NoteResponse(
        success: false,
        message: e.toString(),
        data: NoteData(items: [], meta: NoteMeta(total: 0, page: page, limit: limit, totalPages: 0)),
      );
    }
  }

  Future<NoteDetailResponse> getNoteDetail(String id) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.noteDetails(id));
      
      debugPrint("📡 [API] Requesting Note Detail: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return NoteDetailResponse.fromJson(data);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("❌ [API] Note Detail Exception: $e");
      rethrow;
    }
  }

  String getDownloadUrl(String id) {
    return ApiEndPoint.noteDownload(id);
  }
}

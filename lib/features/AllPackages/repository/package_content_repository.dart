import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/package_content_models.dart';

class PackageContentRepository {
  final AppStorage _storage = AppStorage();

  Future<Map<String, String>> _headers() async {
    final token = await _storage.getToken();
    return {
      'accept': '*/*',
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<BookReferenceListResponse> getBookReferences({
    required String packageId,
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? track,
  }) async {
    final uri = Uri.parse(ApiEndPoint.bookReferences).replace(
      queryParameters: {
        'package_id': packageId,
        'page': '$page',
        'limit': '$limit',
        if (search?.isNotEmpty == true) 'search': search!,
        if (category?.isNotEmpty == true) 'category': category!,
        if (track?.isNotEmpty == true) 'track': track!,
      },
    );
    final response = await _get(uri, 'BookReferences');
    if (response == null) {
      return const BookReferenceListResponse(
        success: false,
        message: 'Unable to load book references.',
        items: [],
      );
    }
    return BookReferenceListResponse.fromJson(response);
  }

  Future<BookReferenceDetailResponse> getBookReferenceDetail(String id) async {
    final uri = Uri.parse('${ApiEndPoint.bookReferences}/$id');
    final response = await _get(uri, 'BookReferenceDetail');
    if (response == null) {
      return const BookReferenceDetailResponse(
        success: false,
        message: 'Unable to load book reference details.',
      );
    }
    return BookReferenceDetailResponse.fromJson(response);
  }

  Future<SuggestionListResponse> getSuggestions({
    required String packageId,
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? track,
    String? programType,
  }) async {
    final uri = Uri.parse(ApiEndPoint.suggestions).replace(
      queryParameters: {
        'package_id': packageId,
        'page': '$page',
        'limit': '$limit',
        if (search?.isNotEmpty == true) 'search': search!,
        if (category?.isNotEmpty == true) 'category': category!,
        if (track?.isNotEmpty == true) 'track': track!,
        if (programType?.isNotEmpty == true) 'program_type': programType!,
      },
    );
    final response = await _get(uri, 'Suggestions');
    if (response == null) {
      return const SuggestionListResponse(
        success: false,
        message: 'Unable to load suggestions.',
        items: [],
      );
    }
    return SuggestionListResponse.fromJson(response);
  }

  Future<SuggestionDetailResponse> getSuggestionDetail(String id) async {
    final uri = Uri.parse('${ApiEndPoint.suggestions}/$id');
    final response = await _get(uri, 'SuggestionDetail');
    if (response == null) {
      return const SuggestionDetailResponse(
        success: false,
        message: 'Unable to load suggestion details.',
      );
    }
    return SuggestionDetailResponse.fromJson(response);
  }

  Future<AnnouncementListResponse> getAnnouncements({
    required String packageId,
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    final uri = Uri.parse(ApiEndPoint.announcements(packageId)).replace(
      queryParameters: {
        'page': '$page',
        'limit': '$limit',
        'sortBy': 'created_at',
        'sortOrder': 'desc',
        if (search?.isNotEmpty == true) 'search': search!,
      },
    );
    final response = await _get(uri, 'Announcements');
    if (response == null) {
      return const AnnouncementListResponse(
        success: false,
        message: 'Unable to load announcements.',
        items: [],
      );
    }
    return AnnouncementListResponse.fromJson(response);
  }

  Future<Map<String, dynamic>?> _get(Uri uri, String label) async {
    try {
      debugPrint('📡 [$label] GET $uri');
      final response = await http.get(uri, headers: await _headers());
      debugPrint('📩 [$label] HTTP ${response.statusCode}');
      if (response.statusCode < 200 || response.statusCode >= 300) {
        debugPrint('❌ [$label] Response: ${response.body}');
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      throw const FormatException('Expected an object in the API response.');
    } catch (error, stackTrace) {
      debugPrint('❌ [$label] Request failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }
}

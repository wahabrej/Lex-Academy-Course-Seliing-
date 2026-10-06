import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/question_bank_model.dart';

class QuestionBankRepository {
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

  Future<QuestionBankListResponse> getQuestionBanks({
    int page = 1,
    int limit = 10,
    String? search,
    String access = 'all',
    String sort = 'featured',
    String? programType,
    String? examType,
    String? contentType,
    String? subject,
    int? year,
    String? packageId,
  }) async {
    try {
      final headers = await _getHeaders();
      final Map<String, String> params = {
        'page': page.toString(),
        'limit': limit.toString(),
        'access': access,
        'sort': sort,
      };

      if (search != null && search.isNotEmpty) params['search'] = search;
      if (programType != null && programType.isNotEmpty)
        params['program_type'] = programType;
      if (examType != null && examType.isNotEmpty)
        params['exam_type'] = examType;
      if (contentType != null && contentType.isNotEmpty)
        params['content_type'] = contentType;
      if (subject != null && subject.isNotEmpty) params['subject'] = subject;
      if (year != null) params['year'] = year.toString();
      if (packageId != null && packageId.isNotEmpty)
        params['package_id'] = packageId;

      final uri = Uri.parse(
        ApiEndPoint.questionBanks,
      ).replace(queryParameters: params);
      debugPrint("📡 [API] Question Banks: $uri");
      final response = await http.get(uri, headers: headers);
      debugPrint("📩 [QuestionBankRepo] Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final result = QuestionBankListResponse.fromJson(
          jsonDecode(response.body),
        );
        debugPrint(
          "✅ [QuestionBankRepo] ${result.items.length} item(s), total: ${result.meta?.total ?? 0}"
          "${result.items.isNotEmpty ? '; first: ${result.items.first.title}' : ''}",
        );
        return result;
      } else {
        debugPrint("❌ [QuestionBankRepo] Response: ${response.body}");
        return QuestionBankListResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
          items: [],
        );
      }
    } catch (e) {
      debugPrint("❌ [QuestionBankRepo] Exception: $e");
      return QuestionBankListResponse(
        success: false,
        message: e.toString(),
        items: [],
      );
    }
  }

  Future<QuestionBankStringListResponse> getPrograms() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse(ApiEndPoint.questionBankPrograms),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return QuestionBankStringListResponse.fromJson(
          jsonDecode(response.body),
        );
      }
      return QuestionBankStringListResponse(
        success: false,
        message: 'Error',
        data: [],
      );
    } catch (e) {
      return QuestionBankStringListResponse(
        success: false,
        message: e.toString(),
        data: [],
      );
    }
  }

  Future<QuestionBankStringListResponse> getExams() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse(ApiEndPoint.questionBankExams),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return QuestionBankStringListResponse.fromJson(
          jsonDecode(response.body),
        );
      }
      return QuestionBankStringListResponse(
        success: false,
        message: 'Error',
        data: [],
      );
    } catch (e) {
      return QuestionBankStringListResponse(
        success: false,
        message: e.toString(),
        data: [],
      );
    }
  }

  Future<QuestionBankStringListResponse> getSubjects() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse(ApiEndPoint.questionBankSubjects),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return QuestionBankStringListResponse.fromJson(
          jsonDecode(response.body),
        );
      }
      return QuestionBankStringListResponse(
        success: false,
        message: 'Error',
        data: [],
      );
    } catch (e) {
      return QuestionBankStringListResponse(
        success: false,
        message: e.toString(),
        data: [],
      );
    }
  }

  Future<QuestionBankDetailResponse> getQuestionBankDetail(String id) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse("${ApiEndPoint.questionBanks}/$id"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return QuestionBankDetailResponse.fromJson(jsonDecode(response.body));
      }
      return QuestionBankDetailResponse(success: false, message: 'Error');
    } catch (e) {
      return QuestionBankDetailResponse(success: false, message: e.toString());
    }
  }

  String getDownloadUrl(String id) {
    return ApiEndPoint.questionBankDownload(id);
  }
}

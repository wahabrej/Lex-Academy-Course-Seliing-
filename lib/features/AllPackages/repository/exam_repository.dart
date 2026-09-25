import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/exam_model.dart';
import '../model/result_model.dart';

class ExamRepository {
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

  // 1. Get Live Exams
  Future<ExamListResponse> getLiveExams(String packageId) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.liveExams(packageId));
      debugPrint("📡 [ExamRepo] GET Live Exams: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return ExamListResponse.fromJson(jsonDecode(response.body));
      }
      return ExamListResponse(success: false, message: 'Server error: ${response.statusCode}', items: []);
    } catch (e) {
      return ExamListResponse(success: false, message: e.toString(), items: []);
    }
  }

  // 2. Get Archived Exams
  Future<ExamListResponse> getArchivedExams(String packageId) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.archivedExams(packageId));
      debugPrint("📡 [ExamRepo] GET Archived Exams: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return ExamListResponse.fromJson(jsonDecode(response.body));
      }
      return ExamListResponse(success: false, message: 'Server error: ${response.statusCode}', items: []);
    } catch (e) {
      return ExamListResponse(success: false, message: e.toString(), items: []);
    }
  }

  // 3. Start or resume an exam bound to a package context
  Future<ExamAttemptResponse> startExam(String packageId, String examId) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.startExam(packageId, examId));
      debugPrint("📡 [ExamRepo] POST Start Exam: $uri");
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ExamAttemptResponse.fromJson(jsonDecode(response.body));
      }
      return ExamAttemptResponse(success: false, message: 'Error: ${response.statusCode}');
    } catch (e) {
      return ExamAttemptResponse(success: false, message: e.toString());
    }
  }

  // 4. Get full exam details and questions with correct answers
  Future<ExamAttemptResponse> getExamDetailsWithAnswers(String packageId, String examId) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.examDetailsWithAnswers(packageId, examId));
      debugPrint("📡 [ExamRepo] GET Exam Details With Answers: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return ExamAttemptResponse.fromJson(jsonDecode(response.body));
      }
      return ExamAttemptResponse(success: false, message: 'Error: ${response.statusCode}');
    } catch (e) {
      return ExamAttemptResponse(success: false, message: e.toString());
    }
  }

  // 5. Get paginated list of attempts for a package
  Future<AttemptListResponse> getExamAttempts({
    required String packageId,
    int page = 1,
    int limit = 10,
    String? examId,
  }) async {
    try {
      final headers = await _getHeaders();
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
      };
      if (examId != null && examId.isNotEmpty) {
        queryParams['examId'] = examId;
      }
      final uri = Uri.parse(ApiEndPoint.examAttempts(packageId)).replace(queryParameters: queryParams);
      debugPrint("📡 [ExamRepo] GET Exam Attempts: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return AttemptListResponse.fromJson(jsonDecode(response.body));
      }
      return AttemptListResponse(success: false, message: 'Error: ${response.statusCode}', items: [], total: 0);
    } catch (e) {
      return AttemptListResponse(success: false, message: e.toString(), items: [], total: 0);
    }
  }

  // 6. Get aggregated stats across all attempts in a package
  Future<Map<String, dynamic>> getExamStatsAggregate({
    required String packageId,
    int page = 1,
    int limit = 10,
    String? examId,
  }) async {
    try {
      final headers = await _getHeaders();
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
      };
      if (examId != null && examId.isNotEmpty) {
        queryParams['examId'] = examId;
      }
      final uri = Uri.parse(ApiEndPoint.examStatsAggregate(packageId)).replace(queryParameters: queryParams);
      debugPrint("📡 [ExamRepo] GET Stats Aggregate: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return {'success': false, 'message': 'Error: ${response.statusCode}'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // 7. Get full details of a specific exam attempt
  Future<ExamAttemptResponse> getAttemptDetails(String attemptId) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.attemptDetails(attemptId));
      debugPrint("📡 [ExamRepo] GET Attempt Details: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return ExamAttemptResponse.fromJson(jsonDecode(response.body));
      }
      return ExamAttemptResponse(success: false, message: 'Error: ${response.statusCode}');
    } catch (e) {
      return ExamAttemptResponse(success: false, message: e.toString());
    }
  }

  // 8. Submit MCQ Answer incrementally
  Future<Map<String, dynamic>> submitAnswer({
    required String attemptId,
    required String questionId,
    required String selectedOptionId,
  }) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.submitAnswer(attemptId));
      final body = jsonEncode({
        'question_id': questionId,
        'selected_option_id': selectedOptionId,
      });
      debugPrint("📡 [ExamRepo] POST Submit Answer: $uri");
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      return {'success': false, 'message': 'Error: ${response.statusCode}'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // 9. Finalize and submit MCQ exam
  Future<Map<String, dynamic>> submitExamAttempt(String attemptId) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.submitExamAttempt(attemptId));
      debugPrint("📡 [ExamRepo] POST Submit Exam Attempt: $uri");
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      return {'success': false, 'message': 'Error: ${response.statusCode}'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // 10. Submit written exam response
  Future<Map<String, dynamic>> submitWrittenExam({
    required String attemptId,
    required String examId,
    required String packageId,
    required String textAnswer,
    String? filePath,
  }) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.submitWrittenExam);
      final body = jsonEncode({
        'attempt_id': attemptId,
        'exam_id': examId,
        'package_id': packageId,
        'text_answer': textAnswer,
        if (filePath != null) 'file_path': filePath,
      });
      debugPrint("📡 [ExamRepo] POST Submit Written Exam: $uri");
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      return {'success': false, 'message': 'Error: ${response.statusCode}'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // 11. Request written exam resubmission access (Multipart)
  Future<Map<String, dynamic>> requestWrittenResubmission({
    required String packageId,
    required String examId,
    required String reason,
    required String filePath,
  }) async {
    try {
      final token = await _storage.getToken();
      final uri = Uri.parse(ApiEndPoint.requestWrittenResubmission);
      debugPrint("📡 [ExamRepo] Multipart Request Written Resubmission: $uri");

      var request = http.MultipartRequest('POST', uri);
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      request.headers['accept'] = '*/*';

      request.fields['package_id'] = packageId;
      request.fields['exam_id'] = examId;
      request.fields['reason'] = reason;

      if (filePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('file', filePath));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      return {'success': false, 'message': 'Error: ${response.statusCode}'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // 12. Get Merit List
  Future<MeritListResponse> getMeritList(String examId) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.meritList(examId));
      debugPrint("📡 [ExamRepo] GET Merit List: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return MeritListResponse.fromJson(jsonDecode(response.body));
      }
      return MeritListResponse(success: false, message: 'Error: ${response.statusCode}', items: []);
    } catch (e) {
      return MeritListResponse(success: false, message: e.toString(), items: []);
    }
  }

  // 13. Get Subject Breakdown
  Future<SubjectBreakdownResponse> getSubjectBreakdown(String packageId) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.subjectBreakdown(packageId));
      debugPrint("📡 [ExamRepo] GET Subject Breakdown: $uri");
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return SubjectBreakdownResponse.fromJson(jsonDecode(response.body));
      }
      return SubjectBreakdownResponse(success: false, message: 'Error: ${response.statusCode}', items: []);
    } catch (e) {
      return SubjectBreakdownResponse(success: false, message: e.toString(), items: []);
    }
  }
}

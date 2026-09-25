import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/routine_model.dart';

class RoutineRepository {
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

  // 1. Get Routine Stats
  Future<RoutineStatsResponse> getRoutineStats({
    required String packageId,
    required String programType,
  }) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.routineStats).replace(queryParameters: {
        'package_id': packageId,
        'program_type': programType,
      });

      debugPrint("📡 [RoutineRepo] GET Stats: $uri");
      final response = await http.get(uri, headers: headers);
      dev.log("📩 [RoutineRepo] Stats Response: ${response.body}");

      if (response.statusCode == 200) {
        return RoutineStatsResponse.fromJson(jsonDecode(response.body));
      }
      return RoutineStatsResponse(success: false, message: 'Server error: ${response.statusCode}');
    } catch (e) {
      debugPrint("❌ [RoutineRepo] Stats Exception: $e");
      return RoutineStatsResponse(success: false, message: e.toString());
    }
  }

  // 2. Get All Routines (with filters)
  Future<RoutineListResponse> getRoutines({
    required String packageId,
    required String programType,
    String filter = 'all',
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    try {
      final headers = await _getHeaders();
      final Map<String, String> params = {
        'package_id': packageId,
        'program_type': programType,
        'filter': filter,
        'page': page.toString(),
        'limit': limit.toString(),
      };
      if (search != null && search.isNotEmpty) params['search'] = search;

      final uri = Uri.parse(ApiEndPoint.baseRoutines).replace(queryParameters: params);
      debugPrint("📡 [RoutineRepo] GET Routines: $uri");
      final response = await http.get(uri, headers: headers);
      dev.log("📩 [RoutineRepo] Routines Response: ${response.body}");

      if (response.statusCode == 200) {
        return RoutineListResponse.fromJson(jsonDecode(response.body));
      }
      return RoutineListResponse(success: false, message: 'Server error: ${response.statusCode}', items: []);
    } catch (e) {
      debugPrint("❌ [RoutineRepo] Routines Exception: $e");
      return RoutineListResponse(success: false, message: e.toString(), items: []);
    }
  }

  // 3. Get Pinned Routines
  Future<RoutineListResponse> getPinnedRoutines({
    required String packageId,
    required String programType,
    String filter = 'all',
    String? search,
  }) async {
    try {
      final headers = await _getHeaders();
      final Map<String, String> params = {
        'package_id': packageId,
        'program_type': programType,
        'filter': filter,
      };
      if (search != null && search.isNotEmpty) params['search'] = search;

      final uri = Uri.parse(ApiEndPoint.routinePinned).replace(queryParameters: params);
      debugPrint("📡 [RoutineRepo] GET Pinned Routines: $uri");
      final response = await http.get(uri, headers: headers);
      dev.log("📩 [RoutineRepo] Pinned Response: ${response.body}");

      if (response.statusCode == 200) {
        return RoutineListResponse.fromJson(jsonDecode(response.body));
      }
      return RoutineListResponse(success: false, message: 'Server error: ${response.statusCode}', items: []);
    } catch (e) {
      debugPrint("❌ [RoutineRepo] Pinned Exception: $e");
      return RoutineListResponse(success: false, message: e.toString(), items: []);
    }
  }

  // 4. Get Single Routine Details
  Future<RoutineDetailsResponse> getRoutineDetails(String id) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.routineDetails(id));
      debugPrint("📡 [RoutineRepo] GET Routine Details: $uri");
      final response = await http.get(uri, headers: headers);
      dev.log("📩 [RoutineRepo] Details Response: ${response.body}");

      if (response.statusCode == 200) {
        return RoutineDetailsResponse.fromJson(jsonDecode(response.body));
      }
      return RoutineDetailsResponse(success: false, message: 'Server error: ${response.statusCode}');
    } catch (e) {
      debugPrint("❌ [RoutineRepo] Details Exception: $e");
      return RoutineDetailsResponse(success: false, message: e.toString());
    }
  }
}

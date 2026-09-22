import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/package_model.dart';

class PackageRepository {
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

  Future<PackageCatalogResponse> getPackageCatalog() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse(ApiEndPoint.packageCatalog), headers: headers);
      if (response.statusCode == 200) {
        return PackageCatalogResponse.fromJson(jsonDecode(response.body));
      }
      return PackageCatalogResponse(success: false, message: 'Error: ${response.statusCode}', data: PackageCatalogData(programs: {}));
    } catch (e) {
      return PackageCatalogResponse(success: false, message: e.toString(), data: PackageCatalogData(programs: {}));
    }
  }

  Future<PackageCatalogResponse> getLockedCatalog() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse(ApiEndPoint.lockedCatalog), headers: headers);
      if (response.statusCode == 200) {
        return PackageCatalogResponse.fromJson(jsonDecode(response.body));
      }
      return PackageCatalogResponse(success: false, message: 'Error: ${response.statusCode}', data: PackageCatalogData(programs: {}));
    } catch (e) {
      return PackageCatalogResponse(success: false, message: e.toString(), data: PackageCatalogData(programs: {}));
    }
  }

  Future<EnrolledPackagesResponse> getEnrolledPackages() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse(ApiEndPoint.enrolledPackages), headers: headers);
      if (response.statusCode == 200) {
        return EnrolledPackagesResponse.fromJson(jsonDecode(response.body));
      }
      return EnrolledPackagesResponse(success: false, message: 'Error: ${response.statusCode}', items: []);
    } catch (e) {
      return EnrolledPackagesResponse(success: false, message: e.toString(), items: []);
    }
  }

  Future<LiveExamsSummaryResponse> getLiveExamsSummary() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse(ApiEndPoint.liveExamsSummary), headers: headers);
      if (response.statusCode == 200) {
        return LiveExamsSummaryResponse.fromJson(jsonDecode(response.body));
      }
      return LiveExamsSummaryResponse(success: false, message: 'Error: ${response.statusCode}', data: {});
    } catch (e) {
      return LiveExamsSummaryResponse(success: false, message: e.toString(), data: {});
    }
  }

  Future<PackageDetailResponse> getPackageDetails(String id) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse(ApiEndPoint.packageDetails(id)), headers: headers);
      if (response.statusCode == 200) {
        return PackageDetailResponse.fromJson(jsonDecode(response.body));
      }
      return PackageDetailResponse(success: false, message: 'Error: ${response.statusCode}');
    } catch (e) {
      return PackageDetailResponse(success: false, message: e.toString());
    }
  }

  Future<PackageAccessCountsResponse> getPackageAccessCounts() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse(ApiEndPoint.packageAccessCounts), headers: headers);
      if (response.statusCode == 200) {
        return PackageAccessCountsResponse.fromJson(jsonDecode(response.body));
      }
      return PackageAccessCountsResponse(success: false, message: 'Error: ${response.statusCode}', data: PackageAccessCounts(active: 0, requests: 0, history: 0));
    } catch (e) {
      return PackageAccessCountsResponse(success: false, message: e.toString(), data: PackageAccessCounts(active: 0, requests: 0, history: 0));
    }
  }

  Future<PackageAccessListResponse> getPackageAccessList(String tab, {int page = 1, int limit = 10}) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.packageAccess).replace(queryParameters: {
        'tab': tab,
        'page': page.toString(),
        'limit': limit.toString(),
      });
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return PackageAccessListResponse.fromJson(jsonDecode(response.body));
      }
      return PackageAccessListResponse(success: false, message: 'Error: ${response.statusCode}', items: [], total: 0, page: page, limit: limit, totalPages: 0);
    } catch (e) {
      return PackageAccessListResponse(success: false, message: e.toString(), items: [], total: 0, page: page, limit: limit, totalPages: 0);
    }
  }
}

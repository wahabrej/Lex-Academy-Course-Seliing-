import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/legal_dictionary_model.dart';

class LegalDictionaryRepository {
  final AppStorage _storage = AppStorage();

  Future<LegalDictionaryResponse> getDictionaryItems({
    String? search,
    String? startsWith,
    String? category,
    String sortBy = 'term_en',
    String sortOrder = 'asc',
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final token = await _storage.getToken();
      
      final Map<String, String> queryParams = {
        'sortBy': sortBy,
        'sortOrder': sortOrder,
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (startsWith != null && startsWith.isNotEmpty) {
        queryParams['startsWith'] = startsWith;
      }
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }

      final uri = Uri.parse(ApiEndPoint.legalDictionary).replace(queryParameters: queryParams);
      
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json',
      };
      
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return LegalDictionaryResponse.fromJson(data);
      } else {
        return LegalDictionaryResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
          data: [],
        );
      }
    } catch (e) {
      return LegalDictionaryResponse(
        success: false,
        message: e.toString(),
        data: [],
      );
    }
  }

  Future<LegalDictionaryDetailResponse> getDictionaryDetail(String id) async {
    try {
      final token = await _storage.getToken();
      final uri = Uri.parse('${ApiEndPoint.legalDictionary}/$id');
      
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json',
      };
      
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return LegalDictionaryDetailResponse.fromJson(data);
      } else {
        return LegalDictionaryDetailResponse(
          success: false,
          message: 'Entry not found or server error (${response.statusCode})',
        );
      }
    } catch (e) {
      return LegalDictionaryDetailResponse(
        success: false,
        message: e.toString(),
      );
    }
  }
}

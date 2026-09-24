import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../core/constant/ApiEndPoint.dart';
import '../../../core/constant/TokenStorage.dart';
import '../model/flashcard_model.dart';

class FlashcardRepository {
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

  Future<FlashcardCategoriesResponse> getCategories() async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.flashcardCategories);
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return FlashcardCategoriesResponse.fromJson(jsonDecode(response.body));
      }
      return FlashcardCategoriesResponse(success: false, message: 'Error: ${response.statusCode}', data: []);
    } catch (e) {
      return FlashcardCategoriesResponse(success: false, message: e.toString(), data: []);
    }
  }

  Future<FlashcardDecksResponse> getDecks({int page = 1, int limit = 10, String? search, String? category}) async {
    try {
      final headers = await _getHeaders();
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        if (search != null && search.isNotEmpty) 'search': search,
        if (category != null && category.isNotEmpty) 'category': category,
      };
      final uri = Uri.parse(ApiEndPoint.flashcardDecks).replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return FlashcardDecksResponse.fromJson(jsonDecode(response.body));
      }
      return FlashcardDecksResponse(success: false, message: 'Error: ${response.statusCode}', items: []);
    } catch (e) {
      return FlashcardDecksResponse(success: false, message: e.toString(), items: []);
    }
  }

  Future<FlashcardDeckDetailResponse> getDeckDetail(String id) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse(ApiEndPoint.flashcardDeckDetails(id));
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return FlashcardDeckDetailResponse.fromJson(jsonDecode(response.body));
      }
      return FlashcardDeckDetailResponse(success: false, message: 'Error: ${response.statusCode}');
    } catch (e) {
      return FlashcardDeckDetailResponse(success: false, message: e.toString());
    }
  }
}

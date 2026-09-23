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
      
      debugPrint("📡 [API] Requesting Categories: $uri");
      final response = await http.get(uri, headers: headers);
      debugPrint("📩 [API] Categories Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return FlashcardCategoriesResponse.fromJson(data);
      } else {
        return FlashcardCategoriesResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
          data: [],
        );
      }
    } catch (e) {
      debugPrint("❌ [API] Categories Exception: $e");
      return FlashcardCategoriesResponse(
        success: false,
        message: e.toString(),
        data: [],
      );
    }
  }

  Future<FlashcardDecksResponse> getDecks({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
  }) async {
    try {
      final headers = await _getHeaders();
      
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }

      final uri = Uri.parse(ApiEndPoint.flashcardDecks).replace(queryParameters: queryParams);
      
      debugPrint("📡 [API] Requesting Decks: $uri");
      final response = await http.get(uri, headers: headers);
      debugPrint("📩 [API] Decks Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return FlashcardDecksResponse.fromJson(data);
      } else {
        return FlashcardDecksResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
          items: [],
        );
      }
    } catch (e) {
      debugPrint("❌ [API] Decks Exception: $e");
      return FlashcardDecksResponse(
        success: false,
        message: e.toString(),
        items: [],
      );
    }
  }

  Future<FlashcardDeckDetailResponse> getDeckDetail(String id) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse('${ApiEndPoint.flashcardDecks}/$id');
      
      debugPrint("📡 [API] Requesting Deck Detail: $uri");
      final response = await http.get(uri, headers: headers);
      debugPrint("📩 [API] Deck Detail Status: ${response.statusCode}");
      debugPrint("📩 [API] Deck Detail Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return FlashcardDeckDetailResponse.fromJson(data);
      } else {
        return FlashcardDeckDetailResponse(
          success: false,
          message: 'Server error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("❌ [API] Deck Detail Exception: $e");
      return FlashcardDeckDetailResponse(
        success: false,
        message: e.toString(),
      );
    }
  }
}

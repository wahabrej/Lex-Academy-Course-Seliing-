class LegalDictionaryResponse {
  final bool success;
  final String message;
  final List<LegalDictionaryEntry> data;
  final PaginationMeta? meta;

  LegalDictionaryResponse({
    required this.success,
    required this.message,
    required this.data,
    this.meta,
  });

  factory LegalDictionaryResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> listData = [];
    
    if (json['data'] is List) {
      listData = json['data'] as List;
    } else if (json['data'] is Map) {
      final dataMap = json['data'] as Map<String, dynamic>;
      if (dataMap['items'] is List) {
        listData = dataMap['items'] as List;
      } else if (dataMap['data'] is List) {
        listData = dataMap['data'] as List;
      }
    }

    return LegalDictionaryResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: listData.map((e) => LegalDictionaryEntry.fromJson(e as Map<String, dynamic>)).toList(),
      meta: json['meta'] != null 
          ? PaginationMeta.fromJson(json['meta']) 
          : (json['data'] is Map && (json['data'] as Map)['meta'] != null)
              ? PaginationMeta.fromJson((json['data'] as Map)['meta'])
              : null,
    );
  }
}

class LegalDictionaryEntry {
  final String id;
  final String termEn;
  final String termBn;
  final String? definitionEn;
  final String? definitionBn;
  final String? category;
  final DateTime? createdAt;

  LegalDictionaryEntry({
    required this.id,
    required this.termEn,
    required this.termBn,
    this.definitionEn,
    this.definitionBn,
    this.category,
    this.createdAt,
  });

  factory LegalDictionaryEntry.fromJson(Map<String, dynamic> json) {
    return LegalDictionaryEntry(
      id: json['id']?.toString() ?? '',
      termEn: json['term_en'] ?? json['term'] ?? '',
      termBn: json['term_bn'] ?? json['term_translated'] ?? '',
      definitionEn: json['definition_en'] ?? json['definition'] ?? '',
      definitionBn: json['definition_bn'] ?? json['definition_translated'] ?? '',
      category: json['category'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }
}

class PaginationMeta {
  final int total;
  final int page;
  final int limit;
  final int lastPage;

  PaginationMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.lastPage,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      total: json['total'] ?? json['totalItems'] ?? 0,
      page: json['page'] ?? json['currentPage'] ?? 1,
      limit: json['limit'] ?? 10,
      lastPage: json['last_page'] ?? json['totalPages'] ?? 1,
    );
  }
}

class LegalDictionaryDetailResponse {
  final bool success;
  final String message;
  final LegalDictionaryEntry? data;

  LegalDictionaryDetailResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory LegalDictionaryDetailResponse.fromJson(Map<String, dynamic> json) {
    return LegalDictionaryDetailResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? LegalDictionaryEntry.fromJson(json['data']) : null,
    );
  }
}

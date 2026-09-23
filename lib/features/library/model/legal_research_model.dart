class LegalResearchListResponse {
  final bool success;
  final String message;
  final List<LegalResearchPaper> items;
  final LegalResearchMeta? meta;

  LegalResearchListResponse({
    required this.success,
    required this.message,
    required this.items,
    this.meta,
  });

  factory LegalResearchListResponse.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];
    List<dynamic> itemsList = [];
    LegalResearchMeta? metaData;

    if (dataJson is Map<String, dynamic>) {
      itemsList = dataJson['data'] is List ? dataJson['data'] : [];
      if (dataJson['meta'] != null) {
        metaData = LegalResearchMeta.fromJson(dataJson['meta']);
      }
    }

    return LegalResearchListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      items: itemsList.map((e) => LegalResearchPaper.fromJson(e as Map<String, dynamic>)).toList(),
      meta: metaData,
    );
  }
}

class LegalResearchDetailResponse {
  final bool success;
  final String message;
  final LegalResearchPaper? data;

  LegalResearchDetailResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory LegalResearchDetailResponse.fromJson(Map<String, dynamic> json) {
    return LegalResearchDetailResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? LegalResearchPaper.fromJson(json['data']) : null,
    );
  }
}

class LegalResearchPaper {
  final String id;
  final String title;
  final String author;
  final String abstract;
  final String bodyMd;
  final String? pdfUrl;
  final List<String> tags;
  final DateTime? createdAt;

  LegalResearchPaper({
    required this.id,
    required this.title,
    required this.author,
    required this.abstract,
    required this.bodyMd,
    this.pdfUrl,
    required this.tags,
    this.createdAt,
  });

  factory LegalResearchPaper.fromJson(Map<String, dynamic> json) {
    return LegalResearchPaper(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      abstract: json['abstract'] ?? '',
      bodyMd: json['body_md'] ?? '',
      pdfUrl: json['pdf_url'],
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
    );
  }
}

class LegalResearchMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  LegalResearchMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory LegalResearchMeta.fromJson(Map<String, dynamic> json) {
    return LegalResearchMeta(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      totalPages: json['total_pages'] ?? 1,
    );
  }
}

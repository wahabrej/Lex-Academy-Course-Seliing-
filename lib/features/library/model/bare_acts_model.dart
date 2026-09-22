class BareActCategoriesResponse {
  final bool success;
  final String message;
  final List<String> data;

  BareActCategoriesResponse({required this.success, required this.message, required this.data});

  factory BareActCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return BareActCategoriesResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: List<String>.from(json['data'] ?? []),
    );
  }
}

class BareActsListResponse {
  final bool success;
  final String message;
  final List<BareAct> items;
  final BareActMeta? meta;

  BareActsListResponse({required this.success, required this.message, required this.items, this.meta});

  factory BareActsListResponse.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];
    List<dynamic> itemsList = [];
    BareActMeta? metaData;

    if (dataJson is Map<String, dynamic>) {
      itemsList = dataJson['data'] is List ? dataJson['data'] : [];
      if (dataJson['meta'] != null) {
        metaData = BareActMeta.fromJson(dataJson['meta']);
      }
    }

    return BareActsListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      items: itemsList.map((e) => BareAct.fromJson(e as Map<String, dynamic>)).toList(),
      meta: metaData,
    );
  }
}

class BareActDetailResponse {
  final bool success;
  final String message;
  final BareAct? data;

  BareActDetailResponse({required this.success, required this.message, this.data});

  factory BareActDetailResponse.fromJson(Map<String, dynamic> json) {
    return BareActDetailResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? BareAct.fromJson(json['data']) : null,
    );
  }
}

class BareAct {
  final String id;
  final String title;
  final String contentPlain;
  final String contentHtml;
  final String category;
  final String sourceType;
  final String? pdfPath;
  final bool isActive;
  final bool allowDownload;
  final DateTime? createdAt;

  BareAct({
    required this.id,
    required this.title,
    required this.contentPlain,
    required this.contentHtml,
    required this.category,
    required this.sourceType,
    this.pdfPath,
    required this.isActive,
    required this.allowDownload,
    this.createdAt,
  });

  factory BareAct.fromJson(Map<String, dynamic> json) {
    return BareAct(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      contentPlain: json['content_plain'] ?? '',
      contentHtml: json['content_html'] ?? '',
      category: json['category'] ?? '',
      sourceType: json['source_type'] ?? '',
      pdfPath: json['pdf_path'],
      isActive: json['is_active'] ?? true,
      allowDownload: json['allow_download'] ?? true,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
    );
  }
}

class BareActMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  BareActMeta({required this.total, required this.page, required this.limit, required this.totalPages});

  factory BareActMeta.fromJson(Map<String, dynamic> json) {
    return BareActMeta(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      totalPages: json['total_pages'] ?? 1,
    );
  }
}

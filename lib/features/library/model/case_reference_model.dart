class CaseReferenceListResponse {
  final bool success;
  final String message;
  final List<CaseReference> items;
  final CaseReferenceMeta? meta;

  CaseReferenceListResponse({
    required this.success,
    required this.message,
    required this.items,
    this.meta,
  });

  factory CaseReferenceListResponse.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];
    List<dynamic> itemsList = [];
    CaseReferenceMeta? metaData;

    if (dataJson is Map<String, dynamic>) {
      itemsList = dataJson['items'] is List ? dataJson['items'] : [];
      if (dataJson['meta'] != null) {
        metaData = CaseReferenceMeta.fromJson(dataJson['meta']);
      }
    }

    return CaseReferenceListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      items: itemsList.map((e) => CaseReference.fromJson(e as Map<String, dynamic>)).toList(),
      meta: metaData,
    );
  }
}

class CaseReferenceDetailResponse {
  final bool success;
  final String message;
  final CaseReference? data;

  CaseReferenceDetailResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory CaseReferenceDetailResponse.fromJson(Map<String, dynamic> json) {
    return CaseReferenceDetailResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? CaseReference.fromJson(json['data']) : null,
    );
  }
}

class CaseReference {
  final String id;
  final String title;
  final String slug;
  final String citation;
  final String court;
  final int year;
  final String summary;
  final String? coverImage;
  final String? pdfUrl;
  final String category;
  final List<String> tags;
  final String? contentHtml;
  final String? contentPlain;

  CaseReference({
    required this.id,
    required this.title,
    required this.slug,
    required this.citation,
    required this.court,
    required this.year,
    required this.summary,
    this.coverImage,
    this.pdfUrl,
    required this.category,
    required this.tags,
    this.contentHtml,
    this.contentPlain,
  });

  factory CaseReference.fromJson(Map<String, dynamic> json) {
    return CaseReference(
      id: json['id']?.toString() ?? '',
      title: json['case_title'] ?? '',
      slug: json['slug'] ?? '',
      citation: json['citation'] ?? '',
      court: json['court'] ?? '',
      year: json['year'] ?? 0,
      summary: json['summary'] ?? '',
      coverImage: json['cover_image'],
      pdfUrl: json['pdf_url'],
      category: json['category'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      contentHtml: json['content_html'],
      contentPlain: json['content_plain'],
    );
  }
}

class CaseReferenceMeta {
  final int total;
  final int totalPages;

  CaseReferenceMeta({required this.total, required this.totalPages});

  factory CaseReferenceMeta.fromJson(Map<String, dynamic> json) {
    return CaseReferenceMeta(
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 1,
    );
  }
}

class StringListResponse {
  final bool success;
  final String message;
  final List<String> data;

  StringListResponse({required this.success, required this.message, required this.data});

  factory StringListResponse.fromJson(Map<String, dynamic> json) {
    return StringListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: List<String>.from(json['data'] ?? []),
    );
  }
}

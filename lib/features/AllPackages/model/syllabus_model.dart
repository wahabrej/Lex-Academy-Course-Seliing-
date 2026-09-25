class SyllabusListResponse {
  final bool success;
  final String message;
  final List<SyllabusItem> items;
  final SyllabusMeta? meta;

  SyllabusListResponse({
    required this.success,
    required this.message,
    required this.items,
    this.meta,
  });

  factory SyllabusListResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return SyllabusListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      items: (data['items'] as List?)?.map((e) => SyllabusItem.fromJson(e)).toList() ?? [],
      meta: data['meta'] != null ? SyllabusMeta.fromJson(data['meta']) : null,
    );
  }
}

class SyllabusItem {
  final String id;
  final String title;
  final String? content;
  final String? track;
  final String packageId;
  final String? createdAt;

  SyllabusItem({
    required this.id,
    required this.title,
    this.content,
    this.track,
    required this.packageId,
    this.createdAt,
  });

  factory SyllabusItem.fromJson(Map<String, dynamic> json) {
    return SyllabusItem(
      id: json['id'] ?? json['syllabus_id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'],
      track: json['track'],
      packageId: json['package_id'] ?? '',
      createdAt: json['created_at'],
    );
  }
}

class SyllabusMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  SyllabusMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory SyllabusMeta.fromJson(Map<String, dynamic> json) {
    return SyllabusMeta(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      totalPages: json['total_pages'] ?? 0,
    );
  }
}

class SyllabusDetailResponse {
  final bool success;
  final String message;
  final SyllabusItem? data;

  SyllabusDetailResponse({required this.success, required this.message, this.data});

  factory SyllabusDetailResponse.fromJson(Map<String, dynamic> json) {
    return SyllabusDetailResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? SyllabusItem.fromJson(json['data']) : null,
    );
  }
}

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
    final rawData = json['data'];
    final data = rawData is Map<String, dynamic>
        ? rawData
        : <String, dynamic>{};
    final rawItems = data['items'];
    return SyllabusListResponse(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      items: rawItems is List
          ? rawItems
                .whereType<Map<String, dynamic>>()
                .map(SyllabusItem.fromJson)
                .toList()
          : [],
      meta: data['meta'] is Map<String, dynamic>
          ? SyllabusMeta.fromJson(data['meta'] as Map<String, dynamic>)
          : null,
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
  final String? updatedAt;
  final String? filePath;
  final String? fileMimeType;
  final String? fileUrl;
  final bool isPublished;
  final List<SyllabusPackage> packages;

  SyllabusItem({
    required this.id,
    required this.title,
    this.content,
    this.track,
    required this.packageId,
    this.createdAt,
    this.updatedAt,
    this.filePath,
    this.fileMimeType,
    this.fileUrl,
    this.isPublished = false,
    this.packages = const [],
  });

  factory SyllabusItem.fromJson(Map<String, dynamic> json) {
    return SyllabusItem(
      id: (json['id'] ?? json['syllabus_id'] ?? '').toString(),
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString(),
      track: json['track']?.toString(),
      packageId: json['package_id']?.toString() ?? '',
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      filePath: json['file_path']?.toString(),
      fileMimeType: json['file_mime_type']?.toString(),
      fileUrl: json['file_url']?.toString(),
      isPublished: json['is_published'] == true,
      packages: json['packages'] is List
          ? (json['packages'] as List)
                .whereType<Map<String, dynamic>>()
                .map(SyllabusPackage.fromJson)
                .toList()
          : const [],
    );
  }
}

class SyllabusPackage {
  final String id;
  final String title;

  const SyllabusPackage({required this.id, required this.title});

  factory SyllabusPackage.fromJson(Map<String, dynamic> json) =>
      SyllabusPackage(
        id: json['id']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
      );
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

  SyllabusDetailResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory SyllabusDetailResponse.fromJson(Map<String, dynamic> json) {
    return SyllabusDetailResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? SyllabusItem.fromJson(json['data']) : null,
    );
  }
}

class NoteResponse {
  final bool success;
  final String message;
  final NoteData? data;

  NoteResponse({required this.success, required this.message, this.data});

  factory NoteResponse.fromJson(Map<String, dynamic> json) => NoteResponse(
    success: json["success"] ?? false,
    message: json["message"] ?? "",
    data: json["data"] != null ? NoteData.fromJson(json["data"]) : null,
  );
}

class NoteData {
  final List<Note> items;
  final NoteMeta? meta;

  NoteData({required this.items, this.meta});

  factory NoteData.fromJson(Map<String, dynamic> json) => NoteData(
    items: json["items"] != null
        ? List<Note>.from(json["items"].map((x) => Note.fromJson(x)))
        : [],
    meta: json["meta"] != null ? NoteMeta.fromJson(json["meta"]) : null,
  );
}

class Note {
  final String id;
  final String title;
  final String description;
  final String subject;
  final String tier;
  final int price;
  final int discountPrice;
  final String? filePath;
  final String fileMime;
  final String? previewFilePath;
  final String? previewFileMime;
  final String? fileUrl;
  final List<NotePackage> packages;
  final int downloadCount;
  final bool isLocked;
  final DateTime? createdAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.tier,
    required this.price,
    required this.discountPrice,
    this.filePath,
    required this.fileMime,
    this.previewFilePath,
    this.previewFileMime,
    this.fileUrl,
    required this.packages,
    required this.downloadCount,
    required this.isLocked,
    this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["id"]?.toString() ?? "",
    title: json["title"]?.toString() ?? "",
    description: json["description"]?.toString() ?? "",
    subject: json["subject"]?.toString() ?? "General",
    tier: json["tier"]?.toString() ?? "free",
    price: _asInt(json["price"]),
    discountPrice: _asInt(json["discount_price"]),
    filePath: json["file_path"]?.toString(),
    fileMime: json["file_mime"]?.toString() ?? "",
    previewFilePath: json["preview_file_path"]?.toString(),
    previewFileMime: json["preview_file_mime"]?.toString(),
    fileUrl: json["file_url"]?.toString(),
    packages: json["packages"] is List
        ? (json["packages"] as List)
              .whereType<Map<String, dynamic>>()
              .map(NotePackage.fromJson)
              .toList()
        : [],
    downloadCount: _asInt(json["download_count"]),
    isLocked: json["is_locked"] is bool ? json["is_locked"] as bool : true,
    createdAt: DateTime.tryParse(json["created_at"]?.toString() ?? ''),
  );
}

class NotePackage {
  final String id;
  final String title;

  NotePackage({required this.id, required this.title});

  factory NotePackage.fromJson(Map<String, dynamic> json) => NotePackage(
    id: json["id"]?.toString() ?? "",
    title: json["title"]?.toString() ?? "",
  );
}

class NoteMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  NoteMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory NoteMeta.fromJson(Map<String, dynamic> json) => NoteMeta(
    total: json["total"] ?? 0,
    page: json["page"] ?? 1,
    limit: json["limit"] ?? 10,
    totalPages: json["total_pages"] ?? 1,
  );
}

int _asInt(dynamic value) {
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

class NoteDetailResponse {
  final bool success;
  final String message;
  final Note? data;

  NoteDetailResponse({required this.success, required this.message, this.data});

  factory NoteDetailResponse.fromJson(Map<String, dynamic> json) =>
      NoteDetailResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null ? Note.fromJson(json["data"]) : null,
      );
}

class NoteResponse {
  final bool success;
  final String message;
  final NoteData data;

  NoteResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory NoteResponse.fromJson(Map<String, dynamic> json) => NoteResponse(
        success: json["success"],
        message: json["message"],
        data: NoteData.fromJson(json["data"]),
      );
}

class NoteData {
  final List<Note> items;
  final NoteMeta meta;

  NoteData({
    required this.items,
    required this.meta,
  });

  factory NoteData.fromJson(Map<String, dynamic> json) => NoteData(
        items: List<Note>.from(json["items"].map((x) => Note.fromJson(x))),
        meta: NoteMeta.fromJson(json["meta"]),
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
  final List<NotePackage> packages;
  final int downloadCount;
  final bool isLocked;
  final DateTime createdAt;

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
    required this.packages,
    required this.downloadCount,
    required this.isLocked,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        subject: json["subject"],
        tier: json["tier"],
        price: json["price"],
        discountPrice: json["discount_price"],
        filePath: json["file_path"],
        fileMime: json["file_mime"],
        previewFilePath: json["preview_file_path"],
        previewFileMime: json["preview_file_mime"],
        packages: List<NotePackage>.from(json["packages"].map((x) => NotePackage.fromJson(x))),
        downloadCount: json["download_count"],
        isLocked: json["is_locked"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}

class NotePackage {
  final String id;
  final String title;

  NotePackage({
    required this.id,
    required this.title,
  });

  factory NotePackage.fromJson(Map<String, dynamic> json) => NotePackage(
        id: json["id"],
        title: json["title"],
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
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        totalPages: json["total_pages"],
      );
}

class NoteDetailResponse {
  final bool success;
  final String message;
  final Note data;

  NoteDetailResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory NoteDetailResponse.fromJson(Map<String, dynamic> json) => NoteDetailResponse(
        success: json["success"],
        message: json["message"],
        data: Note.fromJson(json["data"]),
      );
}

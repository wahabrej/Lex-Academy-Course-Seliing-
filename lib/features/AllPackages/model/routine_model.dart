class RoutineStatsResponse {
  final bool success;
  final String message;
  final RoutineStats? data;

  RoutineStatsResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory RoutineStatsResponse.fromJson(Map<String, dynamic> json) {
    return RoutineStatsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? RoutineStats.fromJson(json['data']) : null,
    );
  }
}

class RoutineStats {
  final int totalRoutine;
  final int done;
  final int remaining;
  final String? nextExamDate;

  RoutineStats({
    required this.totalRoutine,
    required this.done,
    required this.remaining,
    this.nextExamDate,
  });

  factory RoutineStats.fromJson(Map<String, dynamic> json) {
    return RoutineStats(
      totalRoutine: _asInt(json['total_routine']),
      done: _asInt(json['done']),
      remaining: _asInt(json['remaining']),
      nextExamDate: json['next_exam_date']?.toString(),
    );
  }
}

class RoutineListResponse {
  final bool success;
  final String message;
  final List<RoutineItem> items;
  final RoutineMeta? meta;

  RoutineListResponse({
    required this.success,
    required this.message,
    required this.items,
    this.meta,
  });

  factory RoutineListResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final dataMap = data is Map<String, dynamic> ? data : <String, dynamic>{};
    final items = data is List
        ? data
        : dataMap['items'] is List
        ? dataMap['items'] as List
        : const [];

    return RoutineListResponse(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      items: items
          .whereType<Map<String, dynamic>>()
          .map(RoutineItem.fromJson)
          .toList(),
      meta: dataMap['meta'] is Map<String, dynamic>
          ? RoutineMeta.fromJson(dataMap['meta'] as Map<String, dynamic>)
          : null,
    );
  }
}

class RoutineDetailsResponse {
  final bool success;
  final String message;
  final RoutineItem? data;

  RoutineDetailsResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory RoutineDetailsResponse.fromJson(Map<String, dynamic> json) {
    return RoutineDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? RoutineItem.fromJson(json['data']) : null,
    );
  }
}

class RoutineItem {
  final String id;
  final String title;
  final String? description;
  final String packageId;
  final String programType;
  final String? examDate;
  final String? track;
  final String? routineType;
  final String? routineNumber;
  final int? academicYear;
  final String? sessionLabel;
  final String? fileMimeType;
  final String? filePath;
  final String? fileUrl;
  final bool isPublished;
  final RoutinePackage? package;
  final bool isPinned;
  final String? createdAt;
  final String? updatedAt;

  RoutineItem({
    required this.id,
    required this.title,
    this.description,
    required this.packageId,
    required this.programType,
    this.examDate,
    this.track,
    this.routineType,
    this.routineNumber,
    this.academicYear,
    this.sessionLabel,
    this.fileMimeType,
    this.filePath,
    this.fileUrl,
    this.isPublished = false,
    this.package,
    required this.isPinned,
    this.createdAt,
    this.updatedAt,
  });

  factory RoutineItem.fromJson(Map<String, dynamic> json) {
    return RoutineItem(
      id: json['id'] ?? json['routine_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      packageId: json['package_id'] ?? '',
      programType: json['program_type'] ?? '',
      examDate: json['exam_date']?.toString(),
      track: json['track']?.toString(),
      routineType: json['routine_type']?.toString(),
      routineNumber: json['routine_number']?.toString(),
      academicYear: json['academic_year'] is num
          ? (json['academic_year'] as num).toInt()
          : int.tryParse(json['academic_year']?.toString() ?? ''),
      sessionLabel: json['session_label']?.toString(),
      fileMimeType: json['file_mime_type']?.toString(),
      filePath: json['file_path']?.toString(),
      fileUrl: json['file_url']?.toString(),
      isPublished: json['is_published'] == true,
      package: json['package'] is Map<String, dynamic>
          ? RoutinePackage.fromJson(json['package'] as Map<String, dynamic>)
          : null,
      isPinned: json['is_pinned'] == true,
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}

class RoutinePackage {
  final String id;
  final String title;

  const RoutinePackage({required this.id, required this.title});

  factory RoutinePackage.fromJson(Map<String, dynamic> json) => RoutinePackage(
    id: json['id']?.toString() ?? '',
    title: json['title']?.toString() ?? '',
  );
}

int _asInt(dynamic value) {
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

class RoutineMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  RoutineMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory RoutineMeta.fromJson(Map<String, dynamic> json) {
    return RoutineMeta(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      totalPages: json['total_pages'] ?? json['totalPages'] ?? 0,
    );
  }
}

class RoutineStatsResponse {
  final bool success;
  final String message;
  final RoutineStats? data;

  RoutineStatsResponse({required this.success, required this.message, this.data});

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
      totalRoutine: json['total_routine'] ?? 0,
      done: json['done'] ?? 0,
      remaining: json['remaining'] ?? 0,
      nextExamDate: json['next_exam_date'],
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
    final dataMap = json['data'] ?? {};
    final itemsList = (dataMap['items'] as List?)?.map((e) => RoutineItem.fromJson(e)).toList() ?? [];
    
    // Fallback if data is a direct list (like pinned endpoint)
    List<RoutineItem> directList = [];
    if (json['data'] is List) {
      directList = (json['data'] as List).map((e) => RoutineItem.fromJson(e)).toList();
    }

    return RoutineListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      items: json['data'] is List ? directList : itemsList,
      meta: dataMap['meta'] != null ? RoutineMeta.fromJson(dataMap['meta']) : null,
    );
  }
}

class RoutineDetailsResponse {
  final bool success;
  final String message;
  final RoutineItem? data;

  RoutineDetailsResponse({required this.success, required this.message, this.data});

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
      examDate: json['exam_date'],
      isPinned: json['is_pinned'] ?? false,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
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

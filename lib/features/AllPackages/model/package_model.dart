class PackageCatalogResponse {
  final bool success;
  final String message;
  final PackageCatalogData data;

  PackageCatalogResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PackageCatalogResponse.fromJson(Map<String, dynamic> json) {
    return PackageCatalogResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: PackageCatalogData.fromJson(json['data'] ?? {}),
    );
  }
}

class PackageCatalogData {
  final Map<String, PackageProgram> programs;

  PackageCatalogData({required this.programs});

  factory PackageCatalogData.fromJson(Map<String, dynamic> json) {
    Map<String, PackageProgram> programsMap = {};
    json.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        programsMap[key] = PackageProgram.fromJson(value);
      }
    });
    return PackageCatalogData(programs: programsMap);
  }

  List<PackageItem> getAllPreliminary() {
    List<PackageItem> all = [];
    programs.forEach((key, prog) {
      all.addAll(prog.preliminary);
    });
    return all;
  }
}

class PackageProgram {
  final List<PackageItem> general;
  final List<PackageItem> preliminary;
  final List<PackageItem> written;

  PackageProgram({
    required this.general,
    required this.preliminary,
    required this.written,
  });

  factory PackageProgram.fromJson(Map<String, dynamic> json) {
    return PackageProgram(
      general:
          (json['general'] as List?)
              ?.map((e) => PackageItem.fromJson(e))
              .toList() ??
          [],
      preliminary:
          (json['preliminary'] as List?)
              ?.map((e) => PackageItem.fromJson(e))
              .toList() ??
          [],
      written:
          (json['written'] as List?)
              ?.map((e) => PackageItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class PackageItem {
  final String id;
  final String program;
  final String track;
  final String kind;
  final String? duration;
  final String title;
  final String? subtitle;
  final int? batchNumber;
  final bool isActive;
  final bool isComingSoon;
  final DateTime? batchStartedAt;
  final DateTime? batchEndedAt;
  final String? price;
  final String? discountPrice;
  final String? detailsHtml;

  String get programType => program;
  String get tier => kind;

  PackageItem({
    required this.id,
    required this.program,
    required this.track,
    required this.kind,
    this.duration,
    required this.title,
    this.subtitle,
    this.batchNumber,
    required this.isActive,
    required this.isComingSoon,
    this.batchStartedAt,
    this.batchEndedAt,
    this.price,
    this.discountPrice,
    this.detailsHtml,
  });

  factory PackageItem.fromJson(Map<String, dynamic> json) {
    return PackageItem(
      id: json['id'] ?? '',
      program: json['program']?.toString() ?? '',
      track: json['track']?.toString() ?? '',
      kind: json['kind']?.toString() ?? '',
      duration: json['duration']?.toString(),
      title: json['title'] ?? '',
      subtitle: json['subtitle']?.toString(),
      batchNumber: json['batch_number'],
      isActive: json['is_active'] ?? false,
      isComingSoon: json['is_coming_soon'] ?? false,
      batchStartedAt: json['batch_started_at'] != null
          ? DateTime.tryParse(json['batch_started_at'])
          : null,
      batchEndedAt: json['batch_ended_at'] != null
          ? DateTime.tryParse(json['batch_ended_at'])
          : null,
      price: json['price']?.toString(),
      discountPrice: json['discount_price']?.toString(),
      detailsHtml: json['details_html'],
    );
  }
}

class PackageAccessListResponse {
  final bool success;
  final String message;
  final List<PackageAccessItem> items;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  PackageAccessListResponse({
    required this.success,
    required this.message,
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory PackageAccessListResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final data = rawData is Map
        ? Map<String, dynamic>.from(rawData)
        : <String, dynamic>{};
    final rawItems = data['items'];
    final itemsList = (rawItems is List ? rawItems : const [])
        .whereType<Map>()
        .map(
          (item) => PackageAccessItem.fromJson(Map<String, dynamic>.from(item)),
        )
        .toList();

    return PackageAccessListResponse(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      items: itemsList,
      total: _parseInt(data['total'], fallback: 0),
      page: _parseInt(data['page'], fallback: 1),
      limit: _parseInt(data['limit'], fallback: 10),
      totalPages: _parseInt(
        data['totalPages'] ?? data['total_pages'],
        fallback: 0,
      ),
    );
  }
}

class PackageAccessItem {
  final String accessId;
  final String id; // This is the package ID
  final String title;
  final String? subtitle;
  final String program;
  final String track;
  final String? duration;
  final DateTime? batchStartedAt;
  final DateTime? batchEndedAt;
  final String? status;
  final DateTime? createdAt;

  PackageAccessItem({
    required this.accessId,
    required this.id,
    required this.title,
    this.subtitle,
    required this.program,
    required this.track,
    this.duration,
    this.batchStartedAt,
    this.batchEndedAt,
    this.status,
    this.createdAt,
  });

  factory PackageAccessItem.fromJson(Map<String, dynamic> json) {
    return PackageAccessItem(
      accessId: json['access_id']?.toString() ?? '',
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Untitled Package',
      subtitle: json['subtitle']?.toString(),
      program: json['program']?.toString() ?? '',
      track: json['track']?.toString() ?? '',
      duration: json['duration']?.toString(),
      batchStartedAt: _parseDate(json['batch_started_at']),
      batchEndedAt: _parseDate(json['batch_ended_at']),
      status: json['status']?.toString(),
      createdAt: _parseDate(json['created_at']),
    );
  }
}

int _parseInt(Object? value, {required int fallback}) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}

DateTime? _parseDate(Object? value) {
  if (value is DateTime) return value;
  return value is String ? DateTime.tryParse(value) : null;
}

class EnrolledPackageItem {
  final String id;
  final String title;
  EnrolledPackageItem({required this.id, required this.title});
  factory EnrolledPackageItem.fromJson(Map<String, dynamic> json) =>
      EnrolledPackageItem(id: json['id'] ?? '', title: json['title'] ?? '');
}

class EnrolledPackagesResponse {
  final bool success;
  final String message;
  final List<EnrolledPackageItem> items;
  EnrolledPackagesResponse({
    required this.success,
    required this.message,
    required this.items,
  });
  factory EnrolledPackagesResponse.fromJson(Map<String, dynamic> json) =>
      EnrolledPackagesResponse(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        items:
            (json['data']?['items'] as List?)
                ?.map((e) => EnrolledPackageItem.fromJson(e))
                .toList() ??
            [],
      );
}

class PackageDetailResponse {
  final bool success;
  final String message;
  final PackageItem? data;
  PackageDetailResponse({
    required this.success,
    required this.message,
    this.data,
  });
  factory PackageDetailResponse.fromJson(Map<String, dynamic> json) =>
      PackageDetailResponse(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        data: json['data'] != null ? PackageItem.fromJson(json['data']) : null,
      );
}

class ProgramSummary {
  final int liveExamCount;
  final DateTime? nextUpcomingDate;
  ProgramSummary({required this.liveExamCount, this.nextUpcomingDate});
  factory ProgramSummary.fromJson(Map<String, dynamic> json) => ProgramSummary(
    liveExamCount: json['live_exam_count'] ?? 0,
    nextUpcomingDate: json['next_upcoming_date'] != null
        ? DateTime.tryParse(json['next_upcoming_date'])
        : null,
  );
}

class LiveExamsSummaryResponse {
  final bool success;
  final String message;
  final Map<String, ProgramSummary> data;
  LiveExamsSummaryResponse({
    required this.success,
    required this.message,
    required this.data,
  });
  factory LiveExamsSummaryResponse.fromJson(Map<String, dynamic> json) {
    Map<String, ProgramSummary> summaryMap = {};
    if (json['data'] != null) {
      (json['data'] as Map).forEach((key, value) {
        summaryMap[key] = ProgramSummary.fromJson(value);
      });
    }
    return LiveExamsSummaryResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: summaryMap,
    );
  }
}

class PackageAccessCounts {
  final int active;
  final int requests;
  final int history;
  PackageAccessCounts({
    required this.active,
    required this.requests,
    required this.history,
  });
  factory PackageAccessCounts.fromJson(Map<String, dynamic> json) =>
      PackageAccessCounts(
        active: json['active'] ?? 0,
        requests: json['requests'] ?? 0,
        history: json['history'] ?? 0,
      );
}

class PackageAccessCountsResponse {
  final bool success;
  final String message;
  final PackageAccessCounts data;
  PackageAccessCountsResponse({
    required this.success,
    required this.message,
    required this.data,
  });
  factory PackageAccessCountsResponse.fromJson(Map<String, dynamic> json) =>
      PackageAccessCountsResponse(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        data: PackageAccessCounts.fromJson(json['data'] ?? {}),
      );
}

class QuestionBankListResponse {
  final bool success;
  final String message;
  final List<QuestionBank> items;
  final QuestionBankMeta? meta;

  QuestionBankListResponse({
    required this.success,
    required this.message,
    required this.items,
    this.meta,
  });

  factory QuestionBankListResponse.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];
    List<dynamic> itemsList = [];
    QuestionBankMeta? metaData;

    if (dataJson is Map<String, dynamic>) {
      itemsList = dataJson['items'] is List ? dataJson['items'] : [];
      if (dataJson['meta'] != null) {
        metaData = QuestionBankMeta.fromJson(dataJson['meta']);
      }
    } else if (dataJson is List) {
      itemsList = dataJson;
    }

    return QuestionBankListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      items: itemsList
          .map((e) => QuestionBank.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: metaData,
    );
  }
}

class QuestionBankDetailResponse {
  final bool success;
  final String message;
  final QuestionBank? data;

  QuestionBankDetailResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory QuestionBankDetailResponse.fromJson(Map<String, dynamic> json) {
    return QuestionBankDetailResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? QuestionBank.fromJson(json['data']) : null,
    );
  }
}

class QuestionBank {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final String contentType;
  final String programType;
  final String examType;
  final String tier;
  final int year;
  final String subject;
  final bool allowDownload;
  final int downloadCount;
  final String price;
  final String discountPrice;
  final String? pdfUrl;
  final bool isUnlocked;
  final List<AssociatedPackage> associatedPackages;

  QuestionBank({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.contentType,
    required this.programType,
    required this.examType,
    required this.tier,
    required this.year,
    required this.subject,
    required this.allowDownload,
    required this.downloadCount,
    required this.price,
    required this.discountPrice,
    this.pdfUrl,
    required this.isUnlocked,
    required this.associatedPackages,
  });

  factory QuestionBank.fromJson(Map<String, dynamic> json) {
    final rawPackages = json['package_question_banks'];
    final packages = rawPackages is List ? rawPackages : const [];
    final rawTags = json['tags'];
    final tags = rawTags is List
        ? rawTags.map((tag) => tag.toString()).toList()
        : <String>[];
    final yearValue = json['year'];

    return QuestionBank(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      tags: tags,
      contentType: json['content_type']?.toString() ?? '',
      programType: json['program_type']?.toString() ?? '',
      examType: json['exam_type']?.toString() ?? '',
      tier: json['tier']?.toString() ?? '',
      year: yearValue is num
          ? yearValue.toInt()
          : int.tryParse(yearValue?.toString() ?? '') ?? 0,
      subject: json['subject']?.toString() ?? '',
      allowDownload: json['allow_download'] == true,
      downloadCount: _questionBankInt(json['download_count']),
      price: json['price']?.toString() ?? '0',
      discountPrice: json['discount_price']?.toString() ?? '0',
      pdfUrl: (json['pdf_url'] ?? json['pdf_path'])?.toString(),
      isUnlocked: json['is_unlocked'] == true,
      associatedPackages: packages
          .map((e) => AssociatedPackage.fromJson(e))
          .toList(),
    );
  }
}

class AssociatedPackage {
  final String id;
  final String title;
  final String price;
  final String discountPrice;

  AssociatedPackage({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPrice,
  });

  factory AssociatedPackage.fromJson(Map<String, dynamic> json) {
    final pkg = json['package'] is Map<String, dynamic>
        ? json['package'] as Map<String, dynamic>
        : <String, dynamic>{};
    return AssociatedPackage(
      id: pkg['id']?.toString() ?? '',
      title: pkg['title'] ?? '',
      price: pkg['price']?.toString() ?? '0',
      discountPrice: pkg['discount_price']?.toString() ?? '0',
    );
  }
}

class QuestionBankMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  QuestionBankMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory QuestionBankMeta.fromJson(Map<String, dynamic> json) {
    return QuestionBankMeta(
      total: _questionBankInt(json['total']),
      page: _questionBankInt(json['page'], 1),
      limit: _questionBankInt(json['limit'], 10),
      totalPages: _questionBankInt(json['total_pages'], 1),
    );
  }
}

int _questionBankInt(dynamic value, [int fallback = 0]) {
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}

class QuestionBankStringListResponse {
  final bool success;
  final String message;
  final List<String> data;

  QuestionBankStringListResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory QuestionBankStringListResponse.fromJson(Map<String, dynamic> json) {
    return QuestionBankStringListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: List<String>.from(json['data'] ?? []),
    );
  }
}

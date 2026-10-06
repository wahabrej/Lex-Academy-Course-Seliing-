class PackageContentMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  const PackageContentMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory PackageContentMeta.fromJson(Map<String, dynamic> json) =>
      PackageContentMeta(
        total: _contentInt(json['total']),
        page: _contentInt(json['page'], fallback: 1),
        limit: _contentInt(json['limit'], fallback: 10),
        totalPages: _contentInt(json['total_pages'] ?? json['totalPages']),
      );
}

class BookReferenceListResponse {
  final bool success;
  final String message;
  final List<BookReferenceItem> items;
  final PackageContentMeta? meta;
  final bool hasActivePurchase;

  const BookReferenceListResponse({
    required this.success,
    required this.message,
    required this.items,
    this.meta,
    this.hasActivePurchase = false,
  });

  factory BookReferenceListResponse.fromJson(Map<String, dynamic> json) {
    final data = _contentMap(json['data']);
    return BookReferenceListResponse(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      items: _contentItems(data['items'], BookReferenceItem.fromJson),
      meta: data['meta'] is Map<String, dynamic>
          ? PackageContentMeta.fromJson(data['meta'] as Map<String, dynamic>)
          : null,
      hasActivePurchase: data['has_active_purchase'] == true,
    );
  }
}

class BookReferenceItem {
  final String id;
  final String title;
  final List<String> categories;
  final List<String> tracks;
  final List<String> programTypes;
  final bool requiresPurchase;
  final bool isLocked;
  final DateTime? createdAt;
  final String? content;

  const BookReferenceItem({
    required this.id,
    required this.title,
    required this.categories,
    required this.tracks,
    required this.programTypes,
    required this.requiresPurchase,
    required this.isLocked,
    this.createdAt,
    this.content,
  });

  factory BookReferenceItem.fromJson(Map<String, dynamic> json) =>
      BookReferenceItem(
        id: json['id']?.toString() ?? '',
        title: json['title']?.toString() ?? 'Untitled reference',
        categories: _contentStrings(json['category'] ?? json['categories']),
        tracks: _contentStrings(json['track'] ?? json['tracks']),
        programTypes: _contentStrings(
          json['program_type'] ?? json['program_types'],
        ),
        requiresPurchase: json['requires_purchase'] == true,
        isLocked: json['is_locked'] == true,
        createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
        content: json['content']?.toString(),
      );
}

class BookReferenceDetailResponse {
  final bool success;
  final String message;
  final BookReferenceItem? data;

  const BookReferenceDetailResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory BookReferenceDetailResponse.fromJson(Map<String, dynamic> json) =>
      BookReferenceDetailResponse(
        success: json['success'] == true,
        message: json['message']?.toString() ?? '',
        data: json['data'] is Map<String, dynamic>
            ? BookReferenceItem.fromJson(json['data'] as Map<String, dynamic>)
            : null,
      );
}

class SuggestionListResponse {
  final bool success;
  final String message;
  final List<SuggestionItem> items;
  final PackageContentMeta? meta;
  final bool hasActivePurchase;

  const SuggestionListResponse({
    required this.success,
    required this.message,
    required this.items,
    this.meta,
    this.hasActivePurchase = false,
  });

  factory SuggestionListResponse.fromJson(Map<String, dynamic> json) {
    final data = _contentMap(json['data']);
    return SuggestionListResponse(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      items: _contentItems(data['items'], SuggestionItem.fromJson),
      meta: data['meta'] is Map<String, dynamic>
          ? PackageContentMeta.fromJson(data['meta'] as Map<String, dynamic>)
          : null,
      hasActivePurchase: data['has_active_purchase'] == true,
    );
  }
}

class SuggestionItem {
  final String id;
  final String title;
  final String? category;
  final List<String> tracks;
  final List<String> programTypes;
  final bool requiresPurchase;
  final bool isUnlocked;
  final DateTime? createdAt;
  final List<SuggestionChild> children;
  final String? content;

  const SuggestionItem({
    required this.id,
    required this.title,
    this.category,
    required this.tracks,
    required this.programTypes,
    required this.requiresPurchase,
    required this.isUnlocked,
    this.createdAt,
    this.children = const [],
    this.content,
  });

  factory SuggestionItem.fromJson(Map<String, dynamic> json) => SuggestionItem(
    id: json['id']?.toString() ?? '',
    title: json['title']?.toString() ?? 'Untitled suggestion',
    category: json['category']?.toString(),
    tracks: _contentStrings(json['tracks']),
    programTypes: _contentStrings(json['program_types']),
    requiresPurchase: json['requires_purchase'] == true,
    isUnlocked: json['is_unlock'] == true || json['is_unlocked'] == true,
    createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
    children: _contentItems(json['children'], SuggestionChild.fromJson),
    content: json['content']?.toString(),
  );
}

class SuggestionChild {
  final String id;
  final String title;
  final String? category;
  final bool requiresPurchase;

  const SuggestionChild({
    required this.id,
    required this.title,
    this.category,
    required this.requiresPurchase,
  });

  factory SuggestionChild.fromJson(Map<String, dynamic> json) =>
      SuggestionChild(
        id: json['id']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        category: json['category']?.toString(),
        requiresPurchase: json['requires_purchase'] == true,
      );
}

class SuggestionDetailResponse {
  final bool success;
  final String message;
  final SuggestionItem? data;

  const SuggestionDetailResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory SuggestionDetailResponse.fromJson(Map<String, dynamic> json) =>
      SuggestionDetailResponse(
        success: json['success'] == true,
        message: json['message']?.toString() ?? '',
        data: json['data'] is Map<String, dynamic>
            ? SuggestionItem.fromJson(json['data'] as Map<String, dynamic>)
            : null,
      );
}

class AnnouncementListResponse {
  final bool success;
  final String message;
  final List<AnnouncementItem> items;
  final PackageContentMeta? meta;

  const AnnouncementListResponse({
    required this.success,
    required this.message,
    required this.items,
    this.meta,
  });

  factory AnnouncementListResponse.fromJson(Map<String, dynamic> json) {
    final data = _contentMap(json['data']);
    return AnnouncementListResponse(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      items: _contentItems(data['items'], AnnouncementItem.fromJson),
      meta: data['meta'] is Map<String, dynamic>
          ? PackageContentMeta.fromJson(data['meta'] as Map<String, dynamic>)
          : null,
    );
  }
}

class AnnouncementItem {
  final String id;
  final String title;
  final String? body;
  final String? targetAudience;
  final String? program;
  final String? badge;
  final String? link;
  final bool isPinned;
  final DateTime? createdAt;

  const AnnouncementItem({
    required this.id,
    required this.title,
    this.body,
    this.targetAudience,
    this.program,
    this.badge,
    this.link,
    required this.isPinned,
    this.createdAt,
  });

  factory AnnouncementItem.fromJson(Map<String, dynamic> json) =>
      AnnouncementItem(
        id: json['id']?.toString() ?? '',
        title: json['title']?.toString() ?? 'Untitled announcement',
        body: json['body']?.toString(),
        targetAudience: json['target_audience']?.toString(),
        program: json['program']?.toString(),
        badge: json['priority_or_badge']?.toString(),
        link: json['link']?.toString(),
        isPinned: json['is_pinned'] == true,
        createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      );
}

Map<String, dynamic> _contentMap(dynamic value) =>
    value is Map<String, dynamic> ? value : <String, dynamic>{};

List<T> _contentItems<T>(
  dynamic value,
  T Function(Map<String, dynamic>) fromJson,
) {
  if (value is! List) return [];
  return value.whereType<Map<String, dynamic>>().map(fromJson).toList();
}

List<String> _contentStrings(dynamic value) {
  if (value is String) return value.isEmpty ? [] : [value];
  if (value is! List) return [];
  return value.map((item) => item.toString()).toList();
}

int _contentInt(dynamic value, {int fallback = 0}) {
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}

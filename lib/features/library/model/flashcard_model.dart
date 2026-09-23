class FlashcardCategoriesResponse {
  final bool success;
  final String message;
  final List<String> data;

  FlashcardCategoriesResponse({required this.success, required this.message, required this.data});

  factory FlashcardCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return FlashcardCategoriesResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: List<String>.from(json['data'] ?? []),
    );
  }
}

class FlashcardDecksResponse {
  final bool success;
  final String message;
  final List<FlashcardDeck> items;
  final FlashcardMeta? meta;

  FlashcardDecksResponse({required this.success, required this.message, required this.items, this.meta});

  factory FlashcardDecksResponse.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];
    List<dynamic> itemsList = [];
    FlashcardMeta? metaData;

    if (dataJson is Map<String, dynamic>) {
      itemsList = dataJson['items'] is List ? dataJson['items'] : [];
      if (dataJson['meta'] != null) {
        metaData = FlashcardMeta.fromJson(dataJson['meta']);
      }
    } else if (dataJson is List) {
      itemsList = dataJson;
    }

    return FlashcardDecksResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      items: itemsList.map((e) => FlashcardDeck.fromJson(e as Map<String, dynamic>)).toList(),
      meta: metaData,
    );
  }
}

class FlashcardDeckDetailResponse {
  final bool success;
  final String message;
  final FlashcardDeck? data;

  FlashcardDeckDetailResponse({required this.success, required this.message, this.data});

  factory FlashcardDeckDetailResponse.fromJson(Map<String, dynamic> json) {
    return FlashcardDeckDetailResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? FlashcardDeck.fromJson(json['data']) : null,
    );
  }
}

class FlashcardDeck {
  final String id;
  final String title;
  final String description;
  final String category;
  final int flashcardCount;
  final List<FlashcardItem> flashcards;

  FlashcardDeck({required this.id, required this.title, required this.description, required this.category, required this.flashcardCount, required this.flashcards});

  factory FlashcardDeck.fromJson(Map<String, dynamic> json) {
    final flashcardsList = json['flashcards'] as List? ?? [];
    return FlashcardDeck(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      flashcardCount: json['_count']?['flashcards'] ?? flashcardsList.length,
      flashcards: flashcardsList.map((e) => FlashcardItem.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

class FlashcardItem {
  final String id;
  final String frontText;
  final String backText;
  final String? frontImage;
  final String? backImage;

  FlashcardItem({required this.id, required this.frontText, required this.backText, this.frontImage, this.backImage});

  factory FlashcardItem.fromJson(Map<String, dynamic> json) {
    return FlashcardItem(
      id: json['id']?.toString() ?? '',
      frontText: json['front_text'] ?? '',
      backText: json['back_text'] ?? '',
      frontImage: json['front_image'],
      backImage: json['back_image'],
    );
  }
}

class FlashcardMeta {
  final int total;
  final int totalPages;

  FlashcardMeta({required this.total, required this.totalPages});

  factory FlashcardMeta.fromJson(Map<String, dynamic> json) {
    return FlashcardMeta(
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 1,
    );
  }
}

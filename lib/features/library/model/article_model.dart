import 'dart:convert';

class ArticleResponse {
  final bool success;
  final String message;
  final ArticleData? data;

  ArticleResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) => ArticleResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null ? ArticleData.fromJson(json["data"]) : null,
      );
}

class ArticleData {
  final List<Article> items;
  final Meta? meta;

  ArticleData({
    required this.items,
    this.meta,
  });

  factory ArticleData.fromJson(Map<String, dynamic> json) => ArticleData(
        items: json["items"] != null 
            ? List<Article>.from(json["items"].map((x) => Article.fromJson(x)))
            : [],
        meta: json["meta"] != null ? Meta.fromJson(json["meta"]) : null,
      );
}

class Article {
  final String id;
  final String slug;
  final String title;
  final String excerpt;
  final String? content;
  final String category;
  final DateTime publishedAt;
  final String? bannerImage;
  final String? coverImage;
  final int viewCount;
  final List<String> tags;
  final Author? author;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isPublished;
  final String? authorId;
  final String? seoMetaTitle;
  final String? seoMetaDescription;
  final List<String>? seoKeywords;
  final dynamic readMinutes;

  Article({
    required this.id,
    required this.slug,
    required this.title,
    required this.excerpt,
    this.content,
    required this.category,
    required this.publishedAt,
    this.bannerImage,
    this.coverImage,
    required this.viewCount,
    required this.tags,
    this.author,
    this.createdAt,
    this.updatedAt,
    this.isPublished,
    this.authorId,
    this.seoMetaTitle,
    this.seoMetaDescription,
    this.seoKeywords,
    this.readMinutes,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"]?.toString() ?? "",
        slug: json["slug"]?.toString() ?? "",
        title: json["title"]?.toString() ?? "",
        excerpt: json["excerpt"]?.toString() ?? "",
        content: json["content"],
        category: json["category"]?.toString() ?? "General",
        publishedAt: json["published_at"] != null 
            ? DateTime.tryParse(json["published_at"]) ?? DateTime.now()
            : DateTime.now(),
        bannerImage: json["banner_image"],
        coverImage: json["cover_image"],
        viewCount: json["view_count"] ?? 0,
        tags: json["tags"] != null ? List<String>.from(json["tags"].map((x) => x.toString())) : [],
        author: json["author"] != null ? Author.fromJson(json["author"]) : null,
        createdAt: json["created_at"] == null ? null : DateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"]),
        isPublished: json["is_published"],
        authorId: json["author_id"],
        seoMetaTitle: json["seo_meta_title"],
        seoMetaDescription: json["seo_meta_description"],
        seoKeywords: json["seo_keywords"] == null ? null : List<String>.from(json["seo_keywords"].map((x) => x.toString())),
        readMinutes: json["read_minutes"],
      );
}

class Author {
  final String id;
  final String name;
  final String? avatarUrl;
  final String? designation;
  final String? credential;
  final String? email;
  final String? linkedin;
  final String? twitter;
  final String? facebook;
  final String? instagram;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Author({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.designation,
    this.credential,
    this.email,
    this.linkedin,
    this.twitter,
    this.facebook,
    this.instagram,
    this.createdAt,
    this.updatedAt,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"]?.toString() ?? "",
        name: json["name"]?.toString() ?? "Unknown",
        avatarUrl: json["avatar_url"],
        designation: json["designation"],
        credential: json["credential"],
        email: json["email"],
        linkedin: json["linkedin"],
        twitter: json["twitter"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        createdAt: json["created_at"] == null ? null : DateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"]),
      );
}

class Meta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  Meta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"] ?? 0,
        page: json["page"] ?? 1,
        limit: json["limit"] ?? 10,
        totalPages: json["total_pages"] ?? 1,
      );
}

class ArticleDetailResponse {
  final bool success;
  final String message;
  final Article? data;

  ArticleDetailResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ArticleDetailResponse.fromJson(Map<String, dynamic> json) => ArticleDetailResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null ? Article.fromJson(json["data"]) : null,
      );
}

class ArticleTagsResponse {
  final bool success;
  final String message;
  final List<String> data;

  ArticleTagsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ArticleTagsResponse.fromJson(Map<String, dynamic> json) => ArticleTagsResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null ? List<String>.from(json["data"].map((x) => x.toString())) : [],
      );
}

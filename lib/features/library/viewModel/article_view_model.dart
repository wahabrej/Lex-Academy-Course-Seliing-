import 'package:flutter/material.dart';
import '../model/article_model.dart';
import '../repository/article_repository.dart';

class ArticleViewModel extends ChangeNotifier {
  final ArticleRepository _repository = ArticleRepository();

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  List<String> _tags = [];
  List<String> get tags => _tags;

  Article? _selectedArticle;
  Article? get selectedArticle => _selectedArticle;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isDetailLoading = false;
  bool get isDetailLoading => _isDetailLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Meta? _meta;
  Meta? get meta => _meta;

  String _search = '';
  String _selectedCategory = '';
  String _selectedTag = '';
  int _currentPage = 1;

  String get search => _search;
  String get selectedCategory => _selectedCategory;
  String get selectedTag => _selectedTag;
  int get currentPage => _currentPage;

  void updateFilters({String? search, String? category, String? tag, int? page}) {
    if (search != null) _search = search;
    if (category != null) _selectedCategory = category;
    if (tag != null) _selectedTag = tag;
    if (page != null) _currentPage = page;
    notifyListeners();
  }

  Future<void> fetchArticles({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getArticles(
      page: _currentPage,
      search: _search,
      category: _selectedCategory,
      tag: _selectedTag,
    );

    if (response.success && response.data != null) {
      if (isRefresh) {
        _articles = response.data!.items;
      } else {
        _articles.addAll(response.data!.items);
      }
      _meta = response.data!.meta;
    } else {
      _errorMessage = response.message.isNotEmpty ? response.message : "Failed to load articles";
      if (isRefresh) _articles = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTags() async {
    final response = await _repository.getArticleTags();
    if (response.success) {
      _tags = response.data;
    }
    notifyListeners();
  }

  Future<bool> fetchArticleDetail(String slug) async {
    _isDetailLoading = true;
    _selectedArticle = null;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.getArticleDetails(slug);
      if (response.success && response.data != null) {
        _selectedArticle = response.data;
        _isDetailLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message.isNotEmpty ? response.message : "Failed to load article details";
        _isDetailLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _isDetailLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearFilters() {
    _search = '';
    _selectedCategory = '';
    _selectedTag = '';
    _currentPage = 1;
    _articles = [];
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import '../model/legal_dictionary_model.dart';
import '../repository/legal_dictionary_repository.dart';

class LegalDictionaryViewModel extends ChangeNotifier {
  final LegalDictionaryRepository _repository = LegalDictionaryRepository();

  List<LegalDictionaryEntry> _items = [];
  List<LegalDictionaryEntry> get items => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PaginationMeta? _meta;
  PaginationMeta? get meta => _meta;

  // Filter & Search states
  String _search = '';
  String _startsWith = '';
  String _category = '';
  String _sortBy = 'term_en';
  String _sortOrder = 'asc';
  int _currentPage = 1;

  String get search => _search;
  String get startsWith => _startsWith;
  String get category => _category;
  String get sortBy => _sortBy;
  String get sortOrder => _sortOrder;
  int get currentPage => _currentPage;

  // Single Item Detail State
  bool _isDetailLoading = false;
  bool get isDetailLoading => _isDetailLoading;

  LegalDictionaryEntry? _selectedEntry;
  LegalDictionaryEntry? get selectedEntry => _selectedEntry;

  void updateFilters({
    String? search,
    String? startsWith,
    String? category,
    String? sortBy,
    String? sortOrder,
    int? page,
  }) {
    if (search != null) _search = search;
    if (startsWith != null) _startsWith = startsWith;
    if (category != null) _category = category;
    if (sortBy != null) _sortBy = sortBy;
    if (sortOrder != null) _sortOrder = sortOrder;
    if (page != null) _currentPage = page;
    notifyListeners();
  }

  Future<void> fetchDictionaryItems({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getDictionaryItems(
      search: _search,
      startsWith: _startsWith,
      category: _category,
      sortBy: _sortBy,
      sortOrder: _sortOrder,
      page: _currentPage,
    );

    _isLoading = false;
    if (response.success) {
      _items = response.data;
      _meta = response.meta;
    } else {
      _errorMessage = response.message;
    }
    notifyListeners();
  }

  Future<void> fetchEntryDetail(String id) async {
    _isDetailLoading = true;
    _selectedEntry = null;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getDictionaryDetail(id);
    _isDetailLoading = false;
    if (response.success) {
      _selectedEntry = response.data;
    } else {
      _errorMessage = response.message;
    }
    notifyListeners();
  }

  void clearFilters() {
    _search = '';
    _startsWith = '';
    _category = '';
    _sortBy = 'term_en';
    _sortOrder = 'asc';
    _currentPage = 1;
    notifyListeners();
  }
}

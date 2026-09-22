import 'package:flutter/material.dart';
import '../model/flashcard_model.dart';
import '../repository/flashcard_repository.dart';

class FlashcardViewModel extends ChangeNotifier {
  final FlashcardRepository _repository = FlashcardRepository();

  List<String> _categories = [];
  List<String> get categories => _categories;

  List<FlashcardDeck> _decks = [];
  List<FlashcardDeck> get decks => _decks;

  FlashcardDeck? _selectedDeck;
  FlashcardDeck? get selectedDeck => _selectedDeck;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isDetailLoading = false;
  bool get isDetailLoading => _isDetailLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  FlashcardMeta? _meta;
  FlashcardMeta? get meta => _meta;

  String _search = '';
  String _selectedCategory = '';
  int _currentPage = 1;

  String get search => _search;
  String get selectedCategory => _selectedCategory;
  int get currentPage => _currentPage;

  void updateFilters({String? search, String? category, int? page}) {
    if (search != null) _search = search;
    if (category != null) _selectedCategory = category;
    if (page != null) _currentPage = page;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _errorMessage = null;
    final response = await _repository.getCategories();
    if (response.success) {
      _categories = response.data;
    } else {
      _errorMessage = response.message;
    }
    notifyListeners();
  }

  Future<void> fetchDecks({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getDecks(
      page: _currentPage,
      search: _search,
      category: _selectedCategory,
    );

    if (response.success) {
      _decks = response.items;
      _meta = response.meta;
    } else {
      _errorMessage = response.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> fetchDeckDetail(String id) async {
    _isDetailLoading = true;
    _selectedDeck = null;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getDeckDetail(id);
    _isDetailLoading = false;
    
    if (response.success && response.data != null) {
      _selectedDeck = response.data;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message.isNotEmpty ? response.message : "Failed to load deck cards";
      notifyListeners();
      return false;
    }
  }

  void clearFilters() {
    _search = '';
    _selectedCategory = '';
    _currentPage = 1;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import '../model/bare_acts_model.dart';
import '../repository/bare_acts_repository.dart';

class BareActsViewModel extends ChangeNotifier {
  final BareActsRepository _repository = BareActsRepository();

  List<String> _categories = [];
  List<String> get categories => _categories;

  List<BareAct> _bareActs = [];
  List<BareAct> get bareActs => _bareActs;

  BareAct? _selectedBareAct;
  BareAct? get selectedBareAct => _selectedBareAct;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isDetailLoading = false;
  bool get isDetailLoading => _isDetailLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  BareActMeta? _meta;
  BareActMeta? get meta => _meta;

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

  Future<void> fetchBareActs({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getBareActs(
      page: _currentPage,
      search: _search,
      category: _selectedCategory,
    );

    if (response.success) {
      _bareActs = response.items;
      _meta = response.meta;
    } else {
      _errorMessage = response.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> fetchBareActDetail(String id) async {
    _isDetailLoading = true;
    _selectedBareAct = null;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getBareActDetail(id);
    _isDetailLoading = false;
    
    if (response.success && response.data != null) {
      _selectedBareAct = response.data;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message.isNotEmpty ? response.message : "Failed to load Bare Act details";
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

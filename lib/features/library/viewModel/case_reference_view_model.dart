import 'package:flutter/material.dart';
import '../model/case_reference_model.dart';
import '../repository/case_reference_repository.dart';

class CaseReferenceViewModel extends ChangeNotifier {
  final CaseReferenceRepository _repository = CaseReferenceRepository();

  List<CaseReference> _items = [];
  List<CaseReference> get items => _items;

  List<String> _categories = [];
  List<String> get categories => _categories;

  List<String> _courts = [];
  List<String> get courts => _courts;

  CaseReference? _selectedCase;
  CaseReference? get selectedCase => _selectedCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isDetailLoading = false;
  bool get isDetailLoading => _isDetailLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CaseReferenceMeta? _meta;
  CaseReferenceMeta? get meta => _meta;

  String _search = '';
  String _selectedCategory = '';
  String _selectedCourt = '';
  int? _selectedYear;
  int _currentPage = 1;

  String get search => _search;
  String get selectedCategory => _selectedCategory;
  String get selectedCourt => _selectedCourt;
  int? get selectedYear => _selectedYear;

  void updateFilters({String? search, String? category, String? court, int? year, int? page}) {
    if (search != null) _search = search;
    if (category != null) _selectedCategory = category;
    if (court != null) _selectedCourt = court;
    if (year != null) _selectedYear = year;
    if (page != null) _currentPage = page;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    final response = await _repository.getCategories();
    if (response.success) {
      _categories = response.data;
      notifyListeners();
    }
  }

  Future<void> fetchCourts() async {
    final response = await _repository.getCourts();
    if (response.success) {
      _courts = response.data;
      notifyListeners();
    }
  }

  Future<void> fetchCaseReferences({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getCaseReferences(
      page: _currentPage,
      search: _search,
      category: _selectedCategory,
      court: _selectedCourt,
      year: _selectedYear,
    );

    if (response.success) {
      _items = response.items;
      _meta = response.meta;
    } else {
      _errorMessage = response.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> fetchCaseDetail(String idOrSlug) async {
    _isDetailLoading = true;
    _selectedCase = null;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getCaseDetail(idOrSlug);
    _isDetailLoading = false;
    
    if (response.success && response.data != null) {
      _selectedCase = response.data;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message.isNotEmpty ? response.message : "Failed to load case details";
      notifyListeners();
      return false;
    }
  }

  void clearFilters() {
    _search = '';
    _selectedCategory = '';
    _selectedCourt = '';
    _selectedYear = null;
    _currentPage = 1;
    notifyListeners();
  }
}

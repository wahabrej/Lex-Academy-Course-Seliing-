import 'package:flutter/material.dart';
import '../model/legal_research_model.dart';
import '../repository/legal_research_repository.dart';

class LegalResearchViewModel extends ChangeNotifier {
  final LegalResearchRepository _repository = LegalResearchRepository();

  List<LegalResearchPaper> _papers = [];
  List<LegalResearchPaper> get papers => _papers;

  LegalResearchPaper? _selectedPaper;
  LegalResearchPaper? get selectedPaper => _selectedPaper;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isDetailLoading = false;
  bool get isDetailLoading => _isDetailLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  LegalResearchMeta? _meta;
  LegalResearchMeta? get meta => _meta;

  String _search = '';
  String _selectedTag = '';
  int _currentPage = 1;

  String get search => _search;
  String get selectedTag => _selectedTag;
  int get currentPage => _currentPage;

  void updateFilters({String? search, String? tag, int? page}) {
    if (search != null) _search = search;
    if (tag != null) _selectedTag = tag;
    if (page != null) _currentPage = page;
    notifyListeners();
  }

  Future<void> fetchResearchPapers({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getResearchPapers(
      page: _currentPage,
      search: _search,
      tag: _selectedTag,
    );

    if (response.success) {
      _papers = response.items;
      _meta = response.meta;
    } else {
      _errorMessage = response.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> fetchPaperDetail(String id) async {
    _isDetailLoading = true;
    _selectedPaper = null;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getResearchDetail(id);
    _isDetailLoading = false;
    
    if (response.success && response.data != null) {
      _selectedPaper = response.data;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message.isNotEmpty ? response.message : "Failed to load paper details";
      notifyListeners();
      return false;
    }
  }

  void clearFilters() {
    _search = '';
    _selectedTag = '';
    _currentPage = 1;
    notifyListeners();
  }
}

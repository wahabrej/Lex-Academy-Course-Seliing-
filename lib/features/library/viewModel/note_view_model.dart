import 'package:flutter/material.dart';
import '../model/note_model.dart';
import '../repository/note_repository.dart';

class NoteViewModel extends ChangeNotifier {
  final NoteRepository _repository = NoteRepository();

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Note? _selectedNote;
  Note? get selectedNote => _selectedNote;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isDetailLoading = false;
  bool get isDetailLoading => _isDetailLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  NoteMeta? _meta;
  NoteMeta? get meta => _meta;

  String _search = '';
  String _selectedSubject = '';
  String _selectedTier = '';
  String? _selectedPackageId;
  int _currentPage = 1;

  String get search => _search;
  String get selectedSubject => _selectedSubject;
  String get selectedTier => _selectedTier;
  String? get selectedPackageId => _selectedPackageId;
  int get currentPage => _currentPage;

  bool get hasMore => _meta == null || _currentPage < (_meta?.totalPages ?? 1);

  void updateFilters({
    String? search,
    String? subject,
    String? tier,
    String? packageId,
    int? page,
  }) {
    bool hasChanged = false;

    if (search != null && _search != search) {
      _search = search;
      hasChanged = true;
    }
    if (subject != null && _selectedSubject != subject) {
      _selectedSubject = subject;
      hasChanged = true;
    }
    if (tier != null && _selectedTier != tier) {
      _selectedTier = tier;
      hasChanged = true;
    }
    if (packageId != null && _selectedPackageId != packageId) {
      _selectedPackageId = packageId;
      hasChanged = true;
    }
    if (page != null && _currentPage != page) {
      _currentPage = page;
      hasChanged = true;
    }

    if (hasChanged) {
      debugPrint(
        "🔄 [NoteViewModel] Filters updated: Search='$_search', PackageID='$_selectedPackageId'",
      );
      notifyListeners();
    }
  }

  Future<void> fetchNotes({bool isRefresh = false}) async {
    if (_isLoading) {
      debugPrint("⏳ [NoteViewModel] Loading in progress, request skipped.");
      return;
    }

    if (!isRefresh && !hasMore) {
      debugPrint("🛑 [NoteViewModel] End of list reached.");
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    if (isRefresh) {
      _currentPage = 1;
    } else {
      _currentPage++;
    }
    notifyListeners();

    try {
      debugPrint(
        "📡 [NoteViewModel] Fetching Page: $_currentPage | PackageID: '$_selectedPackageId'",
      );

      final response = await _repository.getNotes(
        page: _currentPage,
        search: _search,
        subject: _selectedSubject,
        tier: _selectedTier,
        packageId: _selectedPackageId,
      );

      if (response.success && response.data != null) {
        final newItems = response.data!.items;
        if (isRefresh) {
          _notes = newItems;
        } else {
          _notes.addAll(newItems);
        }
        _meta = response.data!.meta;
        debugPrint(
          "✅ [NoteViewModel] Success: ${newItems.length} items found. Total: ${_meta?.total}",
        );
      } else {
        _errorMessage = response.message.isNotEmpty
            ? response.message
            : "Failed to load notes";
        if (isRefresh) _notes = [];
        if (!isRefresh && _currentPage > 1) _currentPage--;
      }
    } catch (e) {
      _errorMessage = e.toString();
      if (!isRefresh && _currentPage > 1) _currentPage--;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> fetchNoteDetail(String id) async {
    _isDetailLoading = true;
    _selectedNote = null;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.getNoteDetail(id);
      if (response.success && response.data != null) {
        _selectedNote = response.data;
        _isDetailLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message.isNotEmpty
            ? response.message
            : "Failed to load note details";
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

  String getNoteDownloadUrl(String id) {
    return _repository.getDownloadUrl(id);
  }

  void clearFilters() {
    _search = '';
    _selectedSubject = '';
    _selectedTier = '';
    _selectedPackageId = null;
    _currentPage = 1;
    _notes = [];
    _meta = null;
    notifyListeners();
  }
}

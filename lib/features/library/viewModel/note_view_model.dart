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

  void updateFilters({String? search, String? subject, String? tier, String? packageId, int? page}) {
    debugPrint("🔄 [NoteViewModel] Updating Filters: Search='$search', PackageID='$packageId'");
    if (search != null) _search = search;
    if (subject != null) _selectedSubject = subject;
    if (tier != null) _selectedTier = tier;
    if (packageId != null) _selectedPackageId = packageId;
    if (page != null) _currentPage = page;
    notifyListeners();
  }

  Future<void> fetchNotes({bool isRefresh = false}) async {
    debugPrint("🚀 [NoteViewModel] fetchNotes called (isRefresh: $isRefresh)");

    if (_isLoading) {
      debugPrint("⏳ [NoteViewModel] Loading in progress, request skipped.");
      return;
    }
    
    if (!isRefresh && !hasMore) {
      debugPrint("🛑 [NoteViewModel] End of list reached. No more data.");
      return;
    }

    if (isRefresh) {
      _currentPage = 1;
    } else {
      _currentPage++;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      debugPrint("📡 [NoteViewModel] Requesting Page: $_currentPage");
      debugPrint("🔍 [NoteViewModel] Params -> PackageID: '$_selectedPackageId', Search: '$_search'");
      
      final response = await _repository.getNotes(
        page: _currentPage,
        search: _search,
        subject: _selectedSubject,
        tier: _selectedTier,
        packageId: _selectedPackageId,
      );

      debugPrint("✅ [NoteViewModel] Response received. Success: ${response.success}");

      if (response.success && response.data != null) {
        final newItems = response.data!.items;
        debugPrint("📦 [NoteViewModel] Found ${newItems.length} notes in this page.");

        if (isRefresh) {
          _notes = newItems;
        } else {
          _notes.addAll(newItems);
        }
        _meta = response.data!.meta;
        debugPrint("📊 [NoteViewModel] Current List Size: ${_notes.length} | Server Total: ${_meta?.total}");
        
        if (_notes.isEmpty) {
          debugPrint("⚠️ [NoteViewModel] Warning: The list is EMPTY even though the request succeeded.");
        }
      } else {
        _errorMessage = response.message.isNotEmpty ? response.message : "Failed to load notes";
        debugPrint("❌ [NoteViewModel] Server error or data is null: $_errorMessage");
        if (isRefresh) _notes = [];
        if (!isRefresh && _currentPage > 1) _currentPage--;
      }
    } catch (e, stackTrace) {
      _errorMessage = "App Exception: ${e.toString()}";
      debugPrint("💥 [NoteViewModel] CRITICAL EXCEPTION: $e");
      debugPrint("📚 [NoteViewModel] StackTrace: $stackTrace");
      if (!isRefresh && _currentPage > 1) _currentPage--;
    } finally {
      _isLoading = false;
      debugPrint("🏁 [NoteViewModel] fetchNotes task finished.");
      notifyListeners();
    }
  }

  Future<bool> fetchNoteDetail(String id) async {
    debugPrint("🚀 [NoteViewModel] fetchNoteDetail for ID: $id");
    _isDetailLoading = true;
    _selectedNote = null;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.getNoteDetail(id);
      debugPrint("✅ [NoteViewModel] Detail fetch Success: ${response.success}");

      if (response.success && response.data != null) {
        _selectedNote = response.data;
        debugPrint("📄 [NoteViewModel] Note Title: ${_selectedNote?.title}");
        _isDetailLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response.message.isNotEmpty ? response.message : "Failed to load note details";
        debugPrint("❌ [NoteViewModel] Detail load failed: $_errorMessage");
        _isDetailLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "App Exception: ${e.toString()}";
      debugPrint("💥 [NoteViewModel] Detail Exception: $e");
      _isDetailLoading = false;
      notifyListeners();
      return false;
    }
  }

  String getNoteDownloadUrl(String id) {
    return _repository.getDownloadUrl(id);
  }

  void clearFilters() {
    debugPrint("🧹 [NoteViewModel] Cleaning all state and filters.");
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

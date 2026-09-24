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
  int _currentPage = 1;

  String get search => _search;
  String get selectedSubject => _selectedSubject;
  String get selectedTier => _selectedTier;
  int get currentPage => _currentPage;

  void updateFilters({String? search, String? subject, String? tier, int? page}) {
    if (search != null) _search = search;
    if (subject != null) _selectedSubject = subject;
    if (tier != null) _selectedTier = tier;
    if (page != null) _currentPage = page;
    notifyListeners();
  }

  Future<void> fetchNotes({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getNotes(
      page: _currentPage,
      search: _search,
      subject: _selectedSubject,
      tier: _selectedTier,
    );

    if (response.success) {
      if (isRefresh) {
        _notes = response.data.items;
      } else {
        _notes.addAll(response.data.items);
      }
      _meta = response.data.meta;
    } else {
      _errorMessage = response.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> fetchNoteDetail(String id) async {
    _isDetailLoading = true;
    _selectedNote = null;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.getNoteDetail(id);
      _selectedNote = response.data;
      _isDetailLoading = false;
      notifyListeners();
      return true;
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
    _currentPage = 1;
    _notes = [];
    notifyListeners();
  }
}

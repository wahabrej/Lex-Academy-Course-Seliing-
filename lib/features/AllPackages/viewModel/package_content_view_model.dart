import 'package:flutter/foundation.dart';

import '../model/package_content_models.dart';
import '../repository/package_content_repository.dart';

class PackageContentViewModel extends ChangeNotifier {
  final PackageContentRepository _repository = PackageContentRepository();

  List<BookReferenceItem> _bookReferences = [];
  List<BookReferenceItem> get bookReferences => _bookReferences;
  bool _isLoadingBookReferences = false;
  bool get isLoadingBookReferences => _isLoadingBookReferences;
  String? _bookReferencesError;
  String? get bookReferencesError => _bookReferencesError;
  bool _hasActiveBookReferencePurchase = false;

  List<SuggestionItem> _suggestions = [];
  List<SuggestionItem> get suggestions => _suggestions;
  bool _isLoadingSuggestions = false;
  bool get isLoadingSuggestions => _isLoadingSuggestions;
  String? _suggestionsError;
  String? get suggestionsError => _suggestionsError;
  bool _hasActiveSuggestionPurchase = false;
  SuggestionItem? _selectedSuggestion;
  SuggestionItem? get selectedSuggestion => _selectedSuggestion;
  bool _isLoadingSuggestionDetail = false;
  bool get isLoadingSuggestionDetail => _isLoadingSuggestionDetail;

  List<AnnouncementItem> _announcements = [];
  List<AnnouncementItem> get announcements => _announcements;
  bool _isLoadingAnnouncements = false;
  bool get isLoadingAnnouncements => _isLoadingAnnouncements;
  String? _announcementsError;
  String? get announcementsError => _announcementsError;

  bool get hasActiveBookReferencePurchase => _hasActiveBookReferencePurchase;
  bool get hasActiveSuggestionPurchase => _hasActiveSuggestionPurchase;

  Future<void> fetchBookReferences(String packageId) async {
    _isLoadingBookReferences = true;
    _bookReferencesError = null;
    _bookReferences = [];
    notifyListeners();
    final response = await _repository.getBookReferences(packageId: packageId);
    if (response.success) {
      _bookReferences = response.items;
      _hasActiveBookReferencePurchase = response.hasActivePurchase;
      debugPrint(
        '✅ [BookReferences] ${_bookReferences.length} item(s) for $packageId'
        '${_bookReferences.isNotEmpty ? "; first: ${_bookReferences.first.title}" : ""}',
      );
    } else {
      _bookReferencesError = response.message;
      debugPrint('❌ [BookReferences] ${response.message}');
    }
    _isLoadingBookReferences = false;
    notifyListeners();
  }

  Future<void> fetchSuggestions(
    String packageId, {
    String? programType,
    String? track,
  }) async {
    _isLoadingSuggestions = true;
    _suggestionsError = null;
    _suggestions = [];
    notifyListeners();
    final response = await _repository.getSuggestions(
      packageId: packageId,
      programType: programType,
      track: track,
    );
    if (response.success) {
      _suggestions = response.items;
      _hasActiveSuggestionPurchase = response.hasActivePurchase;
      debugPrint(
        '✅ [Suggestions] ${_suggestions.length} item(s) for $packageId'
        '${_suggestions.isNotEmpty ? "; first: ${_suggestions.first.title}" : ""}',
      );
    } else {
      _suggestionsError = response.message;
      debugPrint('❌ [Suggestions] ${response.message}');
    }
    _isLoadingSuggestions = false;
    notifyListeners();
  }

  Future<void> fetchSuggestionDetail(String id) async {
    _isLoadingSuggestionDetail = true;
    _suggestionsError = null;
    _selectedSuggestion = null;
    notifyListeners();
    final response = await _repository.getSuggestionDetail(id);
    if (response.success && response.data != null) {
      _selectedSuggestion = response.data;
      debugPrint('✅ [SuggestionDetail] Loaded "${response.data!.title}"');
    } else {
      _suggestionsError = response.message;
      debugPrint('❌ [SuggestionDetail] ${response.message}');
    }
    _isLoadingSuggestionDetail = false;
    notifyListeners();
  }

  Future<void> fetchAnnouncements(String packageId) async {
    _isLoadingAnnouncements = true;
    _announcementsError = null;
    _announcements = [];
    notifyListeners();
    final response = await _repository.getAnnouncements(packageId: packageId);
    if (response.success) {
      _announcements = response.items;
      debugPrint(
        '✅ [Announcements] ${_announcements.length} item(s) for $packageId'
        '${_announcements.isNotEmpty ? "; first: ${_announcements.first.title}" : ""}',
      );
    } else {
      _announcementsError = response.message;
      debugPrint('❌ [Announcements] ${response.message}');
    }
    _isLoadingAnnouncements = false;
    notifyListeners();
  }

  Future<BookReferenceItem?> fetchBookReferenceDetail(String id) async {
    final response = await _repository.getBookReferenceDetail(id);
    if (response.success && response.data != null) {
      debugPrint('✅ [BookReferenceDetail] Loaded "${response.data!.title}"');
      return response.data;
    }
    debugPrint('❌ [BookReferenceDetail] ${response.message}');
    return null;
  }
}

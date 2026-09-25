import 'package:flutter/foundation.dart';
import '../model/syllabus_model.dart';
import '../repository/syllabus_repository.dart';

class SyllabusViewModel extends ChangeNotifier {
  final SyllabusRepository _repository = SyllabusRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<SyllabusItem> _syllabuses = [];
  List<SyllabusItem> get syllabuses => _syllabuses;

  SyllabusItem? _selectedSyllabus;
  SyllabusItem? get selectedSyllabus => _selectedSyllabus;

  SyllabusMeta? _meta;
  SyllabusMeta? get meta => _meta;

  Future<void> fetchSyllabuses({
    required String packageId,
    int page = 1,
    int limit = 10,
    String? search,
    String? track,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getSyllabuses(
      packageId: packageId,
      page: page,
      limit: limit,
      search: search,
      track: track,
    );

    if (response.success) {
      _syllabuses = response.items;
      _meta = response.meta;
    } else {
      _errorMessage = response.message;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSyllabusDetails(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getSyllabusDetails(id);

    if (response.success) {
      _selectedSyllabus = response.data;
    } else {
      _errorMessage = response.message;
    }

    _isLoading = false;
    notifyListeners();
  }
}

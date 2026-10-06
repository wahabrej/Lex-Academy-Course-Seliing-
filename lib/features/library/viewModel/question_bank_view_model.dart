import 'package:flutter/material.dart';
import '../model/question_bank_model.dart';
import '../repository/question_bank_repository.dart';

class QuestionBankViewModel extends ChangeNotifier {
  final QuestionBankRepository _repository = QuestionBankRepository();

  List<QuestionBank> _items = [];
  List<QuestionBank> get items => _items;

  List<String> _programs = [];
  List<String> get programs => _programs;

  List<String> _exams = [];
  List<String> get exams => _exams;

  List<String> _subjects = [];
  List<String> get subjects => _subjects;

  QuestionBank? _selectedBank;
  QuestionBank? get selectedBank => _selectedBank;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isDetailLoading = false;
  bool get isDetailLoading => _isDetailLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  QuestionBankMeta? _meta;
  QuestionBankMeta? get meta => _meta;

  // Filters
  String _search = '';
  String _selectedProgram = '';
  String _selectedExam = '';
  String _selectedSubject = '';
  String? _selectedPackageId;
  int _currentPage = 1;

  String get search => _search;
  String get selectedProgram => _selectedProgram;
  String get selectedExam => _selectedExam;
  String get selectedSubject => _selectedSubject;
  String? get selectedPackageId => _selectedPackageId;

  void updateFilters({
    String? search,
    String? program,
    String? exam,
    String? subject,
    String? packageId,
    int? page,
  }) {
    if (search != null) _search = search;
    if (program != null) _selectedProgram = program;
    if (exam != null) _selectedExam = exam;
    if (subject != null) _selectedSubject = subject;
    if (packageId != null) _selectedPackageId = packageId;
    if (page != null) _currentPage = page;
    notifyListeners();
  }

  Future<void> fetchFilterData() async {
    final pRes = await _repository.getPrograms();
    final eRes = await _repository.getExams();
    final sRes = await _repository.getSubjects();

    if (pRes.success) _programs = pRes.data;
    if (eRes.success) _exams = eRes.data;
    if (sRes.success) _subjects = sRes.data;

    notifyListeners();
  }

  Future<void> fetchQuestionBanks({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getQuestionBanks(
      page: _currentPage,
      search: _search,
      programType: _selectedProgram,
      examType: _selectedExam,
      subject: _selectedSubject,
      packageId: _selectedPackageId,
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

  Future<bool> fetchBankDetail(String id) async {
    _isDetailLoading = true;
    _selectedBank = null;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getQuestionBankDetail(id);
    _isDetailLoading = false;

    if (response.success && response.data != null) {
      _selectedBank = response.data;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response.message.isNotEmpty
          ? response.message
          : "Failed to load details";
      notifyListeners();
      return false;
    }
  }

  void clearFilters() {
    _search = '';
    _selectedProgram = '';
    _selectedExam = '';
    _selectedSubject = '';
    _selectedPackageId = null;
    _currentPage = 1;
    notifyListeners();
  }
}

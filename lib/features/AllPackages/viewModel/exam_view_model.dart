import 'package:flutter/foundation.dart';
import '../model/exam_model.dart';
import '../model/result_model.dart';
import '../repository/exam_repository.dart';

class ExamViewModel extends ChangeNotifier {
  final ExamRepository _repository = ExamRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ExamItem> _liveExams = [];
  List<ExamItem> get liveExams => _liveExams;

  List<ExamItem> _archivedExams = [];
  List<ExamItem> get archivedExams => _archivedExams;

  List<ExamAttempt> _attempts = [];
  List<ExamAttempt> get attempts => _attempts;

  MeritListResponse? _meritList;
  MeritListResponse? get meritList => _meritList;

  SubjectBreakdownResponse? _subjectBreakdown;
  SubjectBreakdownResponse? get subjectBreakdown => _subjectBreakdown;

  ExamAttempt? _currentAttempt;
  ExamAttempt? get currentAttempt => _currentAttempt;

  Future<void> fetchLiveExams(String packageId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getLiveExams(packageId);
    if (response.success) {
      _liveExams = response.items;
    } else {
      _errorMessage = response.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchArchivedExams(String packageId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getArchivedExams(packageId);
    if (response.success) {
      _archivedExams = response.items;
    } else {
      _errorMessage = response.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchExamAttempts({required String packageId, String? examId}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getExamAttempts(packageId: packageId, examId: examId);
    if (response.success) {
      _attempts = response.items;
    } else {
      _errorMessage = response.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMeritList(String examId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getMeritList(examId);
    if (response.success) {
      _meritList = response;
    } else {
      _errorMessage = response.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSubjectBreakdown(String packageId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getSubjectBreakdown(packageId);
    if (response.success) {
      _subjectBreakdown = response;
    } else {
      _errorMessage = response.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> startOrResumeExam(String packageId, String examId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.startExam(packageId, examId);
    if (response.success) {
      _currentAttempt = response.data;
    } else {
      _errorMessage = response.message;
    }
    _isLoading = false;
    notifyListeners();
  }
}

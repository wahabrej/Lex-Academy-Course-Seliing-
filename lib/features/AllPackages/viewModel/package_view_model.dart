import 'package:flutter/material.dart';
import '../model/package_model.dart';
import '../model/performance_model.dart';
import '../repository/package_repository.dart';

class PackageViewModel extends ChangeNotifier {
  final PackageRepository _repository = PackageRepository();

  PackageCatalogData? _catalog;
  PackageCatalogData? get catalog => _catalog;

  PackageCatalogData? _lockedCatalog;
  PackageCatalogData? get lockedCatalog => _lockedCatalog;

  List<EnrolledPackageItem> _enrolledPackages = [];
  List<EnrolledPackageItem> get enrolledPackages => _enrolledPackages;

  Map<String, ProgramSummary> _liveExamsSummary = {};
  Map<String, ProgramSummary> get liveExamsSummary => _liveExamsSummary;

  PackageAccessCounts? _accessCounts;
  PackageAccessCounts? get accessCounts => _accessCounts;

  List<PackageAccessItem> _accessList = [];
  List<PackageAccessItem> get accessList => _accessList;

  UserPerformanceAnalytics? _performanceData;
  UserPerformanceAnalytics? get performanceData => _performanceData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // 1. Fetch Catalog (Regular)
  Future<void> fetchPackageCatalog() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getPackageCatalog();
    if (response.success) {
      _catalog = response.data;
    } else {
      _errorMessage = response.message;
    }

    _isLoading = false;
    notifyListeners();
  }

  // 2. Fetch Enrolled
  Future<void> fetchEnrolledPackages() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getEnrolledPackages();
    if (response.success) {
      _enrolledPackages = response.items;
    } else {
      _errorMessage = response.message;
    }

    _isLoading = false;
    notifyListeners();
  }

  // 3. Fetch Live Exams Summary
  Future<void> fetchLiveExamsSummary() async {
    final response = await _repository.getLiveExamsSummary();
    if (response.success) {
      _liveExamsSummary = response.data;
    }
    notifyListeners();
  }

  // 4. Fetch Locked Catalog (This is now used for the Catalog tab)
  Future<void> fetchLockedCatalog() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getLockedCatalog();
    if (response.success) {
      _lockedCatalog = response.data;
    } else {
      _errorMessage = response.message;
    }

    _isLoading = false;
    notifyListeners();
  }

  // 5. Fetch Access Counts
  Future<void> fetchAccessCounts() async {
    final response = await _repository.getPackageAccessCounts();
    if (response.success) {
      _accessCounts = response.data;
    }
    notifyListeners();
  }

  // 6. Fetch Access List (Active, Requests, History)
  Future<void> fetchAccessList(String tab) async {
    _isLoading = true;
    _errorMessage = null;
    _accessList = []; // Clear list before fetching new data
    notifyListeners();

    debugPrint("🚀 [PackageViewModel] fetchAccessList called for tab: $tab");

    try {
      final response = await _repository.getPackageAccessList(tab);

      if (response.success) {
        _accessList = response.items;
        debugPrint(
          "✅ [PackageViewModel] Received ${_accessList.length} access items.",
        );

        if (_accessList.isNotEmpty) {
          debugPrint(
            "🔍 [PackageViewModel] First item title: ${_accessList[0].title}",
          );
        } else {
          debugPrint(
            "⚠️ [PackageViewModel] Access list is empty for tab: $tab",
          );
        }
      } else {
        _errorMessage = response.message;
        debugPrint("❌ [PackageViewModel] API Error: $_errorMessage");
      }
    } catch (e, stacktrace) {
      _errorMessage = e.toString();
      debugPrint("💥 [PackageViewModel] Exception: $e");
      debugPrint("📚 [PackageViewModel] Stacktrace: $stacktrace");
    }

    _isLoading = false;
    notifyListeners();
  }

  // 7. Fetch Details
  Future<PackageItem?> fetchPackageDetails(String id) async {
    final response = await _repository.getPackageDetails(id);
    if (response.success) {
      return response.data;
    }
    return null;
  }

  // 8. Fetch Performance
  Future<void> fetchPackagePerformance(String packageId) async {
    _isLoading = true;
    _errorMessage = null;
    _performanceData = null;
    notifyListeners();

    final data = await _repository.getPackagePerformance(packageId);
    final responseData = data['data'];
    if (data['success'] == true && responseData is Map<String, dynamic>) {
      _performanceData = UserPerformanceAnalytics.fromJson(responseData);
      debugPrint(
        '✅ [Performance] ${_performanceData!.overview.questionsAnswered} answered; '
        '${_performanceData!.subjectWiseAccuracy.length} subject(s); '
        '${_performanceData!.overview.topPerformanceGraph.length} score point(s)',
      );
    } else {
      _errorMessage =
          data['message']?.toString() ?? 'Failed to load performance data';
      debugPrint('❌ [Performance] $_errorMessage');
    }

    _isLoading = false;
    notifyListeners();
  }
}

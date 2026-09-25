import 'package:flutter/foundation.dart';
import '../model/routine_model.dart';
import '../repository/routine_repository.dart';

class RoutineViewModel extends ChangeNotifier {
  final RoutineRepository _repository = RoutineRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  RoutineStats? _stats;
  RoutineStats? get stats => _stats;

  List<RoutineItem> _routines = [];
  List<RoutineItem> get routines => _routines;

  List<RoutineItem> _pinnedRoutines = [];
  List<RoutineItem> get pinnedRoutines => _pinnedRoutines;

  RoutineItem? _selectedRoutine;
  RoutineItem? get selectedRoutine => _selectedRoutine;

  RoutineMeta? _meta;
  RoutineMeta? get meta => _meta;

  // 1. Fetch Routine Stats
  Future<void> fetchRoutineStats({
    required String packageId,
    required String programType,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getRoutineStats(
      packageId: packageId,
      programType: programType,
    );

    if (response.success) {
      _stats = response.data;
    } else {
      _errorMessage = response.message;
    }

    _isLoading = false;
    notifyListeners();
  }

  // 2. Fetch All Routines
  Future<void> fetchRoutines({
    required String packageId,
    required String programType,
    String filter = 'all',
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getRoutines(
      packageId: packageId,
      programType: programType,
      filter: filter,
      page: page,
      limit: limit,
      search: search,
    );

    if (response.success) {
      _routines = response.items;
      _meta = response.meta;
    } else {
      _errorMessage = response.message;
    }

    _isLoading = false;
    notifyListeners();
  }

  // 3. Fetch Pinned Routines
  Future<void> fetchPinnedRoutines({
    required String packageId,
    required String programType,
    String filter = 'all',
    String? search,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getPinnedRoutines(
      packageId: packageId,
      programType: programType,
      filter: filter,
      search: search,
    );

    if (response.success) {
      _pinnedRoutines = response.items;
    } else {
      _errorMessage = response.message;
    }

    _isLoading = false;
    notifyListeners();
  }

  // 4. Fetch Single Routine Details
  Future<void> fetchRoutineDetails(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _repository.getRoutineDetails(id);

    if (response.success) {
      _selectedRoutine = response.data;
    } else {
      _errorMessage = response.message;
    }

    _isLoading = false;
    notifyListeners();
  }
}

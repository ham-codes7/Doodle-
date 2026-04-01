import '../services/api_service.dart';

class DashboardProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  // Mama's State
  final Set<String> _selectedFeelings = {};
  String _sosStatus = 'idle';
  int _waterCount = 4;
  int _sleepHours = 4;
  int _currentTimelineWeek = 2;

  // Partner's State (Fetched from API)
  String _mamaFeelingsSummaryText = "She is resting currently.";
  String _contextText = "No symptoms logged yet today. Check in gently.";
  List<dynamic> _partnerActionPlan = [];

  // Public Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  Set<String> get selectedFeelings => _selectedFeelings;
  String get sosStatus => _sosStatus;
  int get waterCount => _waterCount;
  int get sleepHours => _sleepHours;
  int get currentTimelineWeek => _currentTimelineWeek;
  String get mamaFeelingsSummaryText => _mamaFeelingsSummaryText;
  String get contextText => _contextText;
  List<dynamic> get partnerActionPlan => _partnerActionPlan;

  // --- Methods ---

  void toggleFeeling(String feelingName) {
    if (_selectedFeelings.contains(feelingName)) {
      _selectedFeelings.remove(feelingName);
    } else {
      _selectedFeelings.add(feelingName);
    }
    notifyListeners();
  }

  Future<bool> submitLog() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final logData = {
        'feelings': _selectedFeelings.toList(),
        'emotionalPulse': 5, // Default or gathered from UI
        'hydrationLiters': _waterCount.toDouble(),
        'sleepQuality': _sleepHours,
        'notes': "Logged via app",
      };

      final result = await ApiService.submitLog(logData);
      if (result['success'] == true) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = result['message'];
      }
    } catch (e) {
      _error = "Failed to submit log. Server unreachable.";
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> fetchPartnerDashboard() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await ApiService.getPartnerDashboard();
      if (result['success'] == true) {
        _mamaFeelingsSummaryText = result['summary'] ?? "She is resting currently.";
        _contextText = result['context'] ?? "Check in gently.";
        _partnerActionPlan = result['activeTasks'] ?? [];
      }
    } catch (e) {
      _error = "Failed to fetch dashboard updates.";
    }

    _isLoading = false;
    notifyListeners();
  }

  void sendSos() {
    _sosStatus = 'sent';
    notifyListeners();
  }

  void toggleMamaTask(int index, bool? isComplete) {
    _completedMamaTasks[index] = isComplete ?? false;
    notifyListeners();
  }

  void incrementWater() {
    _waterCount++;
    notifyListeners();
  }

  void decrementWater() {
    if (_waterCount > 0) {
      _waterCount--;
      notifyListeners();
    }
  }

  void incrementSleep() {
    _sleepHours++;
    notifyListeners();
  }

  void decrementSleep() {
    if (_sleepHours > 0) {
      _sleepHours--;
      notifyListeners();
    }
  }

  void togglePartnerTask(int index, bool? isComplete) {
    _completedPartnerTasks[index] = isComplete ?? false;
    notifyListeners();
  }

  void reset() {
    _selectedFeelings.clear();
    _sosStatus = 'idle';
    _completedMamaTasks.clear();
    _waterCount = 4;
    _sleepHours = 4;
    _currentTimelineWeek = 2;
    _mamaFeelingsSummaryText = "She is resting currently.";
    _contextText = "No symptoms logged yet today. Check in gently.";
    _partnerActionPlan = [];
    _householdTasks.clear();
    _completedPartnerTasks.clear();
    notifyListeners();
  }
}

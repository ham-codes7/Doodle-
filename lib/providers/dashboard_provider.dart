import 'package:flutter/foundation.dart';

class DashboardProvider extends ChangeNotifier {
  // Mama's State
  final Set<String> _selectedFeelings = {};
  String _sosStatus = 'idle'; // idle, sent
  final Map<int, bool> _completedMamaTasks = {};
  double _hydrationLiters = 1.2;
  String _restTime = '4h 20m';
  int _currentTimelineWeek = 2;

  // Partner's State (Derived)
  String _mamaFeelingsSummaryText = "Exhausted & Weepy.";
  String _contextText =
      "It is Day 14. Her hormones are dropping rapidly, and sleep deprivation is peaking. She needs physical rest and emotional validation, not solutions.";

  final List<Map<String, String>> _partnerActionPlan = [];

  final List<Map<String, String>> _householdTasks = [];
  
  final Map<int, bool> _completedPartnerTasks = {};

  // Public Getters
  Set<String> get selectedFeelings => _selectedFeelings;
  String get sosStatus => _sosStatus;
  Map<int, bool> get completedMamaTasks => _completedMamaTasks;
  double get hydrationLiters => _hydrationLiters;
  String get restTime => _restTime;
  int get currentTimelineWeek => _currentTimelineWeek;

  String get mamaFeelingsSummaryText => _mamaFeelingsSummaryText;
  String get contextText => _contextText;
  List<Map<String, String>> get partnerActionPlan => _partnerActionPlan;
  List<Map<String, String>> get householdTasks => _householdTasks;
  Map<int, bool> get completedPartnerTasks => _completedPartnerTasks;

  // Setter Methods
  void toggleFeeling(String feelingName) {
    if (_selectedFeelings.contains(feelingName)) {
      _selectedFeelings.remove(feelingName);
    } else {
      _selectedFeelings.add(feelingName);
    }
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

  void updateHydration(double liters) {
    _hydrationLiters = liters;
    notifyListeners();
  }

  void togglePartnerTask(int index, bool? isComplete) {
    _completedPartnerTasks[index] = isComplete ?? false;
    notifyListeners();
  }
}

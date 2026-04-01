import 'package:flutter/foundation.dart';

class DashboardProvider extends ChangeNotifier {
  // Mama's State
  final Set<String> _selectedFeelings = {};
  String _sosStatus = 'idle'; // idle, sent
  final Map<int, bool> _completedMamaTasks = {};
  int _waterCount = 4; // Initial dummy data
  int _sleepHours = 4; // Initial dummy data
  int _currentTimelineWeek = 2;

  // Partner's State (Derived)
  String _mamaFeelingsSummaryText = "She is resting currently.";
  String _contextText = "No symptoms logged yet today. Check in gently.";

  List<Map<String, String>> _partnerActionPlan = [];

  final List<Map<String, String>> _householdTasks = [];
  
  final Map<int, bool> _completedPartnerTasks = {};

  // Public Getters
  Set<String> get selectedFeelings => _selectedFeelings;
  String get sosStatus => _sosStatus;
  Map<int, bool> get completedMamaTasks => _completedMamaTasks;
  int get waterCount => _waterCount;
  int get sleepHours => _sleepHours;
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
    
    _updatePartnerDashboard(); // Trigger dynamic logic
    notifyListeners();
  }

  void _updatePartnerDashboard() {
    if (_selectedFeelings.isEmpty) {
      _mamaFeelingsSummaryText = "She is resting currently.";
      _contextText = "No symptoms logged yet today. Check in gently.";
      _partnerActionPlan = [];
      return;
    }

    List<String> feelingsList = _selectedFeelings.toList();
    _mamaFeelingsSummaryText = "She is feeling ${feelingsList.join(' & ')}.";
    _partnerActionPlan = [];

    if (_selectedFeelings.contains('Exhausted')) {
      _contextText = "Her body is recovering from extreme physical trauma. She needs physical rest.";
      _partnerActionPlan.addAll([
        {'title': 'Take over all non-feeding baby duties tonight', 'priority': 'CRITICAL'},
        {'title': 'Let her sleep uninterrupted for 4 hours', 'priority': 'HIGH'}
      ]);
    } else if (_selectedFeelings.contains('Weepy')) {
      _contextText = "Hormone crash is active. Do not try to fix her sadness, just listen and validate.";
      _partnerActionPlan.addAll([
        {'title': 'Bring her water and just hold her', 'priority': 'HIGH'},
        {'title': 'Tell her she is doing an amazing job', 'priority': 'EMOTIONAL SUPPORT'}
      ]);
    } else if (_selectedFeelings.contains('Breast Pain')) {
      _contextText = "She is experiencing physical discomfort. Help manage the logistics.";
      _partnerActionPlan.addAll([
        {'title': 'Wash and sterilize the pump parts', 'priority': 'HIGH'},
        {'title': 'Prepare ice packs or warm compresses', 'priority': 'STABILITY TASK'}
      ]);
    } else {
      _contextText = "She needs your active support today. Stay close.";
    }
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
}

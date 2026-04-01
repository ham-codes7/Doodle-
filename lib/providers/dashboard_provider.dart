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

    if (_selectedFeelings.contains('Incision Pain')) {
      _contextText = "She is managing significant surgical discomfort. Help her stay ahead of the pain.";
      _partnerActionPlan.addAll([
        {'title': "Check if it's time for her pain medication.", 'priority': 'CRITICAL'}
      ]);
    }
    
    if (_selectedFeelings.contains('Lochia (Bleeding)')) {
      _partnerActionPlan.addAll([
        {'title': "Bring her a fresh ice pack and heavy pads.", 'priority': 'PHYSICAL CARE'}
      ]);
      if (!_selectedFeelings.contains('Incision Pain')) {
        _contextText = "She is experiencing active physical recovery. Ensure she does not overexert herself.";
      }
    }

    if (_selectedFeelings.contains('Overstimulated')) {
      _partnerActionPlan.addAll([
        {'title': "Take the baby for 45 minutes of skin-to-skin in another room.", 'priority': 'EMOTIONAL SUPPORT'}
      ]);
      if (!_selectedFeelings.contains('Incision Pain') && !_selectedFeelings.contains('Lochia (Bleeding)')) {
        _contextText = "Sensory overload is peaking. Help reduce noise and active stimulation around her.";
      }
    }

    if (_partnerActionPlan.isEmpty) {
      _contextText = "She needs your active support today. Check in gently and stay close.";
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

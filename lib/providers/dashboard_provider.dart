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
  String _mamaFeelingsSummaryText = "She is resting currently.";
  String _contextText = "No symptoms logged yet today. Check in gently.";

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
    
    _updatePartnerDashboard(); // Trigger dynamic logic
    notifyListeners();
  }

  void _updatePartnerDashboard() {
    _partnerActionPlan.clear();

    if (_selectedFeelings.isEmpty) {
      _mamaFeelingsSummaryText = "She is resting currently.";
      _contextText = "No symptoms logged yet today. Check in gently.";
      return;
    }

    // 1. Build dynamic feelings summary text
    List<String> feelingNames = _selectedFeelings.toList();
    if (feelingNames.length == 1) {
      _mamaFeelingsSummaryText = "She is feeling ${feelingNames[0]}.";
    } else if (feelingNames.length == 2) {
      _mamaFeelingsSummaryText = "She is feeling ${feelingNames[0]} & ${feelingNames[1]}.";
    } else {
      final last = feelingNames.removeLast();
      _mamaFeelingsSummaryText = "She is feeling ${feelingNames.join(', ')}, & $last.";
      feelingNames.add(last);
    }

    // 2. Build Context and Action Plan
    List<String> contexts = [];

    if (_selectedFeelings.contains('Exhausted')) {
      contexts.add("Her body is recovering from extreme physical trauma and sleep deprivation is peaking. She needs physical rest, not solutions.");
      _partnerActionPlan.add({'title': 'Take over all non-feeding baby duties tonight', 'priority': 'CRITICAL'});
      _partnerActionPlan.add({'title': 'Let her sleep uninterrupted for 4 hours', 'priority': 'HIGH'});
    }

    if (_selectedFeelings.contains('Weepy')) {
      contexts.add("Hormone crash is active. Do not try to fix her sadness, just listen and validate.");
      _partnerActionPlan.add({'title': 'Bring her water and just hold her', 'priority': 'HIGH'});
      _partnerActionPlan.add({'title': 'Tell her she is doing an amazing job', 'priority': 'EMOTIONAL SUPPORT'});
    }

    if (_selectedFeelings.contains('Breast Pain')) {
      _partnerActionPlan.add({'title': 'Wash and sterilize the pump parts', 'priority': 'HIGH'});
      _partnerActionPlan.add({'title': 'Prepare ice packs or warm compresses', 'priority': 'STABILITY TASK'});
    }

    // Combine contexts logically or set a default if unmapped feelings were added
    if (contexts.isNotEmpty) {
      _contextText = contexts.join(" ");
    } else {
      _contextText = "She has logged new feelings. Check in with her gently.";
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

  void updateHydration(double liters) {
    _hydrationLiters = liters;
    notifyListeners();
  }

  void togglePartnerTask(int index, bool? isComplete) {
    _completedPartnerTasks[index] = isComplete ?? false;
    notifyListeners();
  }
}

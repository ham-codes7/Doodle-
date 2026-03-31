import 'dart:math';
import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  // --- Mother's State ---
  String _age = '';
  String _height = '';
  String _weight = '';
  DateTime? _deliveryDate;
  String _deliveryType = 'Vaginal'; // Default value
  bool _isFirstPregnancy = false; // Default value
  String? _generatedPairingCode;

  // --- Partner's State ---
  String _enteredPairingCode = '';

  // --- Public Getters ---
  String get age => _age;
  String get height => _height;
  String get weight => _weight;
  DateTime? get deliveryDate => _deliveryDate;
  String get deliveryType => _deliveryType;
  bool get isFirstPregnancy => _isFirstPregnancy;
  String? get generatedPairingCode => _generatedPairingCode;

  String get enteredPairingCode => _enteredPairingCode;

  // --- Methods (Setters & Logic) ---
  void setAge(String val) {
    _age = val;
    notifyListeners();
  }

  void setHeight(String val) {
    _height = val;
    notifyListeners();
  }

  void setWeight(String val) {
    _weight = val;
    notifyListeners();
  }

  void setDeliveryDate(DateTime date) {
    _deliveryDate = date;
    notifyListeners();
  }

  void setDeliveryType(String type) {
    if (type == 'Vaginal' || type == 'C-Section') {
      _deliveryType = type;
      notifyListeners();
    }
  }

  void toggleFirstPregnancy(bool value) {
    _isFirstPregnancy = value;
    notifyListeners();
  }

  void setEnteredPairingCode(String code) {
    _enteredPairingCode = code;
    notifyListeners();
  }

  void generatePairingCode() {
    // Generate a random 4-digit PIN between 1000 and 9999
    final random = Random();
    final code = (1000 + random.nextInt(9000)).toString();
    _generatedPairingCode = code;
    notifyListeners();
  }
}

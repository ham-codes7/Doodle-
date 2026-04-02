
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class OnboardingProvider extends ChangeNotifier {
  // --- Auth & Onboarding State ---
  bool _isLoading = false;
  String? _error;
  String? _generatedPairingCode;
  String? _userName;
  String? _userEmail;
  String? _userRole;

  // --- Mother's Form State ---
  String _age = '';
  String _height = '';
  String _weight = '';
  DateTime? _deliveryDate;
  String _deliveryType = 'Vaginal';
  bool _isFirstPregnancy = false;

  // --- Partner's State ---
  String _enteredPairingCode = '';

  // --- Public Getters ---
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get generatedPairingCode => _generatedPairingCode;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get userRole => _userRole;
  String get age => _age;
  String get height => _height;
  String get weight => _weight;
  DateTime? get deliveryDate => _deliveryDate;
  String get deliveryType => _deliveryType;
  bool get isFirstPregnancy => _isFirstPregnancy;
  String get enteredPairingCode => _enteredPairingCode;

  // --- Dynamic Postpartum Timeline Math ---

  int get currentPostpartumWeek {
    if (_deliveryDate == null) return 0;
    final now = DateTime.now();
    if (now.isBefore(_deliveryDate!)) return 0;

    final diffDays = now.difference(_deliveryDate!).inDays;
    return diffDays ~/ 7;
  }

  String get currentPostpartumPhase {
    final weeks = currentPostpartumWeek;
    if (weeks <= 2) return "Acute Recovery";
    if (weeks <= 6) return "Subacute Recovery";
    if (weeks <= 12) return "Delayed Recovery";
    return "Graduated";
  }

  double get postpartumProgressPercentage {
    final weeks = currentPostpartumWeek;
    if (weeks > 12) return 1.0;
    return weeks / 12.0;
  }

  bool get isMotherFormValid =>
      _age.isNotEmpty &&
      _height.isNotEmpty &&
      _weight.isNotEmpty &&
      _deliveryDate != null;

  // --- Methods ---
  void setAge(String val) => {_age = val, notifyListeners()};
  void setHeight(String val) => {_height = val, notifyListeners()};
  void setWeight(String val) => {_weight = val, notifyListeners()};
  void setDeliveryDate(DateTime date) => {
    _deliveryDate = date,
    notifyListeners(),
  };
  void setDeliveryType(String type) => {
    _deliveryType = type,
    notifyListeners(),
  };
  void toggleFirstPregnancy(bool value) => {
    _isFirstPregnancy = value,
    notifyListeners(),
  };
  void setEnteredPairingCode(String code) => {
    _enteredPairingCode = code,
    notifyListeners(),
  };

  // --- API Actions ---

  Future<bool> registerUser(
    String name,
    String email,
    String password,
    String role,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await ApiService.register(name, email, password, role);
      if (result['success'] == true) {
        // The backend returns partnerCodeDisplay (plaintext 4-digit code) as 'partnerCode'
        final code = result['user']['partnerCode']?.toString() ?? '';

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result['token']);
        await prefs.setString('role', result['user']['role']);
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('pairingCode', code);           // ✅ persist code
        await prefs.setString('userName', result['user']['name'] ?? '');
        await prefs.setString('userEmail', result['user']['email'] ?? '');

        _generatedPairingCode = code.isNotEmpty ? code : null;
        _userRole = result['user']['role'];
        _userName = result['user']['name'];
        _userEmail = result['user']['email'];

        debugPrint('✅ Registered. pairingCode saved to prefs: $code');

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = result['message'];
      }
    } catch (e) {
      _error = "Connection failed. Please check if the server is running.";
      debugPrint('❌ registerUser error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> loginUser(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await ApiService.login(email, password);
      if (result['success'] == true) {
        final code = result['user']['partnerCode']?.toString() ?? '';

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result['token']);
        await prefs.setString('role', result['user']['role']);
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('pairingCode', code);           // ✅ persist code
        await prefs.setString('userName', result['user']['name'] ?? '');
        await prefs.setString('userEmail', result['user']['email'] ?? '');

        _generatedPairingCode = code.isNotEmpty ? code : null;
        _userRole = result['user']['role'];
        _userName = result['user']['name'];
        _userEmail = result['user']['email'];

        debugPrint('✅ Logged in. pairingCode from server: $code');

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = result['message'];
      }
    } catch (e) {
      _error = "Connection failed. Please check if the server is running.";
      debugPrint('❌ loginUser error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> linkWithMother() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final storedCode = prefs.getString('pairingCode') ?? '';

      // Accept stored pairing code OR master demo PIN "1234"
      final isValid = _enteredPairingCode.isNotEmpty &&
          (_enteredPairingCode == storedCode || _enteredPairingCode == '1234');

      if (isValid) {
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('role', 'Partner');
        await prefs.setString('pairingCode', _enteredPairingCode);

        _userRole = 'Partner';
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Invalid pairing code. Please check with your partner.';
      }
    } catch (e) {
      _error = 'Linking failed. Please try again.';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void reset() {
    _isLoading = false;
    _error = null;
    _age = '';
    _height = '';
    _weight = '';
    _deliveryDate = null;
    _deliveryType = 'Vaginal';
    _isFirstPregnancy = false;
    _generatedPairingCode = null;
    _enteredPairingCode = '';
    notifyListeners();
  }

  // generatePairingCode() removed — the backend generates the code during
  // registerUser() via the bcrypt pre-save hook. The code is returned in the
  // API response and persisted to SharedPreferences there.

  Future<bool> checkLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      _userRole = prefs.getString('role');
      _userName = prefs.getString('userName');
      _userEmail = prefs.getString('userEmail');

      // Restore the pairing code so the UI can display it after restart
      final savedCode = prefs.getString('pairingCode') ?? '';
      _generatedPairingCode = savedCode.isNotEmpty ? savedCode : null;

      debugPrint('🔄 Session restored | role=$_userRole | pairingCode=$_generatedPairingCode');
      notifyListeners();
      return true;
    }
    return false;
  }
}

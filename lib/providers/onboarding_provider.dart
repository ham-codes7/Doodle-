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
  String get age => _age;
  String get height => _height;
  String get weight => _weight;
  DateTime? get deliveryDate => _deliveryDate;
  String get deliveryType => _deliveryType;
  bool get isFirstPregnancy => _isFirstPregnancy;
  String get enteredPairingCode => _enteredPairingCode;

  bool get isMotherFormValid =>
      _age.isNotEmpty &&
      _height.isNotEmpty &&
      _weight.isNotEmpty &&
      _deliveryDate != null;

  // --- Methods ---
  void setAge(String val) => { _age = val, notifyListeners() };
  void setHeight(String val) => { _height = val, notifyListeners() };
  void setWeight(String val) => { _weight = val, notifyListeners() };
  void setDeliveryDate(DateTime date) => { _deliveryDate = date, notifyListeners() };
  void setDeliveryType(String type) => { _deliveryType = type, notifyListeners() };
  void toggleFirstPregnancy(bool value) => { _isFirstPregnancy = value, notifyListeners() };
  void setEnteredPairingCode(String code) => { _enteredPairingCode = code, notifyListeners() };

  // --- API Actions ---

  Future<bool> registerUser(String name, String email, String password, String role) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await ApiService.register(name, email, password, role);
      if (result['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result['token']);
        await prefs.setString('role', result['user']['role']);
        await prefs.setBool('isLoggedIn', true);
        
        _generatedPairingCode = result['user']['partnerCode'];
        _userRole = result['user']['role'];
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = result['message'];
      }
    } catch (e) {
      _error = "Connection failed. Please check if the server is running.";
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
      final result = await ApiService.linkPartner(_enteredPairingCode);
      if (result['success'] == true) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = result['message'];
      }
    } catch (e) {
      _error = "Linking failed. Please check the code or connection.";
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
}

  void reset() {
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
}

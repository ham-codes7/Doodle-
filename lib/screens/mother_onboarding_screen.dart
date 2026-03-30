import 'package:flutter/material.dart';

class MotherOnboardingScreen extends StatefulWidget {
  const MotherOnboardingScreen({super.key});

  @override
  State<MotherOnboardingScreen> createState() => _MotherOnboardingScreenState();
}

class _MotherOnboardingScreenState extends State<MotherOnboardingScreen> {
  DateTime? _deliveryDate;
  String _deliveryType = 'Vaginal';
  bool _isFirstPregnancy = true;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6B5B95), // Dark Lavender
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF6B5B95),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _deliveryDate) {
      setState(() {
        _deliveryDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mother Setup",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF6B5B95),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Let's personalize your experience.",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B5B95),
              ),
            ),
            const SizedBox(height: 32),
            _buildTextField(label: "Age"),
            const SizedBox(height: 16),
            _buildTextField(label: "Height (cm)"),
            const SizedBox(height: 16),
            _buildTextField(label: "Weight (kg)"),
            const SizedBox(height: 24),
            
            // Delivery Date Picker
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFD1DC), width: 1.5),
              ),
              child: ListTile(
                title: const Text("Delivery Date"),
                subtitle: Text(
                  _deliveryDate == null
                      ? "Select expected date"
                      : "${_deliveryDate!.month}/${_deliveryDate!.day}/${_deliveryDate!.year}",
                  style: TextStyle(
                    color: _deliveryDate == null ? Colors.grey : const Color(0xFF6B5B95),
                    fontWeight: _deliveryDate == null ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.calendar_today, color: Color(0xFF6B5B95)),
                onTap: () => _selectDate(context),
              ),
            ),
            const SizedBox(height: 16),
            
            // Delivery Type Dropdown
            DropdownButtonFormField<String>(
              value: _deliveryType,
              decoration: InputDecoration(
                labelText: "Delivery Type",
                labelStyle: const TextStyle(color: Color(0xFF6B5B95)),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFFFD1DC), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF6B5B95), width: 2),
                ),
              ),
              items: <String>['Vaginal', 'C-Section']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _deliveryType = newValue;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            
            // First Pregnancy Switch
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFD1DC), width: 1.5),
              ),
              child: SwitchListTile(
                title: const Text("Is this your first pregnancy?"),
                activeColor: Colors.white,
                activeTrackColor: const Color(0xFF6B5B95),
                inactiveThumbColor: const Color(0xFF6B5B95),
                inactiveTrackColor: const Color(0xFFFFD1DC).withOpacity(0.5),
                value: _isFirstPregnancy,
                onChanged: (bool value) {
                  setState(() {
                    _isFirstPregnancy = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 48),
            
            // Generate Code Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B5B95),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28), // Pill-shaped
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  print("Code Generated");
                },
                child: const Text(
                  "Generate Partner Pairing Code",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF6B5B95)),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFFD1DC), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF6B5B95), width: 2),
        ),
      ),
    );
  }
}

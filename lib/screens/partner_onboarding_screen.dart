import 'package:flutter/material.dart';

class PartnerOnboardingScreen extends StatefulWidget {
  const PartnerOnboardingScreen({super.key});

  @override
  State<PartnerOnboardingScreen> createState() => _PartnerOnboardingScreenState();
}

class _PartnerOnboardingScreenState extends State<PartnerOnboardingScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Partner Setup",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF6B5B95),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              const Text(
                "Link Your Accounts",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B5B95),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Enter the 4-digit pairing code from your partner's app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 64),
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 16.0,
                  color: Color(0xFF6B5B95),
                ),
                decoration: InputDecoration(
                  counterText: "", // Hide the character counter
                  hintText: "0000",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade300,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 24.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: Color(0xFFFFD1DC), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: Color(0xFF6B5B95), width: 3),
                  ),
                ),
              ),
              const SizedBox(height: 64),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B5B95), // Dark Lavender background
                    foregroundColor: const Color(0xFFFFD1DC), // Muted Peach text
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    print("Linked");
                  },
                  child: const Text(
                    "Link Accounts",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

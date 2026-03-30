import 'dart:ui';
import 'package:flutter/material.dart';
import 'mother_onboarding_screen.dart';
import 'partner_onboarding_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 64),
              const Text(
                "Welcome to [App Name]",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: Color(0xFF6B5B95),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "How can we support you today?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 48),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildGlassCard(
                      context: context,
                      title: "I am navigating postpartum",
                      color: const Color(0xFF6B5B95),
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MotherOnboardingScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildGlassCard(
                      context: context,
                      title: "I am supporting my partner",
                      color: const Color(0xFFFFD1DC),
                      textColor: const Color(0xFF6B5B95), // Using Dark Lavender for contrast
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PartnerOnboardingScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 64), // extra bottom spacing visually
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCard({
    required BuildContext context,
    required String title,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color.withOpacity(0.85),
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

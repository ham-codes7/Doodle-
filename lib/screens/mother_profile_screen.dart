import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/onboarding_provider.dart';

class MotherProfileScreen extends StatelessWidget {
  const MotherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6B5B95)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Profile Hub",
          style: GoogleFonts.poppins(
            color: const Color(0xFF6B5B95),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              // Progress Ring
              Hero(
                tag: 'profile_hero',
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 0.25), // e.g., week 3 out of 12
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeInOut,
                    builder: (context, double value, child) {
                      return Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: value,
                          backgroundColor: Colors.grey.shade200,
                          color: const Color(0xFF6B5B95),
                          strokeWidth: 12.0,
                        ),
                        Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Week 3",
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF6B5B95),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              ),
              const SizedBox(height: 16),
              Text(
                "The Fourth Trimester",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6B5B95),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 48),

              // Body Metrics Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.8,
                children: [
                  _buildMetricCard("Age", "${provider.age} yrs"),
                  _buildMetricCard("Height", "${provider.height} cm"),
                  _buildMetricCard("Weight", "${provider.weight} kg"),
                  _buildMetricCard("Delivery", provider.deliveryType),
                ],
              ),
              const SizedBox(height: 48),

              // The Pairing Code
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF0F3), // Soft Pink
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Partner Pairing Code",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF6B5B95),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      provider.generatedPairingCode ?? "----",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF6B5B95),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 8.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.poppins(
              color: Colors.grey[600],
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: const Color(0xFF6B5B95),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

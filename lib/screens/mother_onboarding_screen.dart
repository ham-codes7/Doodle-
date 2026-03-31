import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/onboarding_provider.dart';

class MotherOnboardingScreen extends StatelessWidget {
  const MotherOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFBF7),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6B5B95)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Serene Sanctuary",
          style: GoogleFonts.poppins(
            color: const Color(0xFF6B5B95),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Subtitle
            Text(
              "Welcome Home, Mama",
              style: GoogleFonts.poppins(
                color: const Color(0xFF6B5B95),
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Let's tailor your restorative journey. Please share a few details about your recent transition.",
              style: GoogleFonts.poppins(
                color: const Color(0xFF6B5B95).withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.normal,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 48),

            // Vital Stats Row
            Row(
              children: [
                _buildStatField(
                  context,
                  "AGE",
                  "28",
                  (val) => context.read<OnboardingProvider>().setAge(val),
                ),
                const SizedBox(width: 16),
                _buildStatField(
                  context,
                  "HEIGHT",
                  "165",
                  (val) => context.read<OnboardingProvider>().setHeight(val),
                ),
                const SizedBox(width: 16),
                _buildStatField(
                  context,
                  "WEIGHT",
                  "62",
                  (val) => context.read<OnboardingProvider>().setWeight(val),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Delivery Date Card
            _buildDeliveryDateCard(context),
            const SizedBox(height: 32),

            // Delivery Type Segmented Control
            _buildSegmentedControl(context),
            const SizedBox(height: 32),

            // First Pregnancy Toggle Card
            _buildPregnancyToggleCard(context),
            const SizedBox(height: 48),

            // Rounded Image & Quote Card
            _buildImageQuoteCard(),
            const SizedBox(height: 48),

            // Primary Call to Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<OnboardingProvider>().generatePairingCode();
                  print('Code generated!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B5B95),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "Generate Partner Pairing Code",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.vpn_key_outlined, color: Colors.white, size: 22),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatField(
    BuildContext context,
    String label,
    String hint,
    Function(String) onChanged,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: const Color(0xFF8E8E93),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: TextField(
              onChanged: onChanged,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: const Color(0xFF6B5B95),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  color: const Color(0xFF6B5B95).withOpacity(0.3),
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryDateCard(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();
    final date = provider.deliveryDate;
    final dateStr = date != null ? "${date.month}/${date.day}/${date.year}" : "Tap to select";

    return GestureDetector(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          context.read<OnboardingProvider>().setDeliveryDate(pickedDate);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                color: Color(0xFFF7D8DF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.calendar_today_outlined, color: Color(0xFF6B5B95), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Date",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF6B5B95),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    dateStr,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF6B5B95).withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControl(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();
    final isVaginal = provider.deliveryType == 'Vaginal';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "DELIVERY TYPE",
            style: GoogleFonts.poppins(
              color: const Color(0xFF8E8E93),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<OnboardingProvider>().setDeliveryType('Vaginal');
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: isVaginal ? const Color(0xFF6B5B95) : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: isVaginal
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      "Vaginal",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: isVaginal ? Colors.white : const Color(0xFF8E8E93),
                        fontSize: 16,
                        fontWeight: isVaginal ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<OnboardingProvider>().setDeliveryType('C-Section');
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: !isVaginal ? const Color(0xFF6B5B95) : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: !isVaginal
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      "C-Section",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: !isVaginal ? Colors.white : const Color(0xFF8E8E93),
                        fontSize: 16,
                        fontWeight: !isVaginal ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPregnancyToggleCard(BuildContext context) {
    bool isFirstPregnancy = context.watch<OnboardingProvider>().isFirstPregnancy;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0xFFE8E5F0), // Light lavender background
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.pregnant_woman, color: Color(0xFF6B5B95), size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "First pregnancy?",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF6B5B95),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Helps us curate initial advice",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF6B5B95).withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isFirstPregnancy,
            onChanged: (val) {
              context.read<OnboardingProvider>().toggleFirstPregnancy(val);
            },
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF6B5B95),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  Widget _buildImageQuoteCard() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1519689680058-324335c77eba?fit=crop&w=800&q=80', // Descriptive placeholder
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade300,
                child: const Center(
                  child: Icon(Icons.image_outlined, size: 64, color: Colors.grey),
                ),
              ),
            ),
            // Dark gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            // Text Content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Your recovery is a journey, not a race. We're here to guide every step.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

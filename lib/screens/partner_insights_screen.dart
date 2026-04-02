import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PartnerInsightsScreen extends StatelessWidget {
  const PartnerInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAF9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF6B5B95)),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: Text(
          "Partner Insights",
          style: GoogleFonts.poppins(
            color: const Color(0xFF6B5B95),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_rounded, color: Color(0xFF6B5B95)),
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSupportScoreCard(),
              const SizedBox(height: 32),
              _buildSymptomsSection(),
              const SizedBox(height: 32),
              _buildMilestonesSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportScoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF86D7AA), Color(0xFFEADB7F)], // Soft green/gold gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF86D7AA).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star_rounded, color: Colors.white, size: 28),
              const SizedBox(width: 8),
              Text(
                "SUPPORT SCORE",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "85% Task Completion Rate",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "You are doing a great job supporting her recovery.",
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.95),
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Logged Symptoms",
          style: GoogleFonts.poppins(
            color: const Color(0xFF6B5B95),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildSymptomChip(
              icon: Icons.healing,
              text: "Incision Pain (Logged 2x)",
              bgColor: const Color(0xFFFDF0F3), // Soft Red/Pink
              textColor: const Color(0xFFE57373),
            ),
            _buildSymptomChip(
              icon: Icons.water_drop,
              text: "Baby Blues (Logged 3x)",
              bgColor: const Color(0xFFEEF5FD), // Soft Blue
              textColor: const Color(0xFF64B5F6),
            ),
            _buildSymptomChip(
              icon: Icons.nightlight_round,
              text: "Fatigue (Logged 5x)",
              bgColor: const Color(0xFFF3F0FA), // Soft Purple
              textColor: const Color(0xFF9575CD),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSymptomChip({
    required IconData icon,
    required String text,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestonesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upcoming Milestones",
          style: GoogleFonts.poppins(
            color: const Color(0xFF6B5B95),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        _buildMilestoneCard(
          "Week 4",
          "Lochia should begin subsiding.",
          Icons.opacity_outlined,
        ),
        const SizedBox(height: 12),
        _buildMilestoneCard(
          "Week 6",
          "Doctor Clearance Checkup.",
          Icons.medical_services_outlined,
        ),
        const SizedBox(height: 12),
        _buildMilestoneCard(
          "Week 12",
          "Graduation from Fourth Trimester.",
          Icons.celebration_outlined,
        ),
      ],
    );
  }

  Widget _buildMilestoneCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFCFAF9),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Icon(icon, color: const Color(0xFF6B5B95), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF6B5B95),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

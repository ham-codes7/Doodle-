import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';

class MotherLoggerScreen extends StatelessWidget {
  const MotherLoggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6B5B95)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How are you, Mama?",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6B5B95),
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Log your feelings to keep track and let your partner know how to help.",
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              
              _buildSectionTitle("Mood"),
              const SizedBox(height: 16),
              _buildMoodSection(provider, context),
              
              const SizedBox(height: 32),
              
              _buildSectionTitle("Physical"),
              const SizedBox(height: 16),
              _buildPhysicalSection(provider, context),
              
              const SizedBox(height: 48),
              
              _buildSaveButton(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        color: const Color(0xFF6B5B95),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  Widget _buildMoodSection(DashboardProvider provider, BuildContext context) {
    final moods = ['Happy', 'Anxious', 'Weepy', 'Overwhelmed'];
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: moods.map((mood) => _buildChip(mood, provider, context)).toList(),
    );
  }

  Widget _buildPhysicalSection(DashboardProvider provider, BuildContext context) {
    final physicals = ['Exhausted', 'Breast Pain', 'Incision Pain', 'Cramping'];
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: physicals.map((physical) => _buildChip(physical, provider, context)).toList(),
    );
  }

  Widget _buildChip(String name, DashboardProvider provider, BuildContext context) {
    final isSelected = provider.selectedFeelings.contains(name);
    return FilterChip(
      label: Text(
        name,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : const Color(0xFF6B5B95),
        ),
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        context.read<DashboardProvider>().toggleFeeling(name);
      },
      selectedColor: const Color(0xFF6B5B95),
      backgroundColor: Colors.white,
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? const Color(0xFF6B5B95) : Colors.grey.withOpacity(0.3),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B5B95),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Log saved successfully!',
                style: GoogleFonts.poppins(),
              ),
              backgroundColor: Colors.green[600],
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context);
        },
        child: Text(
          "Save Log",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

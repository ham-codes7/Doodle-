import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import '../providers/onboarding_provider.dart';

class MotherLoggerScreen extends StatelessWidget {
  const MotherLoggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();
    final mamaName = context.read<OnboardingProvider>().userName ?? "Mama";

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
                "How are you, $mamaName?",
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
              _buildSectionTitle("Physical Recovery"),
              const SizedBox(height: 16),
              _buildSection(provider, context, ['Lochia (Bleeding)', 'Incision Pain', 'Uterine Cramping']),
              
              const SizedBox(height: 32),
              
              _buildSectionTitle("Vitals & Care"),
              const SizedBox(height: 16),
              _buildSection(provider, context, ['Dehydrated', 'Sleep Deprived', 'Skipped Prenatals']),
              
              const SizedBox(height: 32),
              
              _buildSectionTitle("Emotional"),
              const SizedBox(height: 16),
              _buildSection(provider, context, ['Baby Blues', 'Overstimulated', 'Bonding well']),
              
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

  Widget _buildSection(DashboardProvider provider, BuildContext context, List<String> items) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: items.map((item) => _buildChip(item, provider, context)).toList(),
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
        onPressed: () async {
          final success = await context.read<DashboardProvider>().submitLog();
          if (success) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Sanctuary updated. Partner notified.',
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: const Color(0xFF6B5B95),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pop(context);
            }
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.read<DashboardProvider>().error ?? 'Failed to update Sanctuary',
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: Colors.red[600],
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        },
        child: context.watch<DashboardProvider>().isLoading 
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              "Update Sanctuary",
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

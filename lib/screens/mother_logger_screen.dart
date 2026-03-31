import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';

class MotherLoggerScreen extends StatelessWidget {
  const MotherLoggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watching the provider for updates to UI state
    final provider = context.watch<DashboardProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Theme Cream
      body: SafeArea(
        child: SingleChildScrollView(
          // Strict Rule: No Spacer/Expanded inside this Column
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildSymptomSection(context, provider),
              const SizedBox(height: 32),
              _buildEmotionalPulse(context, provider),
              const SizedBox(height: 32),
              _buildVitalStats(provider),
              const SizedBox(height: 48),
              _buildSaveButton(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // 1. Header with custom back button
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Color(0xFF6B5B95)),
            ),
          ),
          const SizedBox(width: 24),
          Text(
            "Detailed Log",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6B5B95), // Theme Lavender
            ),
          ),
        ],
      ),
    );
  }

  // 2. Physical Symptoms Grid (using Wrap to avoid scroll issues)
  Widget _buildSymptomSection(BuildContext context, DashboardProvider provider) {
    final symptoms = [
      {'name': 'Exhausted', 'icon': Icons.battery_alert},
      {'name': 'Weepy', 'icon': Icons.water_drop},
      {'name': 'Breast Pain', 'icon': Icons.favorite},
      {'name': 'Bleeding', 'icon': Icons.bloodtype},
      {'name': 'Anxious', 'icon': Icons.psychology},
      {'name': 'Dizzy', 'icon': Icons.rebase_edit},
      {'name': 'Nausea', 'icon': Icons.sick},
      {'name': 'Cramping', 'icon': Icons.compress},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Physical Symptoms",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B5B95),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: symptoms.map((s) {
              final isSelected = provider.selectedFeelings.contains(s['name']);
              return GestureDetector(
                onTap: () => provider.toggleFeeling(s['name'] as String),
                child: Container(
                  width: (MediaQuery.of(context).size.width - 60) / 2, // 2 items per row
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF6B5B95) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF6B5B95) : const Color(0xFFFDF0F3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        s['icon'] as IconData,
                        size: 20,
                        color: isSelected ? Colors.white : const Color(0xFF6B5B95),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          s['name'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : const Color(0xFF6B5B95),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // 3. Emotional Pulse Selection
  Widget _buildEmotionalPulse(BuildContext context, DashboardProvider provider) {
    final moods = ['🌱 Calm', '☁️ Heavy', '🌙 Tired', '✨ Joyful', '🌪️ Tense'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Emotional Pulse",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B5B95),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: moods.map((mood) {
                final isSelected = provider.selectedFeelings.contains(mood);
                return GestureDetector(
                  onTap: () => provider.toggleFeeling(mood),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF6B5B95) : const Color(0xFFFDF0F3), // Theme Pink
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      mood,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF6B5B95),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // 4. Vital Indicators
  Widget _buildVitalStats(DashboardProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vital Indicators",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B5B95),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildStatRow("Hydration", "${provider.hydrationLiters}L / 3L", Icons.water_drop, 0.4),
                const SizedBox(height: 20),
                _buildStatRow("Sleep Quality", "Restless", Icons.nightlight_round, 0.6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon, double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: const Color(0xFF6B5B95).withOpacity(0.7)),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF6B5B95),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: const Color(0xFFFDF0F3),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6B5B95)),
          ),
        ),
      ],
    );
  }

  // 5. Save Button
  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xFF6B5B95), Color(0xFF8E7DBC)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6B5B95).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              "Save Daily Log",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

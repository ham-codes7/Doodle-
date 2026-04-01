import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import 'partner_insights_screen.dart';
import 'role_selection_screen.dart';
import 'placeholder_screen.dart';
import 'mother_dashboard_screen.dart';

class PartnerDashboardScreen extends StatelessWidget {
  const PartnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Soft cream
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 32),
              _buildCurrentStateCard(provider),
              const SizedBox(height: 32),
              _buildActionPlanList(context, provider),
              const SizedBox(height: 32),
              _buildBackgroundTasks(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // 1. Header
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.logout, color: Color(0xFF6B5B95)),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
                      (route) => false,
                    );
                  },
                ),
                // PITCH DEMO ONLY
                IconButton(
                  icon: const Icon(Icons.swap_horiz, color: Color(0xFF6B5B95)),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MotherDashboardScreen()),
                    );
                  },
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFFE2D9F3),
                  child: Icon(Icons.person, color: Color(0xFF6B5B95)),
                ),
                const SizedBox(width: 12),
                Text(
                  "Partner Support",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF6B5B95), // Dark Lavender
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined, color: Colors.grey),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen()));
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          "Action Dashboard",
          style: GoogleFonts.poppins(
            color: const Color(0xFF6B5B95),
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        Text(
          "Real-time support guide for your partner.",
          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // 2. Current State Translation Card
  Widget _buildCurrentStateCard(DashboardProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF6B5B95), // Deep Lavender
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "MAMA'S CURRENT STATE",
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Updated 2 mins ago",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            provider.mamaFeelingsSummaryText,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF7A6AA6), // Slightly lighter purple
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.lightbulb_outline, color: Colors.white70, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "CONTEXT",
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  provider.contextText,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. Action Plan List
  Widget _buildActionPlanList(BuildContext context, DashboardProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your Action Plan",
          style: GoogleFonts.poppins(
            color: const Color(0xFF6B5B95),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          context: context,
          provider: provider,
          taskIndex: 0,
          title: "Take over all non-feeding baby duties tonight.",
          subtitle: "CRITICAL PRIORITY",
          color: Colors.red,
        ),
        const SizedBox(height: 12),
        _buildActionCard(
          context: context,
          provider: provider,
          taskIndex: 1,
          title: "Wash and sterilize the pump parts.",
          subtitle: "HIGH PRIORITY",
          color: Colors.orange,
        ),
        const SizedBox(height: 12),
        _buildActionCard(
          context: context,
          provider: provider,
          taskIndex: 2,
          title: "Refill her 32oz water bottle.",
          subtitle: "STABILITY TASK",
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required DashboardProvider provider,
    required int taskIndex,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    final bool isCompleted = provider.completedPartnerTasks[taskIndex] ?? false;

    final bool isCritical = subtitle.contains('CRITICAL');

    return Container(
      decoration: BoxDecoration(
        color: isCritical ? const Color(0xFFFDF0F3) : null,
        borderRadius: BorderRadius.circular(24),
        border: isCritical ? Border.all(color: const Color(0xFF6B5B95), width: 1.5) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: isCritical
            ? null
            : const LinearGradient(
                colors: [Color(0xFFFDF0F3), Color(0xFFFCE4EC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    Checkbox(
                      value: isCompleted,
                      onChanged: (bool? newValue) {
                        context.read<DashboardProvider>().togglePartnerTask(taskIndex, newValue);
                      },
                      activeColor: const Color(0xFF6B5B95),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF6B5B95),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              decoration: isCompleted ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: GoogleFonts.poppins(
                              color: color,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 4. Background Tasks
  Widget _buildBackgroundTasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Household Background Tasks",
          style: GoogleFonts.poppins(
            color: const Color(0xFF6B5B95),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildBackgroundTaskCard(Icons.local_dining, "Run Dishwasher"),
              const SizedBox(width: 16),
              _buildBackgroundTaskCard(Icons.dinner_dining, "Prep Dinner"),
              const SizedBox(width: 16),
              _buildBackgroundTaskCard(Icons.local_laundry_service, "Do Laundry"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundTaskCard(IconData icon, String title) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xFFFDF0F3), Color(0xFFFCE4EC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF0F3), // Soft Pink
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF6B5B95)),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: const Color(0xFF6B5B95),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // 5. Bottom Navigation Bar
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF6B5B95),
      unselectedItemColor: Colors.grey[400],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 20,
      currentIndex: 2, // Tasks is selected
      onTap: (index) {
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PartnerInsightsScreen()));
        } else if (index == 0 || index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen()));
        }
      },
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: 'Today',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: 'Insights',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFFDF0F3), // pink circle background
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle_outline, color: Color(0xFF6B5B95)),
          ),
          label: 'Tasks',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Chat',
        ),
      ],
    );
  }
}

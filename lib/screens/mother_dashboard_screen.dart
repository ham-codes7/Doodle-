import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import 'partner_dashboard_screen.dart';
import 'mother_logger_screen.dart';
import 'mother_care_screen.dart';
import 'role_selection_screen.dart';
import 'placeholder_screen.dart';
import 'mother_profile_screen.dart';

class MotherDashboardScreen extends StatelessWidget {
  const MotherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. App-wide Provider State
    final provider = context.watch<DashboardProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Soft cream background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 32),
              _buildHormoneDropCard(provider),
              const SizedBox(height: 32),
              _buildBubbleLogger(context, provider),
              const SizedBox(height: 32),
              _buildSOSButton(context),
              const SizedBox(height: 32),
              _buildCuratedPlan(context, provider),
              const SizedBox(height: 32),
              _buildStatsRow(provider),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // 1. Header
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.logout, color: Color(0xFF6B5B95)),
              padding: EdgeInsets.zero,
              alignment: Alignment.topLeft,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
                  (route) => false,
                );
              },
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, Mama",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF6B5B95), // Dark Lavender
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                Text(
                  "Day 14 of your Fourth Trimester",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.swap_horiz, color: Color(0xFF6B5B95), size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PartnerDashboardScreen()),
                );
              },
            ),
            Hero(
              tag: 'profile_hero',
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFE2D9F3),
                child: Icon(Icons.person, color: Color(0xFF6B5B95)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 2. Hormone Drop Card
  Widget _buildHormoneDropCard(DashboardProvider provider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF0F3), // Soft Pink
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Current Phase: The Hormone Drop",
            style: GoogleFonts.poppins(
              color: const Color(0xFF6B5B95),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "WEEK 2",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6B5B95),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "WEEK 6",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6B5B95),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.3, // ~30% filled
            backgroundColor: Colors.white,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6B5B95)),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  // 3. Bubble Logger ("Log your day")
  Widget _buildBubbleLogger(BuildContext context, DashboardProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Log your day",
          style: GoogleFonts.poppins(
            color: const Color(0xFF6B5B95),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildBubble(context, provider, "💧", "Weepy"),
              const SizedBox(width: 12),
              _buildBubble(context, provider, "🩸", "Bleeding"),
              const SizedBox(width: 12),
              _buildBubble(context, provider, "🥥", "Breast Pain"),
              const SizedBox(width: 12),
              _buildBubble(context, provider, "😴", "Exhausted"),
              const SizedBox(width: 12),
              _buildBubble(context, provider, "😰", "Anxious"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBubble(BuildContext context, DashboardProvider provider, String emoji, String text) {
    final bool isSelected = provider.selectedFeelings.contains(text);
    return GestureDetector(
      onTap: () {
        context.read<DashboardProvider>().toggleFeeling(text);
      },
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6B5B95) : Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : Colors.grey[800],
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // 4. SOS Button
  Widget _buildSOSButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          context.read<DashboardProvider>().sendSos();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFEBEE), // Soft Red/Pink background
          foregroundColor: Colors.red[900], // Dark red foreground
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Pill-shaped
          ),
        ),
        icon: Icon(Icons.warning, color: Colors.red[900]),
        label: Text(
          "Send SOS: I need 10 minutes alone",
          style: GoogleFonts.poppins(
            color: Colors.red[900],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // 5. Curated Plan
  Widget _buildCuratedPlan(BuildContext context, DashboardProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your Curated Plan",
          style: GoogleFonts.poppins(
            color: const Color(0xFF6B5B95),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        _buildPlanCard(
          context: context,
          provider: provider,
          taskIndex: 0,
          icon: Icons.air,
          iconColor: Colors.pink[400]!,
          title: "Deep Belly Breathing",
          subtitle: "5 mins • In bed",
        ),
        const SizedBox(height: 12),
        _buildPlanCard(
          context: context,
          provider: provider,
          taskIndex: 1,
          icon: Icons.directions_walk,
          iconColor: Colors.teal[400]!,
          title: "Gentle Hallway Walk",
          subtitle: "10 mins • Minimal effort",
        ),
      ],
    );
  }

  Widget _buildPlanCard({
    required BuildContext context,
    required DashboardProvider provider,
    required int taskIndex,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    final bool isCompleted = provider.completedMamaTasks[taskIndex] ?? false;

    return Container(
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
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
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isCompleted ? Icons.check_circle : Icons.circle_outlined,
              color: isCompleted ? const Color(0xFF6B5B95) : Colors.grey,
            ),
            onPressed: () {
              context.read<DashboardProvider>().toggleMamaTask(taskIndex, !isCompleted);
            },
          )
        ],
      ),
    );
  }

  // 6. Stats Row
  Widget _buildStatsRow(DashboardProvider provider) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.water_drop,
            iconColor: Colors.blue[400]!,
            title: "HYDRATION",
            value: "${provider.waterCount}",
            onIncrement: () => provider.incrementWater(),
            onDecrement: () => provider.decrementWater(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            icon: Icons.nightlight_round,
            iconColor: Colors.indigo[400]!,
            title: "REST",
            value: "${provider.sleepHours}h",
            onIncrement: () => provider.incrementSleep(),
            onDecrement: () => provider.decrementSleep(),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
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
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
              fontSize: 12,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMinMaxButton(Icons.remove, onDecrement),
              Text(
                value,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6B5B95),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              _buildMinMaxButton(Icons.add, onIncrement),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMinMaxButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF6B5B95), width: 1.5),
        ),
        child: Icon(icon, size: 16, color: const Color(0xFF6B5B95)),
      ),
    );
  }

  // 7. Bottom Navigation Bar
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF6B5B95),
      unselectedItemColor: Colors.grey[400],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 20,
      currentIndex: 0,
      onTap: (index) {
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const MotherLoggerScreen()));
        } else if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const MotherCareScreen()));
        } else if (index == 4) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const MotherProfileScreen()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen()));
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFFDF0F3), // pink circle background
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.home, color: Color(0xFF6B5B95)),
          ),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'Journey',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: 'Logger',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Care',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}

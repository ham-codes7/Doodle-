import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MotherCareScreen extends StatelessWidget {
  const MotherCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildFeaturedVideoCard(),
              const SizedBox(height: 24),
              _buildQuickLinks(),
              const SizedBox(height: 24),
              _buildArticles(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFE2D9F3),
              child: Icon(Icons.favorite, color: Color(0xFF6B5B95)),
            ),
            const SizedBox(width: 12),
            Text(
              "Recovery Hub",
              style: GoogleFonts.poppins(
                color: const Color(0xFF6B5B95),
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "Gentle healing guide.",
          style: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedVideoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B5B95), Color(0xFF8B78B6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B5B95).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "FEATURED",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Pelvic Floor Basics",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Rebuild strength safely with these 5 gentle exercises.",
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.play_circle_fill, color: Colors.white, size: 32),
              const SizedBox(width: 8),
              Text(
                "Watch Now",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Links",
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
              _buildQuickLinkCard(Icons.local_dining, "Nutrition", Colors.orange[50]!, Colors.orange[800]!),
              const SizedBox(width: 12),
              _buildQuickLinkCard(Icons.psychology, "Mental Health", Colors.blue[50]!, Colors.blue[800]!),
              const SizedBox(width: 12),
              _buildQuickLinkCard(Icons.nightlight_round, "Rest", Colors.indigo[50]!, Colors.indigo[800]!),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinkCard(IconData icon, String title, Color bgColor, Color iconColor) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: const Color(0xFF6B5B95),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildArticles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Articles for You",
          style: GoogleFonts.poppins(
            color: const Color(0xFF6B5B95),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        _buildArticleTile(
          "Understanding Afterpains",
          "What they are and how to manage them during the first few days.",
          "3 min read",
        ),
        const SizedBox(height: 12),
        _buildArticleTile(
          "The Hormone Drop",
          "Navigating the emotional shifts of the fourth trimester.",
          "5 min read",
        ),
      ],
    );
  }

  Widget _buildArticleTile(String title, String subtitle, String readTime) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFDF0F3), // Soft pink
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.article, color: Color(0xFF6B5B95)),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: const Color(0xFF6B5B95),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              readTime,
              style: GoogleFonts.poppins(
                color: const Color(0xFF6B5B95),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}

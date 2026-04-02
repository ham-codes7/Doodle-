import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MotherCareScreen extends StatelessWidget {
  const MotherCareScreen({super.key});

  void _showArticleModal(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6B5B95),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    "This is placeholder content for the live demo.\n\n"
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris "
                    "nisi ut aliquip ex ea commodo consequat.\n\n"
                    "Duis aute irure dolor in reprehenderit in voluptate velit esse "
                    "cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat "
                    "cupidatat non proident, sunt in culpa qui officia deserunt mollit "
                    "anim id est laborum.\n\n"
                    "Phase 2 of the application will dynamically load beautiful rich-text articles, videos, and personalized medical content perfectly tailored to the mother's customized timeline.",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[700],
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B5B95),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Close",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
          "Recovery Hub",
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
              _buildHeader(),
              const SizedBox(height: 24),
              _buildFeaturedVideoCard(context),
              const SizedBox(height: 32),
              _buildQuickLinks(),
              const SizedBox(height: 32),
              _buildArticles(context),
              const SizedBox(height: 24),
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
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFE2D9F3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.favorite, color: Color(0xFF6B5B95)),
            ),
            const SizedBox(width: 16),
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

  Widget _buildFeaturedVideoCard(BuildContext context) {
    return GestureDetector(
      onTap: () => _showArticleModal(context, "Pelvic Floor Basics"),
      child: Container(
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
          clipBehavior: Clip.none,
          child: Row(
            children: [
              _buildQuickLinkCard(Icons.local_dining, "Nutrition", Colors.orange[50]!, Colors.orange[800]!),
              const SizedBox(width: 16),
              _buildQuickLinkCard(Icons.psychology, "Mental Health", Colors.blue[50]!, Colors.blue[800]!),
              const SizedBox(width: 16),
              _buildQuickLinkCard(Icons.nightlight_round, "Rest", Colors.indigo[50]!, Colors.indigo[800]!),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinkCard(IconData icon, String title, Color bgColor, Color iconColor) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(height: 16),
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

  Widget _buildArticles(BuildContext context) {
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
          context,
          "Understanding Afterpains",
          "What they are and how to manage them during the first few days.",
          "3 min read",
        ),
        const SizedBox(height: 16),
        _buildArticleTile(
          context,
          "The Hormone Drop",
          "Navigating the emotional shifts of the fourth trimester.",
          "5 min read",
        ),
        const SizedBox(height: 16),
        _buildArticleTile(
          context,
          "Lochia Normalcies",
          "Identifying safe postpartum bleeding vs warning signs.",
          "4 min read",
        ),
      ],
    );
  }

  Widget _buildArticleTile(BuildContext context, String title, String subtitle, String readTime) {
    return GestureDetector(
      onTap: () => _showArticleModal(context, title),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF0F3), // Soft pink
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.article, color: Color(0xFF6B5B95), size: 28),
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
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.access_time_filled, size: 14, color: Color(0xFF6B5B95)),
                      const SizedBox(width: 6),
                      Text(
                        readTime,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF6B5B95),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 24.0),
                child: Icon(Icons.chevron_right, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

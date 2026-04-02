import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/onboarding_provider.dart';
import 'partner_dashboard_screen.dart';

class PartnerOnboardingScreen extends StatefulWidget {
  const PartnerOnboardingScreen({super.key});

  @override
  State<PartnerOnboardingScreen> createState() => _PartnerOnboardingScreenState();
}

class _PartnerOnboardingScreenState extends State<PartnerOnboardingScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onLinkAccountSubmit(BuildContext context) async {
    final provider = context.read<OnboardingProvider>();
    final success = await provider.linkWithMother();
    if (!context.mounted) return;

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PartnerDashboardScreen()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Invalid Pairing Code. Please check with your partner.",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: Colors.red[600],
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();
    final isPinComplete = _pinController.text.length == 4;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Cream background to match theme
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Icon Header
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFFF7D8DF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.all_inclusive, // Custom dual interlocking loop placeholder
                  color: Color(0xFF6B5B95),
                  size: 36,
                ),
              ),
              const SizedBox(height: 24),
              
              // 2. Title and Subtitle
              Text(
                "Link Your Accounts",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6B5B95),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Enter the 4-digit code from your partner's app.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6B5B95),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 48),

              // 3. OTP/PIN Input Field Container
              GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(_focusNode),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(4, (index) {
                          final isFilled = index < _pinController.text.length;
                          return Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: isFilled ? const Color(0xFF6B5B95) : Colors.grey.shade200,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: isFilled
                                ? Text(
                                    _pinController.text[index],
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF6B5B95),
                                    ),
                                  )
                                : Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                            ),
                          );
                        }),
                      ),
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.0,
                          child: TextField(
                            controller: _pinController,
                            focusNode: _focusNode,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            onChanged: (val) {
                              setState(() {});
                              provider.setEnteredPairingCode(val);
                            },
                            decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // 4. Primary Call to Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isPinComplete && !provider.isLoading
                      ? () => _onLinkAccountSubmit(context)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B5B95),
                    disabledBackgroundColor: const Color(0xFF6B5B95).withOpacity(0.5),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 0,
                  ),
                  child: provider.isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Link Accounts",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // 5. Secondary Text Action
              GestureDetector(
                onTap: () {
                  // Dummy callback per instructions
                },
                child: Text(
                  "Request a new code",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF6B5B95),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // 6. Rounded Image Section (Placeholder)
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  'https://images.unsplash.com/photo-1544168190-79c15443377e?w=800&h=400&fit=crop', // Descriptive placeholder
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 64,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // 7. Footer (Flows naturally, no Stack or Positioned)
              Text(
                "By linking accounts, you agree to share health tracking data and milestone updates with your partner.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF8E8E93),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF6B5B95).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.help_outline,
                    color: Color(0xFF6B5B95),
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

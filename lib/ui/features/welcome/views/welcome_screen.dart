import 'package:flutter/material.dart';
import 'package:sarana_gdg_lp/ui/core/theme/app_theme.dart';
import 'package:sarana_gdg_lp/ui/features/main_navigation/views/main_navigation_screen.dart';

/// WelcomeScreen — The onboarding/splash screen of the Saraña app.
/// Features a fade+slide entrance animation and the Bolivia-themed branding.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
    ));

    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToMain() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => const MainNavigationScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),

                  // ── Logo ────────────────────────────────────────────
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.forestGreen.withValues(alpha: 0.18),
                            blurRadius: 32,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo_sarana.png',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const _LlamaFallbackIcon(),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ── Brand name ───────────────────────────────────────
                  Text(
                    'Saraña',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 42,
                      fontWeight: FontWeight.w800,
                      color: AppColors.deepBlue,
                      letterSpacing: -1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ── Tagline ──────────────────────────────────────────
                  Text(
                    'Bolivia en tus manos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.warmBeige,
                      letterSpacing: 0.2,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Subtitle ─────────────────────────────────────────
                  Text(
                    'Descubre gastronomía, artesanías, hospedaje y rutas culturales de las comunidades locales bolivianas.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.65,
                    ),
                  ),

                  const SizedBox(height: 56),

                  // ── CTA Button ───────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _navigateToMain,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.warmBeige,
                        foregroundColor: AppColors.deepBlue,
                        elevation: 4,
                        shadowColor: AppColors.warmBeige.withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        textStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Comenzar'),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(flex: 1),

                  // ── Footer ───────────────────────────────────────────
                  Text(
                    'Turismo comunitario boliviano 🦙',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: AppColors.textSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Fallback llama icon rendered if the asset image is unavailable.
class _LlamaFallbackIcon extends StatelessWidget {
  const _LlamaFallbackIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: const Icon(
        Icons.pets_rounded,
        size: 80,
        color: AppColors.forestGreen,
      ),
    );
  }
}

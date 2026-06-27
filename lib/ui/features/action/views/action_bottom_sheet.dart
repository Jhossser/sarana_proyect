import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sarana_gdg_lp/domain/models/business.dart';
import 'package:sarana_gdg_lp/ui/core/theme/app_theme.dart';

/// ActionBottomSheet — Contact and navigation actions for a business.
/// Shows WhatsApp and Google Maps buttons.
class ActionBottomSheet extends StatelessWidget {
  const ActionBottomSheet({super.key, required this.business});

  final Business business;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Handle bar ───────────────────────────────────────────
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 24),

            // ── Header ───────────────────────────────────────────────
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.deepBlue.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.store_rounded,
                    color: AppColors.deepBlue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        business.name,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.deepBlue,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        business.city,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Divider(color: AppColors.divider),
            const SizedBox(height: 20),

            // ── Title ────────────────────────────────────────────────
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Acciones rápidas',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── WhatsApp button ──────────────────────────────────────
            _ActionButton(
              icon: Icons.chat_rounded,
              label: 'Contactar por WhatsApp',
              sublabel: '+${business.whatsapp}',
              backgroundColor: const Color(0xFF25D366),
              iconColor: Colors.white,
              labelColor: Colors.white,
              onTap: () => _launchWhatsApp(
                context,
                business.whatsapp,
                '¡Hola! Vi tu negocio "${business.name}" en Saraña y me gustaría obtener más información. 🦙',
              ),
            ),

            const SizedBox(height: 12),

            // ── Maps button ──────────────────────────────────────────
            _ActionButton(
              icon: Icons.map_rounded,
              label: 'Cómo llegar',
              sublabel: business.location,
              backgroundColor: AppColors.deepBlue,
              iconColor: AppColors.warmBeige,
              labelColor: AppColors.white,
              onTap: () => _launchMaps(
                context,
                business.latitude,
                business.longitude,
                business.name,
              ),
            ),

            const SizedBox(height: 12),

            // ── Phone button ─────────────────────────────────────────
            _ActionButton(
              icon: Icons.call_rounded,
              label: 'Llamar',
              sublabel: business.phone,
              backgroundColor: AppColors.background,
              iconColor: AppColors.forestGreen,
              labelColor: AppColors.deepBlue,
              onTap: () => _launchPhone(context, business.phone),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchWhatsApp(
      BuildContext context, String phone, String message) async {
    final uri = Uri.parse(
        'https://wa.me/$phone?text=${Uri.encodeComponent(message)}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se pudo abrir WhatsApp'),
            backgroundColor: AppColors.deepBlue,
          ),
        );
      }
    }
  }

  Future<void> _launchMaps(
      BuildContext context, double lat, double lng, String name) async {
    final uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se pudo abrir Google Maps'),
            backgroundColor: AppColors.deepBlue,
          ),
        );
      }
    }
  }

  Future<void> _launchPhone(BuildContext context, String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se pudo realizar la llamada'),
            backgroundColor: AppColors.deepBlue,
          ),
        );
      }
    }
  }
}

/// Reusable action button row for the bottom sheet.
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.backgroundColor,
    required this.iconColor,
    required this.labelColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String sublabel;
  final Color backgroundColor;
  final Color iconColor;
  final Color labelColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18),
          border: backgroundColor == AppColors.background
              ? Border.all(color: AppColors.divider)
              : null,
          boxShadow: backgroundColor != AppColors.background
              ? [
                  BoxShadow(
                    color: backgroundColor.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: labelColor,
                    ),
                  ),
                  Text(
                    sublabel,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: labelColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: labelColor.withValues(alpha: 0.6),
            ),
          ],
        ),
      ),
    );
  }
}

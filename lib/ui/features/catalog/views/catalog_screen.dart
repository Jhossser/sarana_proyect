import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarana_gdg_lp/data/repositories/business_repository.dart';
import 'package:sarana_gdg_lp/domain/models/business.dart';
import 'package:sarana_gdg_lp/ui/core/theme/app_theme.dart';
import 'package:sarana_gdg_lp/ui/core/widgets/business_card_widget.dart';
import 'package:sarana_gdg_lp/ui/core/widgets/category_chip_widget.dart';
import 'package:sarana_gdg_lp/ui/features/business_detail/view_models/business_detail_view_model.dart';
import 'package:sarana_gdg_lp/ui/features/business_detail/views/business_detail_screen.dart';
import 'package:sarana_gdg_lp/ui/features/catalog/view_models/catalog_view_model.dart';

/// CatalogScreen — Main discovery screen with horizontal category sections.
class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: context.watch<CatalogViewModel>(),
      builder: (context, _) {
        final vm = context.read<CatalogViewModel>();
        final businessesMap = vm.businessesByCategory;

        return CustomScrollView(
          slivers: [
            // ── App bar ─────────────────────────────────────────────
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: AppColors.deepBlue,
              expandedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 20, bottom: 12),
                title: Row(
                  children: [
                    const Icon(Icons.explore_rounded,
                        color: AppColors.warmBeige, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'Saraña',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '🦙',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.search_rounded,
                        color: AppColors.white, size: 22),
                  ),
                ),
              ],
            ),

            // ── Header text ─────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Descubre Bolivia',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: AppColors.deepBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Turismo comunitario auténtico',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Category chips ──────────────────────────────────────
            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: vm.categories.length,
                  itemBuilder: (_, i) {
                    final cat = vm.categories[i];
                    return CategoryChipWidget(
                      category: cat,
                      isSelected: vm.selectedCategoryId == cat.id,
                      onTap: () => vm.selectCategory(cat.id),
                    );
                  },
                ),
              ),
            ),

            // ── Sections for all 4 categories ───────────────────────
            for (final category in vm.categories)
              ..._buildCategorySection(
                context,
                categoryName: category.name,
                emoji: category.emoji,
                businesses: businessesMap[category.id] ?? [],
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        );
      },
    );
  }

  List<Widget> _buildCategorySection(
    BuildContext context, {
    required String categoryName,
    required String emoji,
    required List<Business> businesses,
  }) {
    return [
      // Section header
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.forestGreen.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                categoryName,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepBlue,
                ),
              ),
              const Spacer(),
              Text(
                'Ver todo',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.forestGreen,
                ),
              ),
            ],
          ),
        ),
      ),

      // Horizontal card list
      SliverToBoxAdapter(
        child: SizedBox(
          height: 276,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, bottom: 16),
            itemCount: businesses.length,
            itemBuilder: (_, i) {
              final biz = businesses[i];
              return BusinessCardWidget(
                business: biz,
                onTap: () => _openDetail(context, biz),
              );
            },
          ),
        ),
      ),
    ];
  }

  void _openDetail(BuildContext context, Business business) {
    final repo = context.read<BusinessRepository>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => BusinessDetailViewModel(
            businessRepository: repo,
            businessId: business.id,
          ),
          child: const BusinessDetailScreen(),
        ),
      ),
    );
  }
}

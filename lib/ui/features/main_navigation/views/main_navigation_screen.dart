import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarana_gdg_lp/data/repositories/business_repository.dart';
import 'package:sarana_gdg_lp/data/repositories/chat_repository.dart';
import 'package:sarana_gdg_lp/ui/core/theme/app_theme.dart';
import 'package:sarana_gdg_lp/ui/features/catalog/view_models/catalog_view_model.dart';
import 'package:sarana_gdg_lp/ui/features/catalog/views/catalog_screen.dart';
import 'package:sarana_gdg_lp/ui/features/chat/view_models/chat_view_model.dart';
import 'package:sarana_gdg_lp/ui/features/chat/views/ai_chat_screen.dart';

/// MainNavigationScreen — bottom nav shell for catalog and chat tabs.
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final businessRepository = context.read<BusinessRepository>();
    final chatRepository = context.read<ChatRepository>();

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Tab 0 — Catalog
          ChangeNotifierProvider(
            create: (_) =>
                CatalogViewModel(businessRepository: businessRepository),
            child: const CatalogScreen(),
          ),
          // Tab 1 — AI Chat
          ChangeNotifierProvider(
            create: (_) => ChatViewModel(chatRepository: chatRepository),
            child: const AiChatScreen(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (idx) => setState(() => _currentIndex = idx),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore_rounded),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            activeIcon: Icon(Icons.chat_bubble_rounded),
            label: 'Sara IA',
          ),
        ],
      ),
    );
  }
}

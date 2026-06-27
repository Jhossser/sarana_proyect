import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sarana_gdg_lp/data/repositories/business_repository.dart';
import 'package:sarana_gdg_lp/data/repositories/chat_repository.dart';
import 'package:sarana_gdg_lp/data/services/ai_chat_service.dart';
import 'package:sarana_gdg_lp/data/services/business_service.dart';
import 'package:sarana_gdg_lp/ui/core/theme/app_theme.dart';
import 'package:sarana_gdg_lp/ui/features/welcome/views/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait orientation for a consistent mobile experience
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Style the system status bar to blend with the app's deep blue theme
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const SaranaApp());
}

/// Root widget of the Saraña application.
/// Sets up the dependency injection tree using Provider.
class SaranaApp extends StatelessWidget {
  const SaranaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ── Services ──────────────────────────────────────────────
        Provider<BusinessService>(
          create: (_) => BusinessService(),
        ),
        Provider<AiChatService>(
          create: (_) => AiChatService(),
        ),

        // ── Repositories ──────────────────────────────────────────
        ProxyProvider<BusinessService, BusinessRepository>(
          update: (_, service, __) =>
              BusinessRepository(businessService: service),
        ),
        ProxyProvider<AiChatService, ChatRepository>(
          update: (_, service, __) =>
              ChatRepository(chatService: service),
        ),
      ],
      child: MaterialApp(
        title: 'Saraña',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const WelcomeScreen(),
      ),
    );
  }
}

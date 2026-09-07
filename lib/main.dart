import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'repositories/mock_product_repository.dart';
import 'providers/marketplace_provider.dart';
import 'providers/checkout_provider.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OneFiApp());
}

class OneFiApp extends StatelessWidget {
  const OneFiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Shared mock repository instance
    final productRepository = MockProductRepository();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MarketplaceProvider(repository: productRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => CheckoutProvider(),
        ),
      ],
      child: MaterialApp(
        title: '1Fi Marketplace',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MainNavigationScreen(initialTabIndex: 1),
      ),
    );
  }
}

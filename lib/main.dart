import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'services/mock_api_service.dart';
import 'repositories/network_repository.dart';
import 'repositories/auth_repository.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/network_viewmodel.dart';
import 'viewmodels/settings_viewmodel.dart';
import 'views/auth/login_screen.dart';

void main() {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NetGuardApp());
}

/// The root widget of the NetGuard Mobile application.
/// It sets up the dependency injection using Provider and configures the theme.
class NetGuardApp extends StatelessWidget {
  const NetGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Services
    final mockApiService = MockApiService();

    // Repositories
    final authRepository = AuthRepository();
    final networkRepository = NetworkRepository(mockApiService);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(authRepository)),
        ChangeNotifierProvider(create: (_) => NetworkViewModel(networkRepository)),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
      ],
      child: Consumer<SettingsViewModel>(
        builder: (context, settings, child) {
          return MaterialApp(
            title: 'NetGuard Mobile',
            debugShowCheckedModeBanner: false,
            themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.blue,
              brightness: Brightness.light,
              textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.blue,
              brightness: Brightness.dark,
              textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
            ),
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}

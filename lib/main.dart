import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:batterymonitor/ui/theme/theme.dart';
import 'package:batterymonitor/state/appState.dart';
import 'package:batterymonitor/state/authState.dart';
import 'package:batterymonitor/navigator/routes.dart';
import 'package:batterymonitor/ui/pages/common/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupDependencies();
  runApp(const HeartRateMonitor());
}

class HeartRateMonitor extends StatelessWidget {
  const HeartRateMonitor({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
      ],
      child: MaterialApp(
        title: 'Battery Monitor',
        theme: AppTheme.appTheme.copyWith(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routes: Routes.route(),
        initialRoute: "SplashPage",
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
        onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
      ),
    );
  }
}

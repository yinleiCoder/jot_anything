import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/utils/utils.dart';
import 'common/values/prefs_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = true;

  final prefs = await SharedPreferences.getInstance();
  PrefsService.init(prefs);
  if (PrefsService.instance.getBool(PrefsKeys.welcomeShown)) {
    markWelcomeShown();
  }

  runApp(const JotAnythingApp());
}

/// Root application widget.
class JotAnythingApp extends StatelessWidget {
  const JotAnythingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: '记到起',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.notoSansScTextTheme(),
        ),
      ),
    );
  }
}

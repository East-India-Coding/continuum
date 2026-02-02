import 'dart:async';

import 'package:continuum/configure_nonweb.dart'
    if (dart.library.html) 'configure_web.dart';
import 'package:continuum/firebase_options.dart';
import 'package:continuum/presentation/utils/continuum_colors.dart';
import 'package:continuum/routing/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      configureApp();

      runApp(const ProviderScope(child: MainApp()));

      FlutterError.onError = (details) {
        FlutterError.presentError(details);
      };
      ErrorWidget.builder = (details) {
        return Scaffold(body: Center(child: Text(details.exceptionAsString())));
      };
    },
    (error, stack) {
      debugPrint(error.toString());
    },
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'Continuum',
      theme: ThemeData(
        textTheme: GoogleFonts.orbitronTextTheme(),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ContinuumColors.primary,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

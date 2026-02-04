import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:continuum_client/continuum_client.dart';
import 'package:continuum_flutter/application/serverpod_client.dart';

import 'package:continuum_flutter/configure_nonweb.dart'
    if (dart.library.html) 'configure_web.dart';
import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';
import 'package:continuum_flutter/routing/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final serverUrl = await getServerUrl();

      final client = Client(serverUrl)
        ..connectivityMonitor = FlutterConnectivityMonitor()
        ..authSessionManager = FlutterAuthSessionManager();
      configureApp();

      client.auth.initialize();
      client.auth.initializeGoogleSignIn();

      runApp(
        ProviderScope(
          overrides: [
            serverpodClientProvider.overrideWithValue(client),
          ],
          child: const MainApp(),
        ),
      );

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
      };
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return Scaffold(
          body: Center(child: Text(details.exceptionAsString())),
        );
      };
    },
    (Object error, StackTrace stack) {
      // * Log any errors to console
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

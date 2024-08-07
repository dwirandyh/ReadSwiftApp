import 'package:authentication_api/authentication_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:readswift_app/di/dependency_composition.dart';
import 'package:readswift_app/router/router.dart';
import 'package:uikit/uikit.dart';
import 'package:user/repository/user_setting_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeFirebase();

  DependencyComposition.setup();

  initializeAuthenticatedStatus();

  runApp(
    FutureBuilder(
      future: getThemeData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ThemeManager(
            themeModePreference: snapshot.requireData,
            child: const MyApp(),
          );
        }
        return const CircularProgressIndicator();
      },
    ),
  );
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

void initializeAuthenticatedStatus() {
  final authenticationBloc = GetIt.I.get<AuthenticationBlocAPI>();
  authenticationBloc.add(AuthenticationStatusRequested());
}

Future<ThemeModePreference> getThemeData() async {
  await GetIt.I.isReady<UserSettingRepository>();
  final userSettings = GetIt.I.get<UserSettingRepository>();
  final themeMode = userSettings.getCurrentThemeMode();
  return themeMode;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I.get<AuthenticationBlocAPI>()
        ..add(AuthenticationStatusRequested()),
      child: MaterialApp.router(
        title: 'ReadSwift',
        theme: ThemeProvider.of(context).themeData,
        routerConfig: appRouter,
      ),
    );
  }
}

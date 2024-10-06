import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => AuthProvider()),
    //     ChangeNotifierProvider(create: (_) => AirtimeProvider()),
    //     ChangeNotifierProvider(create: (_) => MobileDataProvider()),
    //     ChangeNotifierProvider(create: (_) => CableTvProvider()),
    //     ChangeNotifierProvider(create: (_) => TransactionProvider()),
    //     ChangeNotifierProvider(create: (_) => BankTransferProvider()),
    //   ],
    //   child: const MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: AppTheming.darkThemeData,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

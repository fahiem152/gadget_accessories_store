import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:projecttas_223200007/data/datasources/local_datasource/setup_loca.dart';
import 'package:projecttas_223200007/firebase_options.dart';
import 'package:projecttas_223200007/pages/auth/login_page.dart';
import 'package:projecttas_223200007/shared/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SetupLocalDataSource.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // home: BottomNav(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_system/constant/bloc_provider.dart';
import 'package:hr_system/firebase_options.dart';
import 'package:hr_system/view/authentication/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    );
  }
}

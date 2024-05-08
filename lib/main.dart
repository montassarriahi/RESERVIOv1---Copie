import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserviov1/BlocObserver.dart';

import 'package:reserviov1/logic/AuthLogin/AuthLogin_bloc.dart';
import 'package:reserviov1/logic/Request/Request_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:reserviov1/widgets/firebase_options.dart';

import 'screens/onboarding/onboarding_1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthLoginBloc(),
          ),
          BlocProvider(
            create: (context) => RequestBloc(),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.highContrastLight(
              
            ),
            appBarTheme: const AppBarTheme(scrolledUnderElevation: 0),
          ),
          debugShowCheckedModeBanner: false,
          home: OnboardingOne(),
        ));
  }
}

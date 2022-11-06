// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_ram/state/auth/models/auth_results.dart';
import 'package:instagram_clone_ram/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_ram/state/auth/providers/is_logged_in_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: isLoggedIn ? const LoginView() : const Home(),
    );
  }
}

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  @override
  Widget build(BuildContext context) {
    final autprovider = ref.read(authStateProvider.notifier);

    return Container(
      child: Center(
        child: TextButton(
          child: const Text('logout'),
          onPressed: (() async {
            await autprovider.logOut();
          }),
        ),
      ),
    );
  }
}

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(children: [
          TextButton(
              onPressed: () async {
                await ref.read(authStateProvider.notifier).loginWithGoogle();
              },
              child: Text('login with Google'))
        ]),
      ),
    );
  }
}

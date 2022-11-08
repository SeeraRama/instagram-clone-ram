// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_ram/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_ram/state/auth/providers/is_loading_provider.dart';
import 'package:instagram_clone_ram/state/auth/providers/is_logged_in_provider.dart';
import 'package:instagram_clone_ram/views/components/loading/loading_screen.dart';
import 'package:instagram_clone_ram/views/login/divider_with_margins.dart';
import 'package:instagram_clone_ram/views/login/google_button.dart';
import 'package:instagram_clone_ram/views/login/login_view.dart';
import 'package:instagram_clone_ram/views/login/login_view_signup_links.dart';
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
        home: Consumer(
          builder: (context, ref, child) {
            ref.listen(isloadingProvider, (_, next) {
              if (next) {
                LoadingScreen.instance()
                    .show(context: context, text: 'Logging in....');
              } else {
                LoadingScreen.instance().hide();
              }
            });
            if (isLoggedIn) {
              return const Home();
            } else {
              return const LoginView();
            }
            // isLoggedIn ? const LoginView() : const Home();
          },
        ));
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
    final autprovider = ref.read(authStateProvider.notifier);

    return Center(
      child: TextButton(
        onPressed: (() async {
          await autprovider.logOut();
        }),
        child: const Text('logout'),
      ),
    );
  }
}
/*
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
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                await ref.read(authStateProvider.notifier).loginWithGoogle();
              },
              child: const Text('login with Google'),
            ),
            const DividerWithMargins(),
            const GoogleButton(),
            const LoginViewSignupLinks(),
          ],
        ),
      ),
    );
  }
}
*/
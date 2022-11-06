import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_ram/state/auth/models/auth_state.dart';
import 'package:instagram_clone_ram/state/notifiers/auth_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    ((ref) => AuthStateNotifier()));

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_ram/state/auth/providers/auth_state_provider.dart';

final userIdProvider = Provider(((ref) {
  final authProvider = ref.watch(authStateProvider);

  return authProvider.userId;
}));

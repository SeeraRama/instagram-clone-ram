import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_ram/state/auth/providers/auth_state_provider.dart';

final isloadingProvider = Provider<bool>(((ref) {
  final authprovider = ref.watch(authStateProvider);

  return authprovider.isLoading;
}));

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_ram/state/auth/backend/authenticator.dart';
import 'package:instagram_clone_ram/state/auth/models/auth_results.dart';
import 'package:instagram_clone_ram/state/auth/models/auth_state.dart';
import 'package:instagram_clone_ram/state/posts/typedefs/user_id.dart';
import 'package:instagram_clone_ram/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authnticator = const Authenticator();

  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authnticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authnticator.userId,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authnticator.logOut();
    state = const AuthState(
        result: AuthResult.failure, isLoading: false, userId: null);
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);

    final result = await _authnticator.loginGoogle();
    final userId = _authnticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> saveUserInfo({required UserId userId}) async {
    await _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authnticator.displayName,
        email: _authnticator.email);
  }
}

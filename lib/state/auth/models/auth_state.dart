import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_ram/state/auth/models/auth_results.dart';
import 'package:instagram_clone_ram/state/posts/typedefs/user_id.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

// constant constructor for unknow state
  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;

  AuthState copiedWithIsLoading(bool isLoading) => AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (other.result == result &&
          other.isLoading == isLoading &&
          other.userId == userId);

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(
        isLoading,
        result,
        userId,
      );
}

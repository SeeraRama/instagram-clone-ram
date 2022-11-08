import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone_ram/state/auth/models/auth_results.dart';
import 'package:instagram_clone_ram/state/constatnts/constants.dart';
import 'package:instagram_clone_ram/state/posts/typedefs/user_id.dart';

class Authenticator {
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;

  bool get isAlreadyLoggedIn => userId != null;

  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';

  String? get email => FirebaseAuth.instance.currentUser?.email ?? '';

  const Authenticator();

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResult> loginGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [Constants.emailScope],
    );
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    } else {
      final googleauth = await signInAccount.authentication;
      final authCredentials = GoogleAuthProvider.credential(
        accessToken: googleauth.accessToken,
        idToken: googleauth.idToken,
      );

      try {
        await FirebaseAuth.instance.signInWithCredential(
          authCredentials,
        );
        return AuthResult.success;
      } catch (e) {
        return AuthResult.failure;
      }
    }
  }
}

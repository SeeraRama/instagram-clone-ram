import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:instagram_clone_ram/state/constants/firebase_fields.dart';
import 'package:instagram_clone_ram/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName ?? '',
          FirebaseFieldName.email: email ?? '',
        });
}

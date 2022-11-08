import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:instagram_clone_ram/views/components/rich_text/base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTapped;

  const LinkText({
    required super.text,
    super.style,
    required this.onTapped,
  });
}

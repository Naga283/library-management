import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReturnBooks extends ConsumerWidget {
  const ReturnBooks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Text("Return books"),
    );
  }
}

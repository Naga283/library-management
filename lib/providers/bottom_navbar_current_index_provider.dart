import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndexStateProvider = StateProvider<int>((ref) {
  return 0;
});

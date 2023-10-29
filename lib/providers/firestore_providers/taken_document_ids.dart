import 'package:flutter_riverpod/flutter_riverpod.dart';

final takenDocumentIdStateProvider =
    StateProvider.autoDispose<List<String>>((ref) {
  return [];
});

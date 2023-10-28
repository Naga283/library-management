import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/modals/get_book_details.dart';
import 'package:library_books_management/notifiers/get_books_details_notifiers.dart';

final getDetailsFutureProvider = FutureProvider<GetBookDetails>((ref) async {
  return ref.watch(getBookDetailsProvider).getDetails();
});

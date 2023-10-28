import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:library_books_management/modals/get_book_details.dart';
import 'package:library_books_management/utils/apis.dart';

class GetBooksDetailsNotifier {
  Future<GetBookDetails> getDetails() async {
    try {
      final response = await http.get(Uri.parse(apis.apiUrl));
      final jsonVal = json.decode(response.body);
      return GetBookDetails.fromJson(jsonVal);
    } catch (e, sT) {
      print("Error" + e.toString());
      print("stach trace" + sT.toString());
      throw Exception(e);
    }
  }
}

final getBookDetailsProvider = Provider<GetBooksDetailsNotifier>((ref) {
  return GetBooksDetailsNotifier();
});

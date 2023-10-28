import 'package:library_books_management/modals/reading_log.dart';

class GetBookDetails {
  int page;
  List<ReadingLogEntry> readingLogEntries;

  GetBookDetails({
    required this.page,
    required this.readingLogEntries,
  });

  factory GetBookDetails.fromJson(Map<String, dynamic> json) => GetBookDetails(
        page: json["page"],
        readingLogEntries: List<ReadingLogEntry>.from(
            json["reading_log_entries"]
                .map((x) => ReadingLogEntry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "reading_log_entries":
            List<dynamic>.from(readingLogEntries.map((x) => x.toJson())),
      };
}

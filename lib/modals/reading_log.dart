import 'package:library_books_management/modals/work.dart';

class ReadingLogEntry {
  Work? work;
  String? loggedEdition;
  String loggedDate;

  ReadingLogEntry({
    this.work,
    this.loggedEdition,
    required this.loggedDate,
  });

  factory ReadingLogEntry.fromJson(Map<String, dynamic> json) {
    return ReadingLogEntry(
      work: Work?.fromJson(json["work"]),
      loggedEdition: json["logged_edition"],
      loggedDate: json["logged_date"],
    );
  }

  Map<String, dynamic> toJson() => {
        "work": work?.toJson(),
        "logged_edition": loggedEdition,
        "logged_date": loggedDate,
      };
}

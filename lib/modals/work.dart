class Work {
  String? title;
  String? key;
  List<String>? authorKeys;
  List<String>? authorNames;
  int? firstPublishYear;
  String? lendingEditionS;
  List<dynamic>? editionKey;
  int? coverId;
  String? coverEditionKey;

  Work({
    this.title,
    this.key,
    this.authorKeys,
    this.authorNames,
    this.firstPublishYear,
    this.lendingEditionS,
    this.editionKey,
    this.coverId,
    this.coverEditionKey,
  });

  factory Work.fromJson(Map<String, dynamic> json) => Work(
        title: json["title"],
        key: json["key"],
        authorKeys: List<String>.from(json["author_keys"].map((x) => x)),
        authorNames: List<String>.from(json["author_names"].map((x) => x)),
        firstPublishYear: json["first_publish_year"],
        lendingEditionS: json["lending_edition_s"] ?? '',
        // editionKey: List<dynamic>.from(json["edition_key"].map((x) => x)),
        coverId: json["cover_id"],
        coverEditionKey: json["cover_edition_key"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "key": key,
        "author_keys": List<dynamic>.from(authorKeys?.map((x) => x) ?? {}),
        "author_names": List<dynamic>.from(authorNames?.map((x) => x) ?? {}),
        "first_publish_year": firstPublishYear,
        "lending_edition_s": lendingEditionS,
        "edition_key": List<dynamic>.from(editionKey?.map((x) => x) ?? {}),
        "cover_id": coverId,
        "cover_edition_key": coverEditionKey,
      };
}

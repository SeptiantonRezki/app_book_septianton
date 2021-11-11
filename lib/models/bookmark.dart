class Bookmark {
  int idBookmark;
  String title;
  String description;
  Bookmark({
    required this.idBookmark,
    required this.description,
    required this.title,
  });
  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      idBookmark: json["id_bookmark"],
      title: json["title"],
      description: json["description"],
    );
  }
  factory Bookmark.initial() {
    return Bookmark(
      idBookmark: 0,
      title: "",
      description: "",
    );
  }
}

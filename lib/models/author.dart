class Author {
  String name;
  int books;
  Author({required this.name, required this.books});
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json["author"] ?? "unknow",
      books: json["books"] ?? 0,
    );
  }
  factory Author.initial() {
    return Author(
      name: "unknow",
      books: 0,
    );
  }
}

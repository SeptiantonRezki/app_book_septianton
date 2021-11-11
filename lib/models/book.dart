class Book {
  int id;
  String author;
  String country;
  String imageLink;
  String language;
  String link;
  int pages;
  String title;
  String year;
  Book({
    required this.id,
    required this.author,
    required this.country,
    required this.imageLink,
    required this.language,
    required this.link,
    required this.pages,
    required this.title,
    required this.year,
  });
  factory Book.fromJson(Map<String, dynamic> json) {
    String year;
    if (json["year"].runtimeType == int) {
      year = json["year"].toString();
    } else {
      year = json["year"];
    }

    return Book(
      id: json["id"],
      author: json["author"],
      country: json["country"],
      imageLink: json["image_link"],
      language: json["language"],
      link: json["link"],
      pages: json["pages"],
      title: json["title"],
      year: year,
    );
  }
  factory Book.initial() {
    return Book(
      id: 0,
      author: "",
      country: "",
      imageLink: "",
      language: "",
      link: "",
      pages: 0,
      title: "",
      year: "",
    );
  }
}

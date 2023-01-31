class Note {
  int id;
  Author author;
  String title;
  String note;
  Note(
    this.id,
    this.author,
    this.title,
    this.note,
  );
  factory Note.fromJson(Map json) {
    return Note(
      json["id"],
      Author.fromJson(json["author"]),
      json["title"],
      json["note"],
    );
  }
  Map<String, String> toJson() {
    return {
      "id": "$id",
      "author": "${author.id}",
      "title": title,
      "note": note,
    };
  }
}

class Author {
  int id;
  String nickname;
  String? profile_picture;
  String email;
  Author(
    this.id,
    this.nickname,
    this.profile_picture,
    this.email,
  );
  factory Author.fromJson(Map json) {
    return Author(
      json["id"],
      json["nickname"],
      json["profile_picture"],
      json["email"],
    );
  }
}

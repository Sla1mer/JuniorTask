class Post {
  int? id;
  String? title;
  String? body;

  Post(this.title, this.body);

  Post.id(this.id, this.title, this.body);

  Post.clear();

  postMap() {
    var mapping = <String, dynamic>{};
    mapping["id"] = id;
    mapping["title"] = title;
    mapping["body"] = body;

    return mapping;
  }
}
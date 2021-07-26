class Comment {
  int? id;
  int? postId;
  String? text;

  Comment(this.postId, this.text);

  Comment.id(this.id, this.postId, this.text);

  Comment.clear();

  commentMap() {
    var mapping = <String, dynamic>{};
    mapping["id"] = id;
    mapping["postId"] = postId;
    mapping["text"] = text;

    return mapping;
  }
}
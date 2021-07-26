import 'package:junior_front_end_development/Models/comment.dart';
import 'package:junior_front_end_development/Models/post.dart';
import 'package:junior_front_end_development/Repository/repository.dart';

class CommentService {
  late Repository _repository;

  CommentService() {
    _repository = Repository();
  }

  // Создание комментария
  createComment(Comment comment) async {
    return await _repository.insertData("comments", comment.commentMap());
  }

  // Получить все комментарии
  readComment() async {
    return await _repository.readData("comments");
  }

  // Удалить комментарий
  deleteComment(commentId) async {
    return await _repository.deleteData("comments", commentId);
  }

  // Обновить комментарий
  updateComment(Comment comment) async {
    return await _repository.updateData("comments", comment.commentMap());
  }

  // Получить коментарии к определённому посту
  readCommentById(postId) async {
    return await _repository.readDataById("comments", postId);
  }
}
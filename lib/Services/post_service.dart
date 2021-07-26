import 'package:junior_front_end_development/Models/post.dart';
import 'package:junior_front_end_development/Repository/repository.dart';

class PostService {
  late Repository _repository;

  PostService() {
    _repository = Repository();
  }

  // Создание поста
  createPost(Post post) async {
    return await _repository.insertData("posts", post.postMap());
  }

  // Получить все посты
  readPost() async {
   return await _repository.readData("posts");
  }

  // Удалить пост
  deletePost(postId) async {
    return await _repository.deleteData("posts", postId);
  }

  // Обновить пост
  updatePost(Post post) async {
    return await _repository.updateData("posts", post.postMap());
  }
}
import 'package:flutter/material.dart';
import 'package:junior_front_end_development/Models/post.dart';
import 'package:junior_front_end_development/Services/post_service.dart';
import 'package:junior_front_end_development/Widgets/post_item.dart';

import 'full_post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _postService = PostService();
  List<Post> _postsList = <Post>[];

  @override
  void initState() {
    getAllPosts();
  }

  getAllPosts() async {
    var posts = await _postService.readPost();

    List<Post> _postsListNew = <Post>[];

    posts.forEach((post) {
      setState(() {
        var postModel = Post.id(post["id"], post["title"], post["body"]);
        _postsListNew.add(postModel);
      });
    });

    setState(() {
      _postsList = _postsListNew;
    });
  }

  var _postTitleController = TextEditingController();
  var _postBodyController = TextEditingController();

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _postBodyController.clear();
                    _postTitleController.clear();
                  },
                  child: Text("Отменить")),
              TextButton(
                  onPressed: () async {
                    var _createdPost = Post(
                        _postTitleController.text, _postBodyController.text);

                    var result = await _postService.createPost(_createdPost);
                    print(result);

                    getAllPosts();

                    Navigator.pop(context);
                    _postBodyController.clear();
                    _postTitleController.clear();
                  },
                  child: Text("Сохранить"))
            ],
            title: Text("Добавления поста"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _postTitleController,
                    decoration: InputDecoration(
                      hintText: "Введите заголовок поста",
                      labelText: "Заголовок",
                    ),
                  ),
                  TextField(
                    controller: _postBodyController,
                    decoration: InputDecoration(
                      hintText: "Введите описание поста",
                      labelText: "Описание",
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JuniorTask"),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Center(
            child: ListView.builder(
                itemCount: _postsList.length,
                itemBuilder: (context, index) {
                  return PostItem(
                    post: _postsList[index],
                    getAllPost: () {
                      getAllPosts();
                    },
                    postService: _postService,
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

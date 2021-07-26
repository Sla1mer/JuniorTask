import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junior_front_end_development/Models/comment.dart';
import 'package:junior_front_end_development/Models/post.dart';
import 'package:junior_front_end_development/Services/comment_service.dart';
import 'package:junior_front_end_development/Widgets/comment_item.dart';

class FullPostPage extends StatefulWidget {
  late Post post;

  FullPostPage({Key? key, required this.post}) : super(key: key);

  @override
  _FullPostPageState createState() => _FullPostPageState();
}

class _FullPostPageState extends State<FullPostPage> {
  var _postCommentController = TextEditingController();


  var _commentService = CommentService();

  List<Comment> _commentsList = <Comment>[];

  getAllCommentById() async {
    var comments = await _commentService.readCommentById(widget.post.id);

    List<Comment> _commentsListNew = <Comment>[];

    comments.forEach((comment) {
      setState(() {
        var commentModel = Comment.id(comment["id"], comment["postId"], comment["text"]);
        _commentsListNew.add(commentModel);
      });
    });

    setState(() {
      _commentsList = _commentsListNew;
    });
  }


  @override
  void initState() {
    getAllCommentById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JuniorTask"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 30, 30),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              child: Container(
                child: Text(
                  widget.post.title!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              ),
              alignment: Alignment.topLeft,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    widget.post.body!,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )),
            ),
            Container(
              color: Colors.black,
              width: double.infinity,
              height: 1,
              margin: EdgeInsets.only(bottom: 10),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _postCommentController,
                    decoration: InputDecoration(
                      hintText: "Введите комментарий",
                      labelText: "Коментарий",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 20,
                  onPressed: () async {
                    _commentService.createComment(Comment(widget.post.id, _postCommentController.text));
                    _postCommentController.clear();
                    getAllCommentById();
                  },
                ),
              ],
            ),
            Expanded(child: Container(
              margin: EdgeInsets.only(top: 30),
              child: ListView.builder(
                itemCount: _commentsList.length,
                itemBuilder: (context, index) {
                  return CommentItem(
                      commentService: _commentService,
                      comment: _commentsList[index],
                      getAllCommentById: () {
                        getAllCommentById();
                      },
                  );
                },
              ),
            ),)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junior_front_end_development/Models/post.dart';
import 'package:junior_front_end_development/Pages/full_post.dart';
import 'package:junior_front_end_development/Pages/main.dart';
import 'package:junior_front_end_development/Services/post_service.dart';

class PostItem extends StatefulWidget {
  PostItem({Key? key, required this.post, this.postService, this.getAllPost})
      : super(key: key);

  Post? post;
  PostService? postService;
  Function? getAllPost;

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  var _isEdit = false;
  var _postTitleController = TextEditingController();
  var _postBodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!_isEdit) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FullPostPage(post: widget.post!)),
          );
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                child: Container(
                  child: Text(
                    widget.post!.title!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                ),
                alignment: Alignment.topLeft,
              ),
              Container(
                color: Colors.black,
                width: double.infinity,
                height: 1,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      widget.post!.body!,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: 20,
                    onPressed: () {
                      setState(() {
                        _isEdit = !_isEdit;
                        _postTitleController.text = widget.post!.title!;
                        _postBodyController.text = widget.post!.body!;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    iconSize: 20,
                    onPressed: () async {
                      setState(() {
                        widget.postService!.deletePost(widget.post!.id);
                        widget.getAllPost!();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ]),
        ),
      );
    }

    // Если надо редактировать карточку
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            child: Container(
              child: TextField(
                controller: _postTitleController,
                decoration: InputDecoration(
                  labelText: "Заголовок",
                ),
              ),
              margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
            ),
            alignment: Alignment.topLeft,
          ),
          Container(
            color: Colors.black,
            width: double.infinity,
            height: 1,
          ),
          Align(
            child: Container(
              child: TextField(
                controller: _postBodyController,
                decoration: InputDecoration(
                  labelText: "Описание",
                ),
              ),
              margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
            ),
            alignment: Alignment.topLeft,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.save),
                iconSize: 20,
                onPressed: () async {
                  setState(() {
                    widget.post!.body = _postBodyController.text;
                    widget.post!.title = _postTitleController.text;

                    widget.postService!.updatePost(widget.post!);
                    widget.getAllPost!();
                    _isEdit = !_isEdit;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                iconSize: 20,
                onPressed: () async {
                  setState(() {
                    widget.postService!.deletePost(widget.post!.id);
                    widget.getAllPost!();
                  });
                },
              ),
            ],
          ),
        ],
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ]),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junior_front_end_development/Models/comment.dart';
import 'package:junior_front_end_development/Services/comment_service.dart';

class CommentItem extends StatefulWidget {
  Comment comment;
  CommentService commentService;
  Function? getAllCommentById;

  CommentItem({Key? key, required this.commentService, required this.comment, required this.getAllCommentById}) : super(key: key);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {

  var _isEdit = false;
  var _commentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!_isEdit) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 15),
        child: Column(
          children: [
            Container(
              child: Text(widget.comment.text!),
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  iconSize: 20,
                  onPressed: () {
                    setState(() {
                      _commentTextController.text = widget.comment.text!;
                      _isEdit = !_isEdit;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  iconSize: 20,
                  onPressed: () async {
                    setState(() {
                      widget.commentService.deleteComment(widget.comment.id);
                      widget.getAllCommentById!();
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
              )
            ]
        ),
      );
    }

    // В режиме редактирования
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: [
          Container(
            child: Align(
              child: Container(
                child: TextField(
                  controller: _commentTextController,
                  decoration: InputDecoration(
                    labelText: "Комментарий",
                  ),
                ),
                margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
              ),
              alignment: Alignment.topLeft,
            ),
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.save),
                iconSize: 20,
                onPressed: () {
                  setState(() {
                    widget.comment.text = _commentTextController.text;
                    widget.commentService.updateComment(widget.comment);
                    widget.getAllCommentById!();
                    _isEdit = !_isEdit;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.cancel),
                iconSize: 20,
                onPressed: () async {
                  setState(() {
                    _isEdit = !_isEdit;
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
            )
          ]
      ),
    );
  }
}
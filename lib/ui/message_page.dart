import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:after_layout/after_layout.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/data/model/comment.dart';
import 'package:flutter_chat_ui/data/model/image_data_model.dart';
import 'package:flutter_chat_ui/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:toast/toast.dart';
import 'chat_message.dart';

class MessagePage extends StatefulWidget {
  MessagePage();
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with
        TickerProviderStateMixin,
        AfterLayoutMixin,
        AutomaticKeepAliveClientMixin<MessagePage> {
  TextEditingController _textController;
  List<ChatMessage> _messages = <ChatMessage>[];
  List<Comment> comment = [];
  bool _isComposing = false;
  double timestameComment;
  bool isHasText;
  bool isHasComment;
  bool isChooseFile;
  String nameFile = "";
  List<ImageDataModel> base64ImageData = [];
  List<Uint8List> singelImageData = [];
  List<Asset> images = <Asset>[];
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 5,
          enableCamera: false,
          selectedAssets: images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            startInAllView: true,
            selectionLimitReachedText: "Bạn chỉ chọn tối đa được 10 hình",
            actionBarTitleColor: "#18191a",
            actionBarColor: "#64a8ed",
            actionBarTitle: "Chọn hình",
            allViewTitle: "Tất cả hình",
            selectCircleStrokeColor: "#edf0f2",
          ));
    } on PlatformException catch (e, stacktrace) {
      print(e.toString());
    }
    if (!mounted) return;

    // Convert image to byte
    if (resultList.length > 0) {
      base64ImageData = [];
      await Future.microtask(() async {
        for (int i = 0; i < resultList.length; i++) {
          ByteData thumbData = await resultList[i].getThumbByteData(
            (resultList[i].originalWidth * 0.7).toInt(),
            (resultList[i].originalHeight * 0.7).toInt(),
            quality: 60,
          );
          var dataImage = thumbData.buffer.asUint8List();
          singelImageData.add(dataImage);
          var string64 = base64.encode(dataImage);
          ImageDataModel temp = new ImageDataModel();
          temp.fileData = string64;
          List<String> tempDataImage = resultList[i].name.split('.');
          temp.fileExtention = "." + tempDataImage.last;
          base64ImageData.add(temp);
        }
      });
    }

    if (this.mounted) {
      setState(() {
        images = resultList;
      });
    }
  }

  ContentChat checkKindComment(Comment comment) {
    if (comment.url == null || comment.url.length == 0) {
      return ContentChat.text;
    } else {
      if (comment.urlIsImage) {
        return ContentChat.imageLink;
      } else {
        return ContentChat.file;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    isHasComment = false;
    isHasText = false;
    isChooseFile = false;
    timestameComment = 0.0;
    _textController = new TextEditingController();
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Bình luận sự kiện",
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: onrefresh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: isHasComment == false
                    ? Center(
                        child: Text(
                          "Không có bình luận",
                        ),
                      )
                    : ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        addAutomaticKeepAlives: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(8.0),
                        reverse: true,
                        itemBuilder: (_, int index) => _messages[index],
                        itemCount: _messages.length,
                      ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(height: 1.0),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ],
          ),
        ));
  }

  void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
        // setState(() { lastSelectedValue = value; });
      }
    });
  }

  Future handelCamera() async {
    try {
      Navigator.of(context).pop();
      final picker = ImagePicker();
      await picker
          .getImage(source: ImageSource.camera, imageQuality: 70)
          .then((value) async {
        if (value != null) {
          await Future.microtask(() async {
            ImageDataModel imageDataModel = new ImageDataModel();
            base64ImageData = [];
            Uint8List tempImage = await value.readAsBytes();
            imageDataModel.fileData = base64Encode(tempImage);
            imageDataModel.fileExtention = Utils.getExtension(value.path);
            base64ImageData.add(imageDataModel);
          }).then((_) async {
            double timelast = DateTime.now().millisecondsSinceEpoch.toDouble();

            timestameComment = timelast;
            ChatMessage message = ChatMessage(
              typeChat: TypeChat.User,
              contentChat: ContentChat.imageCamera,
              fileChat: File(value.path),
              timecomment: ChangeTime.ChangeTimeStampToTime(
                  DateTime.now().millisecondsSinceEpoch.toDouble() / 1000.0,
                  true,
                  false,
                  false),
              animationController: new AnimationController(
                duration: new Duration(milliseconds: 500),
                vsync: this,
              ),
            );
            _textController.clear();
            _textController.text = '';
            _textController.clearComposing();
            if (!mounted) return;
            setState(() {
              _messages.insert(0, message);
            });
            message.animationController.forward();
            base64ImageData = [];
          });
        } else {
          return Toast.show("Không có hình được chọn", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      });
    } catch (e, stacktrace) {}
  }

  Future handleLibrary() async {
    try {
      Navigator.of(context).pop();
      await loadAssets().then((_) async {
        if (images.length > 0) {
          double timelast = DateTime.now().millisecondsSinceEpoch.toDouble();

          timestameComment = timelast;
          for (Uint8List temp in singelImageData) {
            ChatMessage message = ChatMessage(
              typeChat: TypeChat.User,
              contentChat: ContentChat.imageLibrary,
              fileChat2: temp,
              timecomment: ChangeTime.ChangeTimeStampToTime(
                  DateTime.now().millisecondsSinceEpoch.toDouble() / 1000.0,
                  true,
                  false,
                  false),
              animationController: new AnimationController(
                duration: new Duration(milliseconds: 500),
                vsync: this,
              ),
            );
            _textController.clear();
            _textController.text = '';
            _textController.clearComposing();
            setState(() {
              _messages.insert(0, message);
            });
            message.animationController.forward();
            base64ImageData = [];
          }
        }
      });
    } catch (e, stacktrace) {}
  }

  Future handleFile() async {
    isChooseFile = true;
    try {
      Navigator.of(context).pop();
      FilePickerResult result = await FilePicker.platform.pickFiles();
      File file = File(result.files.first.path);
      if (file != null) {
        if (file.existsSync()) {
          await Future.microtask(() async {
            ImageDataModel imageDataModel = new ImageDataModel();
            base64ImageData = [];
            Uint8List tempImage = file.readAsBytesSync();
            imageDataModel.fileData = base64Encode(tempImage);
            imageDataModel.fileExtention = Utils.getExtension(file.path);
            nameFile = Utils.getNameFile(file.path);
            imageDataModel.fileName = nameFile;
            base64ImageData.add(imageDataModel);
          }).then((_) async {
            double timelast = DateTime.now().millisecondsSinceEpoch.toDouble();
            String extentionFile = Utils.getExtension(file.path);
//            if (Validation.isFormatImage(extentionFile)) {
            if (1 == 1) {
//                timestameComment = timelast;
//                ChatMessage message = ChatMessage(
//                  typeChat: TypeChat.User,
//                  contentChat: ContentChat.imageLibrary,
//
//                  timecomment: ChangeTime.ChangeTimeStampToTime(
//                      DateTime.now().millisecondsSinceEpoch.toDouble() / 1000.0,
//                      true,
//                      false,
//                      false),
//                  animationController: new AnimationController(
//                    duration: new Duration(milliseconds: 500),
//                    vsync: this,
//                  ),
//                );
//
//                _textController.clear();
//                _textController.text = '';
//                _textController.clearComposing();
//                if (!mounted) return;
//                setState(() {
//                  _messages.insert(0, message);
//                });
//                message.animationController.forward();
//                base64ImageData = [];
//                isChooseFile = false;
            } else {
              isChooseFile = false;
            }
//            }
//            else {
//              if (await Post_Comment(timelast.toDouble(), "", "",
//                      base64ImageData, widget.event.eventID) ==
//                  1) {
//                timestameComment = timelast;
//                ChatMessage message = ChatMessage(
//                  typeChat: TypeChat.User,
//                  text: nameFile,
//
//                  timecomment: ChangeTime.ChangeTimeStampToTime(
//                      DateTime.now().millisecondsSinceEpoch.toDouble() / 1000.0,
//                      true,
//                      false,
//                      false),
//                  animationController: new AnimationController(
//                    duration: new Duration(milliseconds: 500),
//                    vsync: this,
//                  ),
//                );
//
//                _textController.clear();
//                _textController.text = '';
//                _textController.clearComposing();
//                if (!mounted) return;
//                setState(() {
//                  _messages.insert(0, message);
//                });
//                message.animationController.forward();
//                base64ImageData = [];
//                isChooseFile = false;
//              } else {
//                isChooseFile = false;
//                MsgDialog.showMsgDialog(context, "Thông báo",
//                    "Tập tin chưa được gửi", AlertType.error);
//              }
//            }
          });
        }
      } else {
        isChooseFile = false;
        return Toast.show("Không có tập tin được chọn", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } catch (e, stacktrace) {
      isChooseFile = false;
    }
  }

  Future getImage() async {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
        title: Text(
          'Chọn tập tin',
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
              child: Text(
                'Máy ảnh',
              ),
              onPressed: () async {
                await handelCamera();
              }),
          CupertinoActionSheetAction(
            child: Text(
              'Thư viện',
            ),
            onPressed: () async {
              await handleLibrary();
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Tập tin',
            ),
            onPressed: () async {
              await handleFile();
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Hủy bỏ',
          ),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () async {
                await getImage();
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.blue,
                size: 30,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Flexible(
              child: TextField(
                controller: _textController,
                textInputAction: TextInputAction.send,
                onSubmitted: (va) async =>
                    await _handleSubmitted(_textController.text),
                onChanged: (String text) {
                  if (text.length > 0) {
                    if (!mounted) return;
                    setState(() {
                      isHasText = true;
                    });
                  } else {
                    if (!mounted) return;
                    setState(() {
                      isHasText = false;
                    });
                  }
                  if (!mounted) return;
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: "Gửi bình luận",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  size: 25,
                  color: isHasText == true ? Colors.blue : Colors.grey,
                ),
                onPressed: _isComposing
                    ? () async {
                        if (isHasText) {
                          await _handleSubmitted(_textController.text);
                        } else {
                          return;
                        }
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _handleSubmitted(String text) async {
    try {
      double timelast = DateTime.now().millisecondsSinceEpoch.toDouble();
      timestameComment = timelast;
      if (_textController.text.isNotEmpty) {
        ChatMessage message = ChatMessage(
          typeChat: TypeChat.User,
          text: text,
          contentChat: ContentChat.text,
          animationController: new AnimationController(
            duration: new Duration(milliseconds: 500),
            vsync: this,
          ),
          timecomment: ChangeTime.ChangeTimeStampToTime(
              timestameComment / 1000.0, true, false, false),
        );
        if (!mounted) return;
        setState(() {
          isHasText = false;
          _messages.insert(0, message);
          _textController.clear();
          _textController.clearComposing();
          isHasComment = true;
        });
        message.animationController.forward();
      } else {}
    } catch (e, stackTrace) {}
  }

  Future<void> onrefresh() async {
    await Future.delayed(const Duration(microseconds: 500));
  }

  @override
  Future afterFirstLayout(BuildContext context) async {}

  @override
  bool get wantKeepAlive => true;

  Future handleCommentTextUser(Comment comment) async {
    ChatMessage message = ChatMessage(
      typeChat: TypeChat.User,
      contentChat: ContentChat.text,
      text: comment.comment,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 500),
        vsync: this,
      ),
      timecomment: ChangeTime.ChangeTimeStampToTime(
          comment.commentDate / 1000.0, true, false, false),
    );
    _textController.clear();
    _textController.clearComposing();
    if (!mounted) return;
    setState(() {
      _messages.insert(0, message);
      isHasComment = true;
    });
    message.animationController.forward();
  }

  Future handleCommentTextAdmin(Comment comment) async {
    ChatMessage message = ChatMessage(
      typeChat: TypeChat.Admin,
      contentChat: ContentChat.text,
      text: comment.comment,
      name: comment.cUserName,
      avatar: comment.url_avt,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 500),
        vsync: this,
      ),
      timecomment: ChangeTime.ChangeTimeStampToTime(
          comment.commentDate / 1000.0, true, false, false),
    );
    _textController.clear();
    _textController.clearComposing();
    if (!mounted) return;
    setState(() {
      _messages.insert(0, message);
      isHasComment = true;
    });
    message.animationController.forward();
  }

  Future handleCommentImageLinkUser(Comment comment) async {
    ChatMessage message = ChatMessage(
      typeChat: TypeChat.User,
      contentChat: ContentChat.imageLink,
      url: comment.url,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 500),
        vsync: this,
      ),
      timecomment: ChangeTime.ChangeTimeStampToTime(
          comment.commentDate / 1000.0, true, false, false),
    );
    _textController.clear();
    _textController.clearComposing();
    if (!mounted) return;
    setState(() {
      _messages.insert(0, message);
      isHasComment = true;
    });
    message.animationController.forward();
  }

  Future handleCommentImageLinkAdmin(Comment comment) async {
    ChatMessage message = ChatMessage(
      typeChat: TypeChat.Admin,
      contentChat: ContentChat.imageLink,
      avatar: comment.url_avt,
      name: comment.cUserName,
      url: comment.url,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 500),
        vsync: this,
      ),
      timecomment: ChangeTime.ChangeTimeStampToTime(
          comment.commentDate / 1000.0, true, false, false),
    );
    _textController.clear();
    _textController.clearComposing();
    if (!mounted) return;
    setState(() {
      _messages.insert(0, message);
      isHasComment = true;
    });
    message.animationController.forward();
  }

  Future handleCommentFileUser(Comment comment) async {
    ChatMessage message = ChatMessage(
      typeChat: TypeChat.User,
      contentChat: ContentChat.file,
      url: comment.url,
      nameFile: comment.urlFileName,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 500),
        vsync: this,
      ),
      timecomment: ChangeTime.ChangeTimeStampToTime(
          comment.commentDate / 1000.0, true, false, false),
    );
    _textController.clear();
    _textController.clearComposing();
    if (!mounted) return;
    setState(() {
      _messages.insert(0, message);
      isHasComment = true;
    });
    message.animationController.forward();
  }

  Future handleCommentFileAdmin(Comment comment) async {
    ChatMessage message = ChatMessage(
      typeChat: TypeChat.User,
      contentChat: ContentChat.file,
      avatar: comment.url_avt,
      name: comment.cUserName,
      url: comment.url,
      nameFile: comment.urlFileName,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 500),
        vsync: this,
      ),
      timecomment: ChangeTime.ChangeTimeStampToTime(
          comment.commentDate / 1000.0, true, false, false),
    );
    _textController.clear();
    _textController.clearComposing();
    if (!mounted) return;
    setState(() {
      _messages.insert(0, message);
      isHasComment = true;
    });
    message.animationController.forward();
  }
}

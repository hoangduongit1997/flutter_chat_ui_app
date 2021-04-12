import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/utils/utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

enum TypeChat {
  Admin,
  User,
}

enum ContentChat { text, imageLink, imageCamera, imageLibrary, file }

class ChatMessage extends StatelessWidget {
  ChatMessage(
      {this.typeChat,
      this.contentChat,
      this.name,
      this.fileChat,
      this.text,
      this.animationController,
      this.timecomment,
      this.fileChat2,
      this.avatar,
      this.url,
      this.nameFile});
  final TypeChat typeChat;
  final ContentChat contentChat;
  final File fileChat;
  final String text;
  final String avatar;
  final String url;
  final String name;
  final String nameFile;
  final AnimationController animationController;
  final String timecomment;
  final Uint8List fileChat2;
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool isHasFile = false;
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            typeChat == TypeChat.User
                ? SizedBox(
                    width: deviceWidth / 7,
                  )
                : Container(),
            typeChat == TypeChat.User && contentChat == ContentChat.text
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            text ?? '',
                          ),
                        ),
                        Text(timecomment ?? ""),
                      ],
                    ),
                  )
                : Container(),
            typeChat == TypeChat.Admin && contentChat == ContentChat.text
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            avatar == null || avatar.length == 0
                                ? SvgPicture.asset(
                                    "assets/images/image2vector.svg",
                                    height: 20,
                                    width: 20,
                                  )
                                : CachedNetworkImage(
                                    fadeOutDuration:
                                        Duration(milliseconds: 700),
                                    imageUrl: avatar,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: Dimension.getWidth(0.052),
                                      height: Dimension.getWidth(0.052),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    fit: BoxFit.contain,
                                    fadeInDuration: Duration(milliseconds: 700),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.image,
                                      color: Colors.grey.withOpacity(0.8),
                                    ),
                                    placeholder: (context, url) => new SizedBox(
                                      child: Center(
                                        child: SpinKitFadingCircle(
                                          color:
                                              Color.fromARGB(255, 40, 115, 161),
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Container(
                                  child: Text(
                                name ?? "",
                              )),
                            )
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey[300],
                              ),
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(
                                14.0,
                              ),
                            ),
                            margin: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              text ?? '',
                            )),
                        Text(
                          timecomment ?? "",
                        ),
                      ],
                    ),
                  )
                : Container(),
            typeChat == TypeChat.User && contentChat == ContentChat.imageLink
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 5.0),
                          child: FittedBox(
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            child: CachedNetworkImage(
                              fadeOutDuration: Duration(milliseconds: 700),
                              imageUrl: url,
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              fadeInDuration: Duration(milliseconds: 700),
                              errorWidget: (context, url, error) => Icon(
                                Icons.image,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              placeholder: (context, url) => new SizedBox(
                                child: Center(
                                  child: SpinKitFadingCircle(
                                    color: Color.fromARGB(255, 40, 115, 161),
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          timecomment ?? "",
                        ),
                      ],
                    ),
                  )
                : Container(),
            typeChat == TypeChat.Admin && contentChat == ContentChat.imageLink
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            avatar == null || avatar.length == 0
                                ? SvgPicture.asset(
                                    "assets/images/image2vector.svg",
                                    height: 20,
                                    width: 20,
                                  )
                                : CachedNetworkImage(
                                    fadeOutDuration:
                                        Duration(milliseconds: 700),
                                    imageUrl: avatar,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: Dimension.getWidth(0.052),
                                      height: Dimension.getWidth(0.052),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    fit: BoxFit.contain,
                                    fadeInDuration: Duration(milliseconds: 700),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.image,
                                      color: Colors.grey.withOpacity(0.8),
                                    ),
                                    placeholder: (context, url) => new SizedBox(
                                      child: Center(
                                        child: SpinKitFadingCircle(
                                          color:
                                              Color.fromARGB(255, 40, 115, 161),
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                  child: Text(
                                name ?? "",
                              )),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 5.0),
                          child: FittedBox(
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            child: CachedNetworkImage(
                              fadeOutDuration: Duration(milliseconds: 700),
                              imageUrl: url,
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              fadeInDuration: Duration(milliseconds: 700),
                              errorWidget: (context, url, error) => Icon(
                                Icons.image,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              placeholder: (context, url) => new SizedBox(
                                child: Center(
                                  child: SpinKitFadingCircle(
                                    color: Color.fromARGB(255, 40, 115, 161),
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          timecomment ?? "",
                        ),
                      ],
                    ),
                  )
                : Container(),
            typeChat == TypeChat.User && contentChat == ContentChat.file
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 5.0),
                          child: GestureDetector(
                            onTap: () async {
                              await _launchURL(url);
                            },
                            child: Text(
                              nameFile ?? '',
                            ),
                          ),
                        ),
                        Text(
                          timecomment ?? "",
                        ),
                      ],
                    ),
                  )
                : Container(),
            typeChat == TypeChat.Admin && contentChat == ContentChat.file
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            avatar == null || avatar.length == 0
                                ? SvgPicture.asset(
                                    "assets/images/image2vector.svg",
                                    height: 20,
                                    width: 20,
                                  )
                                : CachedNetworkImage(
                                    fadeOutDuration:
                                        Duration(milliseconds: 700),
                                    imageUrl: avatar,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: Dimension.getWidth(0.052),
                                      height: Dimension.getWidth(0.052),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    fit: BoxFit.contain,
                                    fadeInDuration: Duration(milliseconds: 700),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.image,
                                      color: Colors.grey.withOpacity(0.8),
                                    ),
                                    placeholder: (context, url) => new SizedBox(
                                      child: Center(
                                        child: SpinKitFadingCircle(
                                          color:
                                              Color.fromARGB(255, 40, 115, 161),
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                  child: Text(
                                name ?? "",
                              )),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 5.0),
                          child: GestureDetector(
                            onTap: () async {
                              await _launchURL(url);
                            },
                            child: Text(
                              nameFile ?? '',
                            ),
                          ),
                        ),
                        Text(
                          timecomment ?? "",
                        ),
                      ],
                    ),
                  )
                : Container(),
            typeChat == TypeChat.User && contentChat == ContentChat.imageCamera
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              SpinKitFadingCircle(
                                color: Color.fromARGB(255, 40, 115, 161),
                                size: 30,
                              ),
                              FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                child: ClipRRect(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    child: Image.file(fileChat)),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          timecomment ?? "",
                        ),
                      ],
                    ),
                  )
                : Container(),
            typeChat == TypeChat.User && contentChat == ContentChat.imageLibrary
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              SpinKitFadingCircle(
                                color: Color.fromARGB(255, 40, 115, 161),
                                size: 30,
                              ),
                              FittedBox(
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                child: ClipRRect(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    child: Image.memory(fileChat2)),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          timecomment ?? "",
                        ),
                      ],
                    ),
                  )
                : Container(),
//            typeChat == TypeChat.User && fileChat2 != null
//                ? Expanded(
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.end,
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.all(8.0),
//                          decoration: BoxDecoration(
//                            border: Border.all(
//                              width: 1,
//                              color: Colors.grey[300],
//                            ),
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(
//                              14.0,
//                            ),
//                          ),
//                          margin: const EdgeInsets.only(top: 5.0),
//                          child: Stack(
//                            alignment: Alignment.center,
//                            children: <Widget>[
//                              SpinKitFadingCircle(
//                                color: Color.fromARGB(255, 40, 115, 161),
//                                size: 30,
//                              ),
//                              FittedBox(
//                                alignment: Alignment.center,
//                                fit: BoxFit.contain,
//                                child: ClipRRect(
//                                  borderRadius: new BorderRadius.circular(8.0),
//                                  child: Image.memory(fileChat2),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                        Text(timecomment ?? "", style: StylesText.style45Black),
//                      ],
//                    ),
//                  )
//                : Container(),
//            typeChat == TypeChat.User && fileChat != null
//                ? Expanded(
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.end,
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.all(8.0),
//                          decoration: BoxDecoration(
//                            border: Border.all(
//                              width: 1,
//                              color: Colors.grey[300],
//                            ),
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(
//                              14.0,
//                            ),
//                          ),
//                          margin: const EdgeInsets.only(top: 5.0),
//                          child: Stack(
//                            alignment: Alignment.center,
//                            children: <Widget>[
//                              SpinKitFadingCircle(
//                                color: Color.fromARGB(255, 40, 115, 161),
//                                size: 30,
//                              ),
//                              FittedBox(
//                                alignment: Alignment.center,
//                                fit: BoxFit.contain,
//                                child: ClipRRect(
//                                    borderRadius:
//                                        new BorderRadius.circular(8.0),
//                                    child: Image.file(fileChat)),
//                              ),
//                            ],
//                          ),
//                        ),
//                        Text(timecomment ?? "", style: StylesText.style45Black),
//                      ],
//                    ),
//                  )
//                : Container(),
//            typeChat == TypeChat.User && url != null
//                ? Expanded(
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.end,
//                      children: <Widget>[
//                        Container(
//                          padding: EdgeInsets.all(8.0),
//                          decoration: BoxDecoration(
//                            border: Border.all(
//                              width: 1,
//                              color: Colors.grey[300],
//                            ),
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(
//                              14.0,
//                            ),
//                          ),
//                          margin: const EdgeInsets.only(top: 5.0),
//                          child: FittedBox(
//                            alignment: Alignment.center,
//                            fit: BoxFit.contain,
//                            child:  CachedNetworkImage(
//                                    fadeOutDuration:
//                                        Duration(milliseconds: 700),
//                                    imageUrl: url,
//                                    alignment: Alignment.center,
//                                    fit: BoxFit.contain,
//                                    fadeInDuration: Duration(milliseconds: 700),
//                                    errorWidget: (context, url, error) => Icon(
//                                      Icons.image,
//                                      color: Colors.grey.withOpacity(0.8),
//                                    ),
//                                    placeholder: (context, url) => new SizedBox(
//                                      child: Center(
//                                        child: SpinKitFadingCircle(
//                                          color:
//                                              Color.fromARGB(255, 40, 115, 161),
//                                          size: 15,
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                          ),
//                        ),
//                        Text(timecomment ?? "", style: StylesText.style45Black),
//                      ],
//                    ),
//                  )
//                : Container(),
//            typeChat == TypeChat.Admin && avatar != null
//                ? Expanded(
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          children: <Widget>[
//                            CachedNetworkImage(
//                              fadeOutDuration: Duration(milliseconds: 700),
//                              imageUrl: avatar,
//                              imageBuilder: (context, imageProvider) =>
//                                  Container(
//                                width: Dimension.getWidth(0.1),
//                                height: Dimension.getWidth(0.1),
//                                decoration: BoxDecoration(
//                                  shape: BoxShape.circle,
//                                  image: DecorationImage(
//                                      image: imageProvider,
//                                      fit: BoxFit.contain),
//                                ),
//                              ),
//                              alignment: Alignment.center,
//                              fit: BoxFit.contain,
//                              fadeInDuration: Duration(milliseconds: 700),
//                              errorWidget: (context, url, error) => Icon(
//                                Icons.image,
//                                color: Colors.grey.withOpacity(0.8),
//                              ),
//                              placeholder: (context, url) => new SizedBox(
//                                child: Center(
//                                  child: SpinKitFadingCircle(
//                                    color: Color.fromARGB(255, 40, 115, 161),
//                                    size: 15,
//                                  ),
//                                ),
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(left: 5.0),
//                              child: Container(
//                                  child: Text(
//                                name ?? "",
//                                style: StylesText.style12BlackBoldItalic,
//                              )),
//                            )
//                          ],
//                        ),
//                        Container(
//                            padding: EdgeInsets.all(8.0),
//                            decoration: BoxDecoration(
//                              border: Border.all(
//                                width: 1,
//                                color: Colors.grey[300],
//                              ),
//                              color: Colors.grey[300],
//                              borderRadius: BorderRadius.circular(
//                                14.0,
//                              ),
//                            ),
//                            margin: const EdgeInsets.only(top: 5.0),
//                            child: Linkify(
//                              onOpen: (link) async {
//                                await _launchURL(link.url);
//                              },
//                              text: text ?? '',
//                              style: StylesText.style13Black,
//                              linkStyle: StylesText.style13Url,
//                            )),
//                        Text(timecomment ?? "", style: StylesText.style45Black),
//                      ],
//                    ),
//                  )
//                : Container(),
//            typeChat == TypeChat.Admin && avatar == null
//                ? Expanded(
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          children: <Widget>[
//                            SvgPicture.asset(
//                              "assets/images/image2vector.svg",
//                              height: 50,
//                              width: 50,
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.all(0.0),
//                              child: Container(
//                                  child: Text(
//                                name ?? "",
//                                style: StylesText.style12BlackBoldItalic,
//                              )),
//                            )
//                          ],
//                        ),
//                        Container(
//                            padding: EdgeInsets.all(8.0),
//                            decoration: BoxDecoration(
//                              border: Border.all(
//                                width: 1,
//                                color: Colors.grey[300],
//                              ),
//                              color: Colors.grey[300],
//                              borderRadius: BorderRadius.circular(
//                                14.0,
//                              ),
//                            ),
//                            margin: const EdgeInsets.only(top: 5.0),
//                            child: Linkify(
//                              onOpen: (link) async {
//                                await _launchURL(link.url);
//                              },
//                              text: text ?? '',
//                              style: StylesText.style13Black,
//                              linkStyle: StylesText.style13Url,
//                            )),
//                        Text(timecomment ?? "", style: StylesText.style45Black),
//                      ],
//                    ),
//                  )
//                : Container(),
            typeChat == TypeChat.Admin
                ? SizedBox(
                    width: deviceWidth / 7,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

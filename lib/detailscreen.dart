import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'book.dart';

class DetailScreen extends StatefulWidget {
  final Book book;
  const DetailScreen({Key key, this.book}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.book.booktitle),
        ),
        body: Center(
            child: Padding(
                padding:
                    EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                child: SingleChildScrollView(
                    child: Column(children: [
                  Stack(children: [
                    Container(
                        height: screenHeight / 1.63,
                        width: screenWidth / 1.5,
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://slumberjer.com/bookdepo/bookcover/${widget.book.cover}.jpg",
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(
                            Icons.broken_image,
                            size: screenWidth / 2,
                          ),
                        )),
                    Positioned(
                      child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              Text(widget.book.rating,
                                  style: TextStyle(color: Colors.black)),
                              Icon(Icons.star, color: Colors.yellow[600]),
                            ],
                          )),
                      top: 5,
                      left: 5,
                    )
                  ]),
                  Container(
                      child: Column(children: [
                    SizedBox(height: 5),
                    Text(widget.book.booktitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10),
                    Row(children: [
                      RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              children: <TextSpan>[
                            TextSpan(
                                text: "Author: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(text: widget.book.author)
                          ])),
                    ]),
                    SizedBox(height: 8),
                    Row(children: [
                      RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              children: <TextSpan>[
                            TextSpan(
                                text: "Price: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(text: "RM" + widget.book.price)
                          ])),
                    ]),
                    SizedBox(height: 8),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: <TextSpan>[
                          TextSpan(
                              text: "Description:\n",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          TextSpan(text: widget.book.description)
                        ])),
                    SizedBox(height: 8),
                    Row(children: [
                      RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              children: <TextSpan>[
                            TextSpan(
                                text: "Publisher: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(text: widget.book.publisher)
                          ])),
                    ]),
                  ]))
                ])))));
  }
}

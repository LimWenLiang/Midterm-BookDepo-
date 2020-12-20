import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'book.dart';
import 'detailscreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double screenHeight, screenWidth;
  List bookList;
  String _titleCenter = "Loading Books...";

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Books'),
      ),
      body: Column(
        children: <Widget>[
          bookList == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(_titleCenter,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)))))
              : Flexible(
                  child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (screenWidth / screenHeight) / 1.15,
                  children: List.generate(bookList.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(1),
                      child: Card(
                          child: InkWell(
                        onTap: () => _loadRestaurantDetail(index),
                        child: SingleChildScrollView(
                          child: Stack(children: [
                            Center(
                                child: Column(
                              children: [
                                Container(
                                    height: screenHeight / 2.3,
                                    width: screenWidth / 1,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "http://slumberjer.com/bookdepo/bookcover/${bookList[index]['cover']}.jpg",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(
                                        Icons.broken_image,
                                        size: screenWidth / 2,
                                      ),
                                    )),
                                SizedBox(height: 5),
                                Text(bookList[index]['booktitle'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold, color: Colors.black,
                                    )),
                                SizedBox(height: 3),
                                Text(bookList[index]['author'],
                                    style: TextStyle(
                                      fontSize: 11,
                                    )),
                                SizedBox(height: 1),
                                Text("RM" + bookList[index]['price'],
                                    style: TextStyle(
                                      fontSize: 11,
                                    )),
                              ],
                            )),
                            Positioned(
                              child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      Text(bookList[index]["rating"],
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Icon(Icons.star,
                                          color: Colors.yellow[600]),
                                    ],
                                  )),
                              top: 5,
                              left: 5,
                            )
                          ]),
                        ),
                      )),
                    );
                  }),
                ))
        ],
      ),
    );
  }

  void _loadBooks() {
    http.post("http://slumberjer.com/bookdepo/php/load_books.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        bookList = null;
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          bookList = jsondata["books"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadRestaurantDetail(int index) async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    await pr.show();
    print(bookList[index]['booktitle']);
    Book book = new Book(
      bookid: bookList[index]['bookid'],
      booktitle: bookList[index]['booktitle'],
      author: bookList[index]['author'],
      price: bookList[index]['price'],
      description: bookList[index]['description'],
      rating: bookList[index]['rating'],
      publisher: bookList[index]['publisher'],
      cover: bookList[index]['cover'],
    );
    await pr.hide();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DetailScreen(
                  book: book,
                )));
  }
}

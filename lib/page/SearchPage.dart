import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../main.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            // Here we create one to set status bar color
            elevation: 0,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.blue),
          )),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          buildSearchBar(context),
        ],
      ),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: Container(
            padding: EdgeInsets.only(left: 10),
            height: 60,
            color: Colors.blue,
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding:
                  EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              height: 60,
              child: Container(
                height: 60,
                alignment: Alignment.center,
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.search,
                          size: 30,
                        ),
                      ),
                      hintText: "search",
                      suffixIcon: Icon(
                        Icons.camera_alt,
                        size: 30,
                      )),
                ),
              ),
            ))
      ],
    );
  }
}

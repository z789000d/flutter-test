import 'package:flutter/material.dart';
import 'package:untitledtest1/models/ApiPost.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // This widget is the root of your application.

  List<String> litems = ["1", "2", "Third", "4"];

  ValueNotifier<List> _valueListenable =
      ValueNotifier<List>(["1", "2", "Third", "4"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), child: buildAppBar()),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          buildSearchBar(context),
          Container(
            color: Colors.blue,
            height: 44,
          ),
          createdevierBar(),
          Container(
            color: Colors.amber,
            width: MediaQuery.of(context).size.width,
            height: 150,
          ),
          Container(
            color: Color.fromARGB(255, 214, 219, 219),
            height: 5.0,
          ),
          createdProductView(),
          createRefreshButton()
        ],
      ),
    );
  }

  Widget createdevierBar() {
    return Container(
      color: Colors.lightBlue,
      width: MediaQuery.of(context).size.width,
      height: 44,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.place,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text("test1",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              )),
        ],
      ),
    );
  }

  Widget createdProductView() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                "一天的交易",
                style: TextStyle(fontSize: 20, color: Colors.blueGrey),
              )),
          Divider(),
          Icon(
            Icons.access_alarm,
            size: 200,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                "商品介紹.............xxxxdddeess",
                style: TextStyle(fontSize: 12, color: Colors.blueGrey),
              )),
          ValueListenableBuilder(
              valueListenable: _valueListenable,
              builder: (context, List value, child) {
                return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    height: 30.0,
                    alignment: Alignment.center,
                    child: ListView.separated(
                      itemCount: value.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            color: Colors.amber,
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, top: 0, right: 10, bottom: 0),
                                child: Text(
                                  value[index],
                                  style: TextStyle(fontSize: 20),
                                )));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 10,
                        );
                      },
                    ));
              })
        ]));
  }

  Widget createRefreshButton() {
    return TextButton(
        child: Text("按鈕"),
        onPressed: () async {
          _valueListenable.value.add("5");
          print("aaaa $_valueListenable.value");

          ApiPost apiPost = ApiPost();

          await apiPost
              .post()
              .then((value) => print("aaaaaa " + jsonDecode(value.toString())['exchange_rate_JPY']));

          setState(() {});
        });
  }

  Widget buildSearchBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
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
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              hintText: "search",
              suffixIcon: Icon(
                Icons.camera_alt,
                size: 30,
              )),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      leading: Icon(Icons.menu),
      title: Align(
        child: Text(
          "test1",
          style: TextStyle(color: Colors.blue, fontSize: 30),
        ),
      ),
      actions: <Widget>[
        Icon(Icons.notifications_none),
        Icon(Icons.card_travel)
      ],
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), child: buildAppBar()),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          buildSearchBar(context),
          Container(
            color: Colors.blue,
            height: 44,
          ),
          Container(
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
          ),
          Container(
            color: Colors.amber,
            width: MediaQuery.of(context).size.width,
            height: 150,
          ),
          Container(
            color: Color.fromARGB(255, 214, 219, 219),
            height: 5.0,
          ),
          Container(
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  height: 200.0,
                  child: ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        color: Colors.red,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        color: Colors.blue,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        color: Colors.green,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        color: Colors.yellow,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ])),
        ],
      ),
    );
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

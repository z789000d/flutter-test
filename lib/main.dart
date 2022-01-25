import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitledtest1/DrawerWidget.dart';
import 'package:untitledtest1/TwoPage.dart';
import 'package:untitledtest1/models/ApiPost.dart';
import 'dart:convert';
import 'models/Utillity.dart';

ApiPost apiPost = ApiPost();
String exchangeRateJPY = "";
GlobalKey<ScaffoldState> globalKey = GlobalKey();
Utillity utillity = Utillity();
DrawerWidget drawerWidget = DrawerWidget();

String icome = "\$999";
String expenditure = "\$9,999";

bool hasRecord = false;

void main() {
  getApi().then((value) {
    exchangeRateJPY = jsonDecode(value.toString())['exchange_rate_JPY'];

    runApp(MaterialApp(
      builder: (context, child) => Scaffold(
        // Global GestureDetector that will dismiss the keyboard
        body: GestureDetector(
          onTap: () {
            utillity.hideKeyboard(context);
          },
          child: child,
        ),
      ),
      home: HomePage(),
    ));
  });
}

Future<Response> getApi() async {
  return apiPost.post();
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() {
    return HomePageState();
  }
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
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            // Here we create one to set status bar color
            backgroundColor: Colors
                .blue, // Set any color of status bar you want; or it defaults to your theme's primary color
          )),
      body: Column(
        children: [
          homeBar(),
          Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: <Widget>[
                    createItemBar(),
                    createdDataAndMoneyBar(),
                    createdContentList(),
                  ],
                ),
              ),
            ),
            flex: 1,
          ),
          createRefreshButton(),
          createBottomBar()
        ],
      ),
    );
  }

  Widget homeBar() {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      color: Colors.blue,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "默認帳本",
                  style: TextStyle(color: Colors.white),
                ),
              )),
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Text(
              "帳單",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 10),
            child: Icon(Icons.calendar_today_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget createItemBar() {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Icon(
                    Icons.format_list_numbered_rounded,
                    color: Colors.white,
                  ),
                  Text(
                    '預設帳本',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    '新增帳本',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget createdDataAndMoneyBar() {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            '2022-01',
            style: TextStyle(color: Colors.white),
          ),
          Expanded(flex: 1, child: SizedBox()),
          Column(
            children: [
              Text(
                '收入',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                icome,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Text(
                  '支出',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  expenditure,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget createdContentList() {
    List<Widget> datesData = <Widget>[];
    for (int i = 0; i < 100; i++) {
      datesData.add(Container(
        child: Text("aaa$i"),
        margin: EdgeInsets.all(10),
      ));
    }
    return Stack(
      children: [
        Container(
          height: 60,
          color: Colors.blue,
        ),
        Visibility(
            visible: !hasRecord,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  children: datesData,
                ),
              ),
            )),
        Visibility(
            visible: hasRecord,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                height: 400,
                child: Text('沒有更多紀錄'),
                alignment: Alignment.center,
              ),
            )),
      ],
    );
  }

  Widget createBottomBar() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              color: Colors.black,
              width: double.infinity,
              height: 1,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Icon(
                            Icons.book,
                            color: Colors.red,
                          ),
                          Text(
                            '記帳本',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      onTap: (){ print('go 1');},
                    ),
                  ),
                  flex: 1,
                ),
                Container(
                  color: Colors.black,
                  width: 1,
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Icon(
                            Icons.wallet_giftcard,
                            color: Colors.blue,
                          ),
                          Text(
                            '錢包',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                      onTap: (){ print('go 2');},
                    ),
                  ),
                  flex: 1,
                ),
                Container(
                  color: Colors.black,
                  width: 1,
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Icon(
                            Icons.analytics_outlined,
                            color: Colors.blue,
                          ),
                          Text(
                            '分析',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                      onTap: (){ print('go 3');},
                    ),
                  ),
                  flex: 1,
                ),
                Container(
                  color: Colors.black,
                  width: 1,
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Icon(
                            Icons.settings,
                            color: Colors.blue,
                          ),
                          Text(
                            '設定',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                      onTap: (){ print('go 4');},
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ],
        ));
  }

  Widget createRefreshButton() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: TextButton(
          child: Text("切換狀態"),
          onPressed: () async {
            hasRecord = !hasRecord;
            setState(() {});
          }),
    );
  }

  Widget createIntentButton() {
    return TextButton(
        child: Text('切換頁面'),
        onPressed: () async {
          TwoPage twoPage = TwoPage();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => twoPage));
        });
  }
}

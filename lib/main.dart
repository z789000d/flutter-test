import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitledtest1/DrawerWidget.dart';
import 'package:untitledtest1/page/AnalyzePage.dart';
import 'package:untitledtest1/page/SearchPage.dart';
import 'package:untitledtest1/page/SettingPage.dart';
import 'package:untitledtest1/page/WalletPage.dart';
import 'package:untitledtest1/models/ApiPost.dart';
import 'package:untitledtest1/models/BottomSheetUtillity.dart';
import 'package:untitledtest1/models/SharedPreferencesUtillity.dart';
import 'dart:convert';
import 'models/Utillity.dart';

ApiPost apiPost = ApiPost();
String exchangeRateJPY = "";
GlobalKey<ScaffoldState> globalKey = GlobalKey();
Utillity utillity = Utillity();
DrawerWidget drawerWidget = DrawerWidget();
SharedPreferencesUtillity sharedPreferencesUtillity =
    SharedPreferencesUtillity();

DateTime now = DateTime.now().toLocal();
String dateTime = "${now.year}-${now.month}-${now.day}";

void main() {
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
          Container(
            child: Row(
              children: [
                Expanded(
                  child: createAddButton(),
                  flex: 1,
                ),
                Expanded(
                  child: createReduceButton(),
                  flex: 1,
                ),
                Expanded(
                  child: createRemoveButton(),
                  flex: 1,
                ),
              ],
            ),
          ),
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
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            onTap: () {
              SearchPage searchPage = SearchPage();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => searchPage));
            },
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

  createItemBar() {
    List<Container> list = <Container>[];

    return FutureBuilder<List<String>?>(
        future: SharedPreferencesUtillity().getLedgerRecord(),
        builder: (BuildContext context, value) {
          list.clear();
          if (value.data != null) {
            for (int i = 0; i < value.data!.length; i++) {
              list.add(Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Icon(
                        Icons.format_list_numbered_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        '${value.data![i]}',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )));
            }
          } else {
            list.add(Container());
          }

          return Container(
            color: Colors.blue,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
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
                    child: Row(
                      children: list,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: GestureDetector(
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
                      ),
                      onTap: () {
                        BottomSheetUtillity()
                            .showBottomSheet(context, () => setState(() {}));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget createdDataAndMoneyBar() {
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(dateTime);
    int allIcome = 0;
    int allxpenditure = 0;

    return FutureBuilder(
      future: sharedPreferencesUtillity.getRecord(dateTime).then((value) {
        if (value == null) {
          allIcome = 0;
          allxpenditure = 0;
        } else {
          for (int i = value.length - 1; i >= 0; i--) {
            String money =
                value[i].split("\$ ")[value[i].split("\$ ").length - 1];

            if (value[i].contains("收入")) {
              allIcome = allIcome + int.parse(money);
            } else if (value[i].contains("消費")) {
              allxpenditure = allxpenditure + int.parse(money);
            }
            print(money);
          }
        }
      }),
      builder: (_, value) {
        return Container(
          color: Colors.blue,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              GestureDetector(
                child: Text(
                  dateTime,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: tempDate,
                          firstDate: DateTime(1990),
                          lastDate: DateTime(9999))
                      .then((value) {
                    if (value != null) {
                      dateTime = "${value.year}-${value.month}-${value.day}";
                      setState(() {});
                    }
                  });
                },
              ),
              Expanded(flex: 1, child: SizedBox()),
              Column(
                children: [
                  Text(
                    '收入',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "\$" + allIcome.toString(),
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
                      "\$" + allxpenditure.toString(),
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget createdContentList() {
    List<Widget> datesData = <Widget>[];
    bool hasRecord = true;

    return FutureBuilder(
      future: sharedPreferencesUtillity.getRecord(dateTime).then((value) {
        if (value == null) {
          hasRecord = false;
        } else {
          hasRecord = true;
          for (int i = value.length - 1; i >= 0; i--) {
            datesData.add(Container(
              child: Text(value[i]),
              margin: EdgeInsets.all(10),
            ));
          }
        }
      }),
      builder: (_, value) {
        return Stack(
          children: [
            Container(
              height: 20,
              color: Colors.blue,
            ),
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
                    constraints: BoxConstraints(minHeight: 300),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      children: datesData,
                    ),
                  ),
                )),
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
                    height: 400,
                    child: Text('沒有更多紀錄'),
                    alignment: Alignment.center,
                  ),
                )),
          ],
        );
      },
    );
  }

  Widget createBottomBar() {
    return Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              color: Colors.black,
              width: double.infinity,
              height: 1,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
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
                      onTap: () {
                        print('go 1');
                      },
                    ),
                  ),
                  flex: 1,
                ),
                Container(
                  color: Colors.black,
                  width: 1,
                  height: 64,
                ),
                Expanded(
                  child: Container(
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
                      onTap: () {
                        WalletPage walletPage = WalletPage();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => walletPage));
                        print('go 2');
                      },
                    ),
                  ),
                  flex: 1,
                ),
                Container(
                  color: Colors.black,
                  width: 1,
                  height: 64,
                ),
                Expanded(
                  child: Container(
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
                      onTap: () {
                        AnalyzePage analyzePage = AnalyzePage();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => analyzePage));
                        print('go 3');
                      },
                    ),
                  ),
                  flex: 1,
                ),
                Container(
                  color: Colors.black,
                  width: 1,
                  height: 64,
                ),
                Expanded(
                  child: Container(
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
                      onTap: () {
                        SettingPage settingPage = SettingPage();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => settingPage));
                        print('go 4');
                      },
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ],
        ));
  }

  Widget createAddButton() {
    return Container(
      color: Colors.white,
      child: TextButton(
          child: Text("增加收入"),
          onPressed: () async {
            // sharedPreferencesUtillity.removeRecord();
            sharedPreferencesUtillity.setRecord(
                dateTime, "$dateTime 收入xxxxx \$ 999");
            // hasRecord = !hasRecord;
            setState(() {});
          }),
    );
  }

  Widget createReduceButton() {
    return Container(
      color: Colors.white,
      child: TextButton(
          child: Text("增加支出"),
          onPressed: () async {
            // sharedPreferencesUtillity.removeRecord();
            sharedPreferencesUtillity.setRecord(
                dateTime, "$dateTime 消費xxxxx \$ 999");
            // hasRecord = !hasRecord;
            setState(() {});
          }),
    );
  }

  Widget createRemoveButton() {
    return Container(
      color: Colors.white,
      child: TextButton(
          child: Text("刪除紀錄"),
          onPressed: () async {
            sharedPreferencesUtillity.removeRecord(dateTime);
            setState(() {});
          }),
    );
  }
}

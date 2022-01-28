import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../main.dart';
import 'AnalyzePage.dart';
import 'SettingPage.dart';

class WalletPage extends StatefulWidget {
  WalletPage({Key? key}) : super(key: key);

  @override
  WalletPageState createState() {
    return WalletPageState();
  }
}

class WalletPageState extends State<WalletPage> {
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
            elevation: 0,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.blue),
          )),
      body: Column(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: <Widget>[
              buildSearchBar(context),
            ],
          ),
          Expanded(
            child: Container(),
            flex: 1,
          ),
          createBottomBar()
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
                            color: Colors.blue,
                          ),
                          Text(
                            '記帳本',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
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
                            color: Colors.red,
                          ),
                          Text(
                            '錢包',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      onTap: () {
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
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
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
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
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
}

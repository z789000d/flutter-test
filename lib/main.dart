import 'package:flutter/material.dart';
import 'package:untitledtest1/TwoPage.dart';
import 'package:untitledtest1/models/ApiPost.dart';
import 'dart:convert';
import 'models/Utillity.dart';

ApiPost apiPost = ApiPost();
String exchangeRateJPY = "";
GlobalKey<ScaffoldState> globalKey = GlobalKey();
Utillity utillity = Utillity();

void main() {
  apiPost.post().then((value) {
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
          preferredSize: Size.fromHeight(60), child: buildAppBar()),
      drawer: DrawerWidget(),
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
          createRefreshButton(),
          createIntentButton()
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
        child: Text(exchangeRateJPY),
        onPressed: () async {
          _valueListenable.value.add("5");
          print("aaaa $_valueListenable.value");
          setState(() {});
        });
  }

  Widget createIntentButton() {
    return TextButton(
        child: Text('切換頁面'),
        onPressed: () async {
         Navigator.push(context, MaterialPageRoute(builder: (context) => TwoPage()));
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

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'RedKeyset',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text('redkeyset@gmail.com'),
            //定义用户头像，CircleAvatar 指定成圆形
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'http://pic.616pic.com/ys_bnew_img/00/05/27/1oJwLdJItV.jpg'),
            ),
            decoration: BoxDecoration(
                color: Colors.deepOrangeAccent, //区域背景颜色
                image: DecorationImage(
                    image: NetworkImage(
                        'https://media.istockphoto.com/photos/deep-space-picture-id472809828?k=20&m=472809828&s=612x612&w=0&h=BGwhzzdXPHUeEm0iu20x241YLSb3tEsPRrH35uygMYg='),
                    fit: BoxFit.cover,
                    // ColorFilter 颜色滤镜  BlendMode混合模式
                    colorFilter: ColorFilter.mode(
                        Colors.blue[300]!
                            .withOpacity(0.2), // blueAccent 这一类的颜色会报错
                        BlendMode.srcOver))),
          ),
          ListTile(
              leading: Icon(Icons.access_alarm,
                  color: Colors.blueAccent, size: 18.0), //指定Icon的颜色  和 大小
              title:
                  Text('新闻', textAlign: TextAlign.left), //TextAlign.left 文字左对齐
              onTap: () => Navigator.pop(context)),
          ListTile(
              title: Text('消息', textAlign: TextAlign.center),
              onTap: () => Navigator.pop(context)),
          ListTile(
              title: Text('关于我们',
                  textAlign: TextAlign.right), //TextAlign.right 文字右对齐
              trailing: Icon(Icons.account_balance,
                  color: Colors.orangeAccent, size: 28.0),
              onTap: () => Navigator.pop(context))
        ],
      ),
    );
  }
}

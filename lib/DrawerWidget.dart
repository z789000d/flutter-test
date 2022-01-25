import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitledtest1/main.dart';

class DrawerWidget extends StatelessWidget {
  String accountName = "aaaaaa";
  String accountEmail = 'redkeyset@gmail.com';
  String accountImageUrl =
      'http://pic.616pic.com/ys_bnew_img/00/05/27/1oJwLdJItV.jpg';
  String accountBackgroundUrl =
      'https://media.istockphoto.com/photos/deep-space-picture-id472809828?k=20&m=472809828&s=612x612&w=0&h=BGwhzzdXPHUeEm0iu20x241YLSb3tEsPRrH35uygMYg=';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(
                accountName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(accountEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(accountImageUrl),
              ),
              decoration: BoxDecoration(
                  color: Colors.white, //区域背景颜色
                  image: DecorationImage(
                      image: NetworkImage(accountBackgroundUrl),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.blue[300]!.withOpacity(0.2),
                          BlendMode.srcOver)))),
          ListTile(
              leading: Icon(Icons.access_alarm,
                  color: Colors.blueAccent, size: 18.0),
              title: Text('title1', textAlign: TextAlign.left),
              onTap: () => Navigator.pop(context)),
          ListTile(
              title: Text('title2', textAlign: TextAlign.center),
              onTap: () => Navigator.pop(context)),
          ListTile(
              title: Text('title3', textAlign: TextAlign.right),
              trailing: Icon(Icons.account_balance,
                  color: Colors.orangeAccent, size: 28.0),
              onTap: () => Navigator.pop(context)),
          ListTile(
              title:
                  Text('登出', textAlign: TextAlign.left), //TextAlign.right 文字右对齐
              leading:
                  Icon(Icons.login_outlined, color: Colors.black, size: 28.0),
              onTap: () => Navigator.pop(context))
        ],
      ),
    );
  }
}

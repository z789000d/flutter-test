import 'package:flutter/material.dart';
import 'package:untitledtest1/main.dart';
import 'package:untitledtest1/models/SharedPreferencesUtillity.dart';

class BottomSheetUtillity {
  List<ListTile> list = <ListTile>[];

  showBottomSheet(BuildContext context, VoidCallback callback) {
    SharedPreferencesUtillity().getLedgerRecord().then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          list.add(ListTile(
            leading: Icon(Icons.book),
            title: Text('${value[i]}'),
            onTap: () {
              Navigator.pop(context);
            },
          ));
        }
      } else {
        list.add(ListTile(
          leading: Icon(Icons.book),
          title: Text('無帳本'),
          onTap: () {
            Navigator.pop(context);
          },
        ));
      }
      return showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (BuildContext context,
                StateSetter setState /*You can rename this!*/) {
              return FractionallySizedBox(
                heightFactor: 0.8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          child: Column(
                            children: list,
                          ),
                        ),
                        flex: 1,
                      ),
                      ListTile(
                        leading: Icon(Icons.add),
                        title: Text('新增帳本'),
                        onTap: () {
                          showInputDialog(context, setState);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.add),
                        title: Text('刪除帳本'),
                        onTap: () {
                          list.clear();
                          sharedPreferencesUtillity.removeLedgerRecord();
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ),
              );
            });
          }).whenComplete(() {
        callback();
      });
    });
  }

  showInputDialog(BuildContext context, StateSetter setParentState) {
    TextEditingController textFieldController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("請輸入帳本名稱"),
              content: TextField(
                controller: textFieldController,
                decoration: InputDecoration(hintText: "請輸入帳本名稱"),
              ),
              actions: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text('確定'),
                        onPressed: () {
                          if ((list[0].title as Text).data == "無帳本") {
                            list.clear();
                          }
                          Navigator.pop(context);
                          SharedPreferencesUtillity()
                              .setLedgerRecord(textFieldController.text);
                          list.insert(
                              0,
                              ListTile(
                                leading: Icon(Icons.book),
                                title: Text(textFieldController.text),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ));
                          setParentState(() {});
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          child: Text('取消'),
                          onPressed: () {
                            print(textFieldController.text);
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                  width: double.maxFinite,
                ),
              ],
            );
          },
        );
      },
    );
  }
}

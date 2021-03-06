import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtillity {

  setRecord(String dateTime, String recordString) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList("record" + dateTime) != null) {
      List<String>? list = prefs.getStringList("record" + dateTime);
      list?.add(recordString);

      await prefs.setStringList("record" + dateTime, list!);
    } else {
      List<String> list = [recordString];
      await prefs.setStringList("record" + dateTime, list);
    }
  }

  Future<List<String>?> getRecord(String dateTime) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList("record" + dateTime);
  }

  removeRecord(String dateTime) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("record" + dateTime);
  }

  setLedgerRecord(String recordString) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList("ledgerrecord") != null) {
      List<String>? list = prefs.getStringList("ledgerrecord");
      list?.add(recordString);

      await prefs.setStringList("ledgerrecord", list!);
    } else {
      List<String> list = [recordString];
      await prefs.setStringList("ledgerrecord", list);
    }
  }

  Future<List<String>?> getLedgerRecord() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList("ledgerrecord");
  }

  removeLedgerRecord() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("ledgerrecord");
  }
}

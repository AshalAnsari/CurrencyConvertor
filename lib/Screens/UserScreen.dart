import 'package:currency_convertor/Functions/myPref.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late String? data;
  Map<String, String> keyValuePairs = {};
  List<MapEntry<String, String>>? entries = [];

  @override
  void initState() {
    super.initState();
    data = MyPref().getLoginData();
    if (data!.isNotEmpty) {
      String cleanedInput = data!.replaceAll(RegExp(r'^\{|\}$'), '');
      List<String> pairs = cleanedInput.split(', ');
      checkKeyValuePairs(pairs);
    }
  }

  void checkKeyValuePairs(List<String> pairs) {
    for (String pair in pairs) {
      // Split each pair by the first colon found
      List<String> parts = pair.split(': ');
      if (parts.length == 2) {
        String key = parts[0].trim();
        String value = parts[1].trim();
        keyValuePairs[key] = value;
      }
    }
    setState(() {
      entries = keyValuePairs.entries.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                MyPref().logout();
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: entries!.isNotEmpty
          ? Container(
              child: ListView.builder(
                  itemCount: entries!.length,
                  itemBuilder: (context, index) {
                    final entry = entries![index];
                    return ListTile(
                      leading: Text("${entry.key}"),
                      title: Text("${entry.value}"),
                    );
                  }))
          : Center(
              child: Text("No data available"),
            ),
    );
  }
}

import 'dart:convert';

import 'package:currency_convertor/Functions/mySharedref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class demo extends StatefulWidget {
  const demo({super.key});

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  late Future<List<dynamic>> jsonData;
  Future<List<dynamic>> fetchAPIdata() async {
    print("Fetching");
    final apiResponse = await http.post(
        Uri.parse("https://quranarbi.turk.pk/api/question"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"lesson_id": 28}));
    print(apiResponse.body);
    if (apiResponse.statusCode == 200) {
      var data = jsonDecode(apiResponse.body);
      // final List<Map<String, dynamic>> rates = jsonData;
      // print(jsonData);
      return data;
    } else {
      print("Failed to fetch From currency rates");
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // jsonData = fetchAPIdata();
    print(MySharedPrefrence().get_versioncode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Image(image: AssetImage("assets/images/icon.png"))
        // SingleChildScrollView(
        //   child: Container(
        //     padding: EdgeInsets.all(20),
        //     child: Column(
        //       children: [
        //         // Expanded(
        //         // child:
        //         FutureBuilder(
        //             future: jsonData,
        //             builder: (context, snapshot) {
        //               if (snapshot.connectionState == ConnectionState.waiting) {
        //                 return Center(
        //                   child: CircularProgressIndicator(),
        //                 );
        //               } else if (snapshot.hasError) {
        //                 return SizedBox(
        //                   height: 100,
        //                   child: Center(
        //                     child: Text("${snapshot.error}"),
        //                   ),
        //                 );
        //               } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        //                 print("The snapshot data is ${snapshot.data}");
        //                 return Center(
        //                   child: Text(
        //                     "Data received: ${jsonEncode(snapshot.data)}",
        //                     style: TextStyle(color: Colors.black),
        //                   ),
        //                 );
        //               } else {
        //                 return Center(child: Text("No data available"));
        //               }
        //             })
        //         // ListView.builder(
        //         //   itemCount: jsonData['conversion_rates'].length,
        //         //   itemBuilder: (context, index) {
        //         //     print(
        //         //         "Json data is ${jsonData['conversion_rates'].keys.elementAt(index)}");
        //         //     return Text(
        //         //       '${jsonData['conversion_rates'].keys.elementAt(index)}',
        //         //       style: TextStyle(color: Colors.black),
        //         //     );
        //         //   },
        //         // ),
        //         // )
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}

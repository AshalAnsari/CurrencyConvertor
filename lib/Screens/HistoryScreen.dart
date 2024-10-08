import 'package:flutter/material.dart';

class UserHistory extends StatefulWidget {
  List<Map<String, dynamic>> history;
  UserHistory({super.key, required this.history});

  @override
  State<UserHistory> createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  void DeleteHistory() {
    setState(() {
      widget.history = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Center(child: Text("History Screen")),
        actions: [
          IconButton(
              onPressed: () {
                DeleteHistory();
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.blueGrey[600]),
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: MediaQuery.sizeOf(context).width /
                      (MediaQuery.sizeOf(context).height * 0.15),
                ),
                itemCount: widget.history.length,
                itemBuilder: (context, index) {
                  final item = widget.history[index];
                  return Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        width: MediaQuery.sizeOf(context).width * 0.15,
                        height: MediaQuery.sizeOf(context).height * 0.10,
                        color: Colors.amber,
                        child: Icon(Icons.money, size: 24),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.50,
                        height: MediaQuery.sizeOf(context).height * 0.10,
                        color: Colors.blueGrey,
                        child: Center(
                          child: Text(
                            item['ConvertedAmount'] ?? '0.0',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.sizeOf(context).width * 0.05),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        width: MediaQuery.sizeOf(context).width * 0.30,
                        height: MediaQuery.sizeOf(context).height * 0.10,
                        color: Colors.teal,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'From: ${item['AmountFrom'] ?? 'Unknown'}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              'To: ${item['AmountTo'] ?? 'Unknown'}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

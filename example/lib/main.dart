import 'package:flutter/material.dart';
import 'package:sliver_stretchy_header/sliver_stretchy_header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SliverStretchyHeader Example"),
        ),
        body: CustomScrollView(
          slivers: [
            SliverStretchyHeader(
              minBlankExtent: 100,
              background: Container(
                color: Colors.red,
              ),
              child: Container(
                color: Colors.green,
                height: 60,
                child: Center(child: Text("Child Widget")),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Container(
                              height: 50,
                              child: Center(child: Text("$index"))
                          );
                        },
                  childCount: 50
                )
            )
          ],
        ),
      )
    );
  }
}


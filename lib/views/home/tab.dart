import 'package:flutter/material.dart';
import 'package:realworld/views/home/your_feed/your_feed_view.dart';
import 'package:realworld/views/home/global_feed/global_feed_view.dart';

class HomeTabScreen extends StatefulWidget {
  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxHeight: 150.0),
            child: Material(
              color: Colors.yellow,
              child: TabBar(
                indicatorColor: Colors.blue,
                indicatorWeight: 2.0,
                tabs: [
                  Tab(child: Text(
                    "YOUR FEED", style: TextStyle(color: Colors.black),
                  )),
                  Tab(child: Text(
                    "GLOBAL FEED", style: TextStyle(color: Colors.black),
                  )),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                YourFeedView(),
                GlobalFeedView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

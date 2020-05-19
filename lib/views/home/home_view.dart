import 'package:flutter/material.dart';
import 'package:realworld/utils/navigate.dart';
// import 'package:realworld/views/home/tab.dart';
import 'package:realworld/views/post/post_view.dart';
import 'package:realworld/views/root/root_bloc.dart';
//components
import 'package:realworld/views/home/home_tab.dart';
import 'package:realworld/views/home/home_drawer.dart';
//tabs
import 'package:realworld/views/home/your_feed/your_feed_view.dart';
import 'package:realworld/views/home/global_feed/global_feed_view.dart';

enum HomeState { GLOBAL, MY, PROFLE }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//SingleTickerProviderStateMixin: Managing animation execution time
class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  PageController _tabController;
  int _index;
  bool isAuthenticated = false;
  List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabController = PageController(keepPage: true);
    _index = 1;
  }

  @override
  Widget build(BuildContext context) {
    _tabs = [YourFeedView(), GlobalFeedView()];

    rootBloc.authenticated.listen((logged) {
      if (logged)
        setState(() {
          isAuthenticated = true;
        });
    });

    if (!isAuthenticated) _tabs.removeAt(0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Conduit'),
      ),
      body: Stack(
        children: <Widget>[getBody(), getBottom()],
      ),
      drawer: HomeDrawer(),
      floatingActionButton: StreamBuilder<bool>(
        stream: rootBloc.authenticated,
        initialData: false,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return snapshot.data
              ? FloatingActionButton(
                  onPressed: () {
                    push(context, PostView());
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.green,
                  mini: true)
              : Container();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked
    );
  }

  getBody() {
    return PageView(
      children: _tabs,
      controller: _tabController,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  getBottom() {
    return StreamBuilder(
      stream: rootBloc.authenticated,
      initialData: false,
      builder: (context, snapshot) {
        return snapshot.data
            ? HomeBottom(
                onChange: (index) {
                  _tabController.jumpToPage(index);
                  setState(() {
                    _index = index;
                  });
                },
                index: _index,
              )
            : Container();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:realworld/utils/navigate.dart';
import 'package:realworld/models/user.dart';
import 'package:realworld/views/login/login_form.dart';
import 'package:realworld/views/root/root_bloc.dart';
import 'package:realworld/views/about/about_view.dart';
import 'package:realworld/views/home/home_view.dart';
import 'package:realworld/views/account/account_view.dart';

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      Expanded(
          child: ListView(
        primary: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          headerDrawer(),
          listTileDrawer(),
        ],
      )),
    ]));
  }

  headerDrawer() {
    return DrawerHeader(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: StreamBuilder(
                    stream: rootBloc.user,
                    builder: (context, AsyncSnapshot<User> snapshot) {
                      return snapshot.hasData
                          ? GestureDetector(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipOval(
                                    child: Image.network(
                                  "${snapshot.data.image}",
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                )),
                                Text("${snapshot.data.username}",
                                    style: TextStyle(color: Colors.grey[700])),
                                Text("${snapshot.data.email}",
                                    style: TextStyle(color: Colors.grey[500]))
                              ],
                            ),
                            onTap: () {
                              push(context, AccountScreen());
                            }  
                          )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.asset('images/flutter_realworld.png')
                              ],
                            );
                    }))
          ],
        ),
      ),
      decoration: new BoxDecoration(color: Colors.blue[100]),
    );
  }

  routeDrawer() {
    return Column(
      children: <Widget>[
        Divider(color: Colors.black45),
        ListTile(
            leading: Icon(Icons.home, color: Colors.black, size: 20.0),
            trailing:
                Icon(Icons.chevron_right, color: Colors.black, size: 20.0),
            title: Text('Home',
                style: TextStyle(fontSize: 14.0, color: Colors.black)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return HomeScreen();
              }));
            }),
        Divider(color: Colors.black45),
        ListTile(
            leading: Icon(Icons.settings, color: Colors.green, size: 20.0),
            trailing:
                Icon(Icons.chevron_right, color: Colors.green, size: 20.0),
            title: Text('Settings',
                style: TextStyle(fontSize: 14.0, color: Colors.green)),
            onTap: () {}),
        ListTile(
            leading: Icon(Icons.info, color: Colors.green, size: 20.0),
            trailing:
                Icon(Icons.chevron_right, color: Colors.green, size: 20.0),
            title: Text('About',
                style: TextStyle(fontSize: 14.0, color: Colors.green)),
            onTap: () {
              AboutView(context);
            }),
      ],
    );
  }

  listTileDrawer() {
    return StreamBuilder(
      stream: rootBloc.authenticated,
      initialData: false,
      builder: (context, snapshot) {
        return !snapshot.data
            ? Column(
                children: <Widget>[
                  ListTile(
                      leading:
                          Icon(Icons.input, color: Colors.green, size: 20.0),
                      trailing: Icon(Icons.chevron_right,
                          color: Colors.green, size: 20.0),
                      title: Text('Login/Register',
                          style:
                              TextStyle(fontSize: 14.0, color: Colors.green)),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return LoginScreen();
                        }));
                      }),
                  routeDrawer(),
                ],
              )
            : Column(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.exit_to_app,
                          color: Colors.green, size: 20.0),
                      trailing: Icon(Icons.chevron_right,
                          color: Colors.green, size: 20.0),
                      title: Text('Logout',
                          style:
                              TextStyle(fontSize: 14.0, color: Colors.green)),
                      onTap: () {
                        rootBloc.logout().then((_) {
                          Navigator.of(context).pop();
                        });
                      }),
                  routeDrawer(),
                  Container(
                      child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                              color: Colors.green,
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                      title: Text(
                                          'Create by https://github.com/zendy199x',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.white,
                                              fontStyle: FontStyle.italic)),
                                      onTap: () {})
                                ],
                              ))))
                ],
              );
      },
    );
  }
}

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

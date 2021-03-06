import 'package:agrotaxi/custom_widgets/add_announcement_Widget.dart';
import 'package:agrotaxi/pages/announcements_page.dart';
import 'package:agrotaxi/pages/sign_up.dart';
import 'package:agrotaxi/pages/support_page.dart';
import 'package:agrotaxi/pages/user_profile_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroTaxi',
      routes: {
        '/': (context) => SignUpPage(),
      },
      initialRoute: '/',
      theme: ThemeData(
          primarySwatch: Colors.green,
          // backgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Colors.white,
          )),

      // home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _bottomNavBarController;

  List<Widget> _bottomNavBarItems = [
    AnnouncementsPage(),
    SupportPage(),
    UserProfilePage(),
  ];

  @override
  void initState() {
    super.initState();

    _bottomNavBarController = TabController(
        vsync: this, length: _bottomNavBarItems.length, initialIndex: 0);
    _bottomNavBarController
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          padding: EdgeInsets.all(4),
          width: 250,
          height: 70,
          child: Image.asset(
            "assets/images/agrotaxi_logo.png",
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          _bottomNavBarController.index == 0
              ? IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.showBottomSheet((context) {
                      return AddAnnouncementWidget();
                    });
                  },
                )
              : Container(),
        ],
      ),
      body: TabBarView(
        controller: _bottomNavBarController,
        children: _bottomNavBarItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavBarController.index,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Elanlar")),
          BottomNavigationBarItem(
              icon: Icon(Icons.live_help), title: Text("Əlaqə")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profil")),
        ],
        onTap: (index) {
          setState(() {
            _bottomNavBarController.animateTo(index);
          });
          print("Current bottom tab bar index is: $index");
        },
      ),
    );
  }
}

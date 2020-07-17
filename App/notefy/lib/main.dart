import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'notefy',
      theme: ThemeData().copyWith(primaryColor: Colors.white),
      home: FirstScreen(),
    );
  }
}
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: new Scaffold(
          body: TabBarView(
            children: [
              Container(
                color: Colors.orange,
              ),
              HomeScreen(),
              Container(
                color: Colors.lightGreen,
              ),
            ],
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: new TabBar(
              tabs: [
                Tab(
                  icon: new Icon(Icons.home,size: 35,),
                ),
                Tab(
                  icon: new Icon(Icons.rss_feed, size: 40,),
                ),
                Tab(
                  icon: new Icon(Icons.perm_identity,size: 35,),
                ),
              ],
              labelColor: kOrange,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

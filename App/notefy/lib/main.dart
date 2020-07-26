import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notefy/screens/loginScreen.dart';
import 'constants.dart';
import 'screens/HomeScreen.dart';
import 'screens/RegisterUser.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget screen1 = FirstScreen();
  Future<Null> getApiKey() async {
    final storage = new FlutterSecureStorage();
    final all = await storage.readAll();
    setState(() {
      if(all.isEmpty){
        screen1 = RegisterScreen();
      }
      else{
        print(all.values);
      }
    });
  }
  @override
  void initState() {
    getApiKey();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'notefy',
      theme: ThemeData().copyWith(primaryColor: Colors.white),
      home: LoginScreen(),
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
                  icon: new Icon(Icons.home,size: 45,),
                ),
                Tab(
                  icon: new Icon(Icons.rss_feed, size: 45,),
                ),
                Tab(
                  icon: new Icon(Icons.perm_identity,size: 55,),
                ),
              ],
              labelColor: kOrange,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(25.0),
              indicatorColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

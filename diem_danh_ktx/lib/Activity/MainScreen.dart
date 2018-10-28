import 'package:diem_danh_ktx/Fragment/HomeFragment.dart';
import 'package:diem_danh_ktx/Activity/VerifyQueueScreen.dart';
import 'package:flutter/material.dart';
import 'package:diem_danh_ktx/Fragment/PlaceholderWidget.dart';

class MainScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeFragment(),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green),
    VerifyQueueScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Danh sách chờ xác nhận'),
              onTap: () {
                // Update the state of the app
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerifyQueueScreen()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: new AppBar(
        title: new Text('Trang chu'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],),
    );
  }
}
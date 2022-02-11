import 'package:ad_app/home.dart';
import 'package:ad_app/profile.dart';
import 'package:ad_app/redeem.dart';
import 'package:ad_app/services.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({ Key? key }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

   final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
   int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {

    List tabs = [
      Home(),
      Redeem(),
      ProfilePage()
    ];

    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //    Image.asset('assets/coin.png', width: 30),
      //    const Text('343', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
      //   ],
      // ),
             body: tabs[_currentIndex],

        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.redeem, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.purple,
          buttonBackgroundColor: Colors.deepPurple,
          backgroundColor: Colors.purple,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
            _currentIndex = index;
        
            });
          },
          letIndexChange: (index) => true,
        )
    );
  }
}
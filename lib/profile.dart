import 'dart:io';
import 'package:ad_app/services.dart';
import 'package:ad_app/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


class ProfilePage extends StatefulWidget {




 
  const ProfilePage(
      {Key? key,


   
 })
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    int amt = box.read('coins');
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(
          children: [
               Align(
                 alignment: Alignment.topRight,
                 child: PopupMenuButton(
                             icon: Icon(Icons.more_vert, color: Colors.white),
                             onSelected: (value) {
                  box.erase();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
                             },
                             itemBuilder: (context) => [
                      const PopupMenuItem(
                        child: Text("logout"),
                        value: 1,
                      ),
                    ]),
               ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // ignore: unnecessary_null_comparison
              child: ClipOval(
                child: Image.asset(
                  'assets/male-avatar.jpg', height: 100
                ),
              )
            ),
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${box.read('firstName')} ${box.read('lastName')}',
                          style:
                              const TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                              
                    ],
                  ),
                  Text(box.read('username'))
                ],
              ),
            ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 16),
        child: Container(
         padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14)
          ),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Total Coins', style: TextStyle(color: Colors.grey)),
                  Row(
                    children: [
                      Image.asset('assets/coin.png', height: 20),
                      Text(box.read('coins').toString(), style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
              Divider(),
              Column(
                children:  [
                  const Text('Withdrawable', style: TextStyle(color: Colors.grey)),
                  Text('\$  ${(amt * .2).toStringAsFixed(2)}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                ],
              )
            ],
          )
        ),
      )
       
          ],
        ),
      ),
    );
  }
}


 

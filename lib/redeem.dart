import 'package:ad_app/paypal.dart';
import 'package:ad_app/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Redeem extends StatefulWidget {
  const Redeem({ Key? key }) : super(key: key);

  @override
  _RedeemState createState() => _RedeemState();
}

class _RedeemState extends State<Redeem> {

  bool giftCards = false;
  late Future future;

  @override
  void initState() {
   future = getUserCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
    Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.asset('assets/male-avatar.jpg', height: 30)
          ),
        ),
        Text(box.read('username'))
      ],
    ),
            const Padding(
              padding: EdgeInsets.only(left: 24, bottom: 8, top: 35),
              child: Align(
                alignment: Alignment.topLeft,
                child:  Text('TOTAL BALANCE:', style: TextStyle(color: Colors.grey))),
            ),
             Padding(
               padding: EdgeInsets.only(left: 24, bottom: 36),
               child: Align(
                 alignment: Alignment.topLeft,
                 child:  RefreshIndicator(
                   onRefresh: ()async { 
                     setState(() {
                       future = getUserCoins();
                     });
                    },
                   child: FutureBuilder(
                                 future:  future,
                                 builder: (BuildContext context,AsyncSnapshot snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                     int amt = snapshot.data['coins'];
                      return Text(snapshot.hasData ? '\$ ${( amt *  .2).toStringAsFixed(2)}' : 'Network Error; Swipe down to Retry', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold));
                    } else {
                      return Center(
                    child: CollectionSlideTransition(
                      children:  const <Widget>[
                        Icon(Icons.circle, color: Colors.orange, size: 15),
                        Icon(Icons.circle, color: Colors.orange, size: 15),
                        Icon(Icons.circle, color: Colors.orange, size: 15),
                      ],
                    ),
                                 );
                    }
                    
                                 }
                               ),
                 ),
                // child: Text('\$  3400.00', style: TextStyle())),
             ),
             ),
    
   const Padding(
              padding: EdgeInsets.only(left: 24, bottom: 8, top: 35),
              child: Align(
                alignment: Alignment.topLeft,
                child:  Text('CHOOSE PAYMENT METHODS:', style: TextStyle(color: Colors.grey))),
            ),

          Card(
            child: ListTile(
              leading: const FaIcon(FontAwesomeIcons.paypal, color: Colors.blue),
              onTap: () => payPalDialog(context),
              title: const Text('Paypal'),
              trailing: const Icon(Icons.navigate_next),
              subtitle: const Text('Recieve Payment with your paypal account', style: TextStyle(color: Colors.grey)),
            )),

                    Card(
            child: ListTile(
              leading: Icon(Icons.redeem, color: Colors.red),
              onTap: () => bottomModel(context),
              title: Text('Gift Cards'),
              trailing: Icon(Icons.arrow_drop_down),
              subtitle: Text('Recieve Payment with  Gift Cards', style: TextStyle(color: Colors.grey)),
            )),

 

        ],
      ),
    );
  }
}

// Target
// Walmart
// Starbucks
// iTunes
// Visa Gift Card
// Google Play
// Chick-Fil-A
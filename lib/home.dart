import 'package:ad_app/ad_manager.dart';
import 'package:ad_app/services.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

 RewardedAd? _rewardedAd;

    @override
  void initState() {
    loadRewardAd(context);
    super.initState();
  }

loadRewardAd( BuildContext context){
     RewardedAd
    .load(
    adUnitId: adUnit,
     request: const AdRequest(), 
             rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            print('\ loaded  Ad \ Successfully');
            _rewardedAd = ad;
          int  _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
               
        loadRewardAd(context);
          },
             )
     );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.deepPurple,

     body: SafeArea(
       child: Column(
          children: [
     
            
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                   children:[ 
                     Image.asset('assets/coin.png', height: 20),
                      Text(box.read('coins').toString(), style: TextStyle(fontWeight: FontWeight.bold))
                   ]
                 ),
               ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Card(
                child: Container(
                  width: double.infinity,
                
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18, left: 8, bottom: 10),
                        child: Row(
                          children: [
                            const Text('EARN ', style: TextStyle(fontWeight: FontWeight.bold)),
                          Image.asset('assets/coin.png', height: 20),
                           const Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const Text('You would be rewarded to Watch video ads'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18, top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(240, 50),
                            primary: Colors.purple
                          ),
                          onPressed: (){
                            if(_rewardedAd != null){
                              _rewardedAd!.show(
                                onUserEarnedReward: (RewardedAd ad, RewardItem reward) async {
                                 
                                 int coin = box.read('coins');
                                 print(coin);
                                 setState(() {
                                  
                                   box.write('coins', (coin + 1));
                                   print(box.read('coins'));
                                 });
                                 
                                 loadRewardAd( context);
                                 await addCoins();
                                  });
                            }else {
                                                 ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Rewarded Ad not fully initialized")));
                            }
                          }, 
                          child: const Text('WATCH AD')),
                      )
                    ]
                  )
                ),
              ),
            ),
          ],
        ),
     ),
    );
  }
}
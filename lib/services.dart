import 'dart:math';
import 'package:ad_app/models.dart';
import 'package:ad_app/paypal.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:mime/mime.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';

Color rightOptionColor = Colors.green;
Color wrongOptionColor = Colors.red;
Color normalOptionColor = Colors.black26;
final box = GetStorage();

String androidAdUnit = "ca-app-pub-3269157427243386/3336292970";
String ioSAdUnit = "ca-app-pub-3269157427243386/2430868437";
String adUnit = Platform.isAndroid ? androidAdUnit : ioSAdUnit;
String host = 'https://lemon-vpn.herokuapp.com';
Uri paypalUri = Uri.parse('https://lemon-vpn.herokuapp.com/api/v1/addPayments');
Uri giftCardUri = Uri.parse('https://lemon-vpn.herokuapp.com/api/v1/addgiftCard');

Uri signInUrl = Uri.parse('$host/api/v1/SignIn');
Uri signUpUrl = Uri.parse('$host/api/v1/SignUp');
Uri getProfile = Uri.parse('$host/api/v1/getUser');
Uri getLeaderBoardUri = Uri.parse('$host/api/v1/getTotalleaderboard');
Uri localhostUrl = Uri.parse('$host/api/v1/uploadProfileImage');
Uri updateUserPointsUri =
    Uri.parse('https://wa-trivia.herokuapp.com/api/v1/addPoints');
Map<String, String> accessHeader = {'x-access-token': box.read('token')};


recievePayment(BuildContext context, String amount, String email) async {
  try {
    
    customAuthLoader(context);
    var res = await http.post(
      paypalUri,
        headers: accessHeader, body: {"clientEmail": email, "amount": amount});

        if(res.statusCode == 400){
               Navigator.of(context).pop();
     Navigator.of(context).pop();
     MotionToast.warning(
       description: Text("You don't have sufficient Coins to complete this transaction"),
      title: Text("Insufficient Coins",style: TextStyle(fontWeight: FontWeight.bold)),
      width: 300
     ).show(context);
        }

    if (res.statusCode == 200) {
      // ignore: avoid_print
      print(res.body);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      MotionToast.success(
              title: const Text("Success",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              description: const Text("payment have been successfully"),
              width: 300)
          .show(context);
          
      return res.body;
    } else {
      print(res.body);
      print(res.statusCode);
      Navigator.of(context).pop();
      MotionToast.error(
              title: const Text("Error",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              description: const Text("An Error Occurred"))
          .show(context);
      
    }
  } catch (e) {
    print(e);
     Navigator.of(context).pop();
         MotionToast.error(
              title: const Text("Error",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              description: const Text("An Error Occurred, Check your Internet Connection and Try again."))
          .show(context);
     
  }
}

comments(
  File imageFile,
) async {
  try {
    var filename = basename(imageFile.path);
    print(imageFile.path);
    final mimeType = lookupMimeType(imageFile.path);
    print(mimeType);
    print('Please Just Print Thses out');
    String mimee = mimeType!.split('/')[0];
    String type = mimeType.split('/')[1];
    var request = http.MultipartRequest("POST", localhostUrl)
      ..headers['Content-Type'] = mimeType
      ..headers.addAll(accessHeader);
    var stream = http.ByteStream(imageFile.openRead())..cast();
    var multipartFileSign = http.MultipartFile(
        'image', stream, await imageFile.length(),
        filename: filename, contentType: MediaType(mimee, type));
    request.files.add(multipartFileSign);
    var res = await request.send();
    res.stream.transform(utf8.decoder).forEach((string) {
      print(string);
    });
    print(res.statusCode);
    print(res.statusCode);
    if (res.statusCode == 201) {
      print('Upload successfull');
    } else {
      print('unsuccessful');
    }
  } catch (e) {
    print(e);
  }
}

updateUserPoints(int points) async {
  try {
    var res = await http.patch(updateUserPointsUri,
        headers: accessHeader, body: {'points': points.toString()});
    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      print(res.statusCode);
    }
  } catch (e) {
    print(e);
  }
}

addCoins() async {
  Uri addPointsUri = Uri.parse('$host/api/v1/addCoins');
  try {
    var res = await http.patch(addPointsUri, headers: accessHeader);
    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {}
  } catch (e) {
    print(e);
  }
}

getUserCoins() async {
  Uri pointsUrl = Uri.parse('$host/api/v1/getUserCoins');
  try {
    var res = await http.get(pointsUrl, headers: accessHeader);
    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      print(res.statusCode);
    }
  } catch (e) {
    print(e);
  }
}

getUserProfile() async {
  try {
    var res = await http.get(getProfile, headers: accessHeader);
    if (res.statusCode == 200) {
      print(res.body);
      return User.fromJson(json.decode(res.body));
    } else {
      print(res.statusCode);
    }
  } catch (e) {
    print(e);
  }
}

getLeaderBoard() async {
  try {
    var res = await http.get(getLeaderBoardUri, headers: accessHeader);
    if (res.statusCode == 200) {
      var jsonMap = json.decode(res.body);
      List<User> list = List.from(jsonMap.map((e) => User.fromJson(e)));
      return list;
    } else {
      print(res.statusCode);
    }
  } catch (e) {
    print(e);
  }
}

class RandomColor {
  static final randomInt = Random();
  final Color color;

  RandomColor()
      : color = Color.fromARGB(
          randomInt.nextInt(200),
          randomInt.nextInt(250),
          randomInt.nextInt(250),
          randomInt.nextInt(250),
        );
}

customAuthLoader(BuildContext context) {
  return showGeneralDialog(
      context: context,
      pageBuilder:
          (BuildContext context, Animation<double> ii, Animation<double> d) {
        return Container(
            color: Colors.black12,
            child: Center(
              child: CollectionSlideTransition(
                children: const <Widget>[
                  Icon(Icons.circle, color: Colors.orange, size: 35),
                  Icon(Icons.circle, color: Colors.purple, size: 35),
                  Icon(Icons.circle, color: Colors.orange, size: 35),
                ],
              ),
            ));
      });
}



bottomModel(BuildContext context){
  return showModalBottomSheet(
    context: context,
      shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.circular(10.0)),
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
           
            title: const Text('Target'),
            onTap: () {
              giftCardDialog(context, 'Target');
            },
          ),
          ListTile(
            
            title: new Text('Walmart'),
            onTap: () {
            giftCardDialog(context, 'Walmart');
            },
          ),
          ListTile(
            
            title: new Text('Starbucks'),
            onTap: () {
            giftCardDialog(context, 'Starbucks');
            },
          ),
          ListTile(

            title: new Text('iTunes'),
            onTap: () {
             giftCardDialog(context, 'iTunes');
            },
          ),
            ListTile(
            
            title: new Text('Visa Gift Card'),
            onTap: () {
            giftCardDialog(context, 'Visa Gift Card');
            },
          ),
           ListTile(
           
            title: new Text('Google Play'),
            onTap: () {
              giftCardDialog(context, 'Google Play');
            },
          ),
           ListTile(
           
            title: new Text('Chick-Fil-A'),
            onTap: () {
              giftCardDialog(context, 'chick-Fil-A');
            },
          ),
        ],
      );
    });
}


recieveGiftCard(BuildContext context, String amount, String email, String giftCard) async {
  try {
    
    customAuthLoader(context);
    var res = await http.post(
      giftCardUri,
        headers: accessHeader, body: {"clientEmail": email, "amount": amount, "giftCard": giftCard});

        if(res.statusCode == 400){
               Navigator.of(context).pop();
     Navigator.of(context).pop();
     MotionToast.warning(
       description: Text("You don't have sufficient Coins to complete this transaction"),
      title: Text("Insufficient Coins",style: TextStyle(fontWeight: FontWeight.bold)),
      width: 300
     ).show(context);
        }

    if (res.statusCode == 200) {
      // ignore: avoid_print
      print(res.body);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      MotionToast.success(
              title: const Text("Success",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              description: const Text("payment have been successfully"),
              width: 300)
          .show(context);
          
      return res.body;
    } else {
      print(res.body);
      print(res.statusCode);
      Navigator.of(context).pop();
      Navigator.pop(context);
      MotionToast.error(
              title: const Text("Error",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              description: const Text("An Error Occurred"))
          .show(context);
      
    }
  } catch (e) {
    print(e);
     Navigator.of(context).pop();
     Navigator.of(context).pop();
         MotionToast.error(
              title: const Text("Error",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              description: const Text("An Error Occurred, Check your Internet Connection and Try again."))
          .show(context);
     
  }
}

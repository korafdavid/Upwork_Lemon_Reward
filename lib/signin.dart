import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ad_app/dashboard.dart';
import 'package:ad_app/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ad_app/sign_up.dart';
import 'package:motion_toast/motion_toast.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool hideText = true;
  String errorText = '';
  bool hasError = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signIn(BuildContext context, String email, String password) async {
    var body = {"emailOrUsername": email, "password": password};
    customAuthLoader(context);
    try {
      var res = await http.post(signInUrl, body: body);
      print(res.statusCode);
      print(res.body);
      switch (res.statusCode) {
        case 200:
          Navigator.of(context).pop();
          await box.write('token', json.decode(res.body)['token']);
          await box.write('firstName', json.decode(res.body)['firstName']);
          await box.write('username', json.decode(res.body)['username']);
          await box.write('lastName', json.decode(res.body)['lastName']);
          await box.write('profilephoto', json.decode(res.body)['profilephoto']);
          await box.write('coins', json.decode(res.body)['coins']);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const Dashboard(
                      // firstName: json.decode(res.body)['firstName'],
                      // lastName: json.decode(res.body)['lastName'],
                      // username: json.decode(res.body)['username'],
                      // profilephoto: json.decode(res.body)['profilephoto'],
                      )));
          break;
        case 400:
          Navigator.of(context).pop();
          MotionToast.error(
                  title: const Text("Error",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  description: const Text("Please fill the Required fields"))
              .show(context);
          break;
        case 403:
          Navigator.of(context).pop();
          MotionToast.error(
                  title: const Text("Error",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  description: const Text("Incorrect Username or Password"))
              .show(context);
          break;
        default:
      }
    } catch (e) {
      if (e is SocketException) {
        Navigator.of(context).pop();
               MotionToast.error(
	title:  const Text("Error", style: TextStyle(fontWeight: FontWeight.bold)),
	description:  const Text("Check your Internet Connection and try again")
).show(context);
      
      }
      if (e is HttpException) {
        Navigator.of(context).pop();

      }
      if (e is TimeoutException) {
        Navigator.of(context).pop();
                       MotionToast.error(
	title:  const Text("Error", style: TextStyle(fontWeight: FontWeight.bold)),
	description:  const Text("Connection TimedOut")
).show(context);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
            )),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Please sign in to Continue'),
            )),
        Form(
          key: formkey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Add a valid email or username";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      errorText: hasError ? errorText : null,
                      hintText: "Email Or Username",
                      hintStyle: TextStyle(color: Color(0xFFA3BDB4)),
                      isDense: true,
                      filled: true,
                      //  fillColor: Color(0xFFF7FCFA),

                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD0E2DC)),
                          borderRadius: BorderRadius.circular(15)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFD0E2DC)),
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 6, 20, 10),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: hideText,
                    obscuringCharacter: '*',
                    validator: (value) {
                      if (value!.length < 3) {
                        return "Weak password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hideText = !hideText;
                              });
                            },
                            icon: Icon(
                              hideText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            )),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Color(0xFFA3BDB4)),
                        isDense: true,
                        filled: true,
                        // fillColor: const Color(0xFFF7FCFA),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFD0E2DC)),
                            borderRadius: BorderRadius.circular(15)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFD0E2DC)),
                            borderRadius: BorderRadius.circular(15))),
                  )),
            ],
          ),
        ),
        // const Align(
        //     alignment: Alignment.centerLeft,
        //     child: Padding(
        //       padding: EdgeInsets.all(8.0),
        //       child: Text('Forget Password',
        //           style: TextStyle(color: Colors.orange)),
        //     )),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                  onPressed: () {
                    var form = formkey.currentState;
                    if (formkey.currentState!.validate()) {
                      signIn(context, emailController.text,
                          passwordController.text);
                    }
                  },
                  icon: Icon(Icons.arrow_back),
                  label: Text(
                    'Login',
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 7,
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)))),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('Don\'t have an account? '),
            InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp())),
                child: Text('Register here',
                    style: TextStyle(color: Colors.orange)))
          ],
        )
      ]),
    );
  }
}


//adcolony
//appodeal
//mopub
//appmetrica

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ad_app/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:ad_app/services.dart';
import 'package:ad_app/signin.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
    final _formkey = GlobalKey<FormState>();
 bool hideText = true;
  final _ctrlEmail = TextEditingController();
  final _ctrlfirstName = TextEditingController();

  final _ctrlLastName = TextEditingController();
  final _ctrlConfirmPassword = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
 bool signUpfail = false;
   String errorMessage = "";
  String selectedCountry = "Nigeria";
    List gender=["Male","Female","Other"];
  String selectedGender = '';



  @override
  initState(){

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.deepPurple,
        body:  SafeArea(
          child: Form(
            key: _formkey,
                child: ListView(
                  children: [
                     Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                          child: Text('Sign Up', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold))),
                     ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 20, bottom: 5, left: 20),
                      child: TextFormField(
                        controller: _ctrlfirstName,
                        keyboardType: TextInputType.text,
                        
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Add a valid Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            errorText: signUpfail ? errorMessage : null,
                            hintText: "FirstName",
                            hintStyle: TextStyle(color: Color(0xFFA3BDB4)),
                            isDense: true,
                            filled: true,
                        
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFD0E2DC)),
                                borderRadius: BorderRadius.circular(15)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFD0E2DC)),
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: TextFormField(
                        controller: _ctrlLastName,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field can't be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            errorText: signUpfail ? errorMessage : null,
                            hintText: "LastName",
                            hintStyle: TextStyle(color: Color(0xFFA3BDB4)),
                            isDense: true,
                            filled: true,
                            
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFD0E2DC)),
                                borderRadius: BorderRadius.circular(15)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFD0E2DC)),
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
        
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                      child: TextFormField(
                        controller: _ctrlEmail,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field can't be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            errorText: signUpfail ? errorMessage : null,
                            hintText: "Email",
                            hintStyle: TextStyle(color: Color(0xFFA3BDB4)),
                            isDense: true,
                            filled: true,
                            
                            prefixIcon: Icon(Icons.mail),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFD0E2DC)),
                                borderRadius: BorderRadius.circular(15)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFD0E2DC)),
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                     
            

                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                        child: TextFormField(
                          controller: _ctrlPassword,
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
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 6, 20, 10),
                        child: TextFormField(
                          controller: _ctrlConfirmPassword,
                          obscureText: hideText,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value != _ctrlPassword.text) {
                              return "Password not Confirmed";
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
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(color: Color(0xFFA3BDB4)),
                              isDense: true,
                              filled: true,
                              
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
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
                      child: MaterialButton(
                          onPressed: () {
                            if(_formkey.currentState!.validate()){
                            
                                         register(
                                           context: context,
                                          email: _ctrlEmail.text, 
                                          password: _ctrlPassword.text, 
                                          firstName: _ctrlfirstName.text,
                                           lastName: _ctrlLastName.text
                                      );
                            }
                          },
                          height: 50,
                          minWidth: MediaQuery.of(context).size.width / 2,
                          color: Colors.orange,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26)),
                          child: Text('Register', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    ),
                    Padding(
                      padding:
                       const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Already have an account? '),
                          InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn())),
                              child: Text('Login',
                                  style: TextStyle(color: Colors.orange)))
                        ],
                      ),
                    )
                  ],
                ),
              ),
        )
        );
  }



     register({
    required BuildContext context,
  required String email,
  required  String password,
  required  String firstName,
  required  String lastName,

  }
    ) async {
    Map body = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "password": password
    };
    try {
      customAuthLoader(context);
      var res = await http.post(signUpUrl, body: body);
      print(res.statusCode);
      print(res.body);
      switch (res.statusCode) {
        case 201:
         Navigator.of(context).pop();
          box.write('token', json.decode(res.body)['token']);
               await box.write('firstName', json.decode(res.body)['firstName']);
          await box.write('username', json.decode(res.body)['username']);
          await box.write('lastName', json.decode(res.body)['lastName']);
          await box.write(
              'profilephoto', json.decode(res.body)['profilephoto']);
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
          case 409:
          Navigator.of(context).pop();
                 MotionToast.error(
                  title: const Text("Error",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  description: const Text("User Already Exits")).show(context);
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
        print('httpExcecprion');
      }
      if (e is TimeoutException) {
        Navigator.of(context).pop();
                Navigator.of(context).pop();
                       MotionToast.error(
	title:  const Text("Error", style: TextStyle(fontWeight: FontWeight.bold)),
	description:  const Text("Connection TimedOut")
).show(context);
      }
    }
  }



}
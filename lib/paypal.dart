import 'package:ad_app/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_paypal/flutter_paypal.dart';


payPalDialog(BuildContext context){
  return showDialog(context: context, builder: (context) {
      final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController tokenController = TextEditingController();

    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child:                   Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: ()=> Navigator.of(context).pop(),
                          icon: Icon(Icons.cancel, color: Colors.red)
                        )
                      ),
                     const FaIcon(FontAwesomeIcons.paypal,size: 43, color: Colors.blue),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Add a your Paypal email Address";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Paypal Email Address',
                    
                              hintStyle: TextStyle(color: Color(0xFFA3BDB4)),
                              isDense: true,
                              filled: true,
                            //  fillColor: Color(0xFFF7FCFA),
                              
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFD0E2DC)),
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
                            controller: tokenController,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please fill in Token Amount";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                             
                                hintText: 'Token Amount',
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
                                                 Padding(
                      padding: const EdgeInsets.only(bottom: 18, top: 9),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50),
                        ),
                        onPressed: (){
                         recievePayment(context,tokenController.text, emailController.text);
                        
                        }, 
                        child: const Text('TRANSFER')),
                    )
                    ],
                  ),
                ),
    );
  });
}


giftCardDialog(BuildContext context, String giftCard){
  return showDialog(context: context, builder: (context) {
      final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController tokenController = TextEditingController();

    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child:                   Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: ()=> Navigator.of(context).pop(),
                          icon: Icon(Icons.cancel, color: Colors.red)
                        )
                      ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(giftCard.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                     ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Add a your Paypal email Address";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Paypal Email Address',
                    
                              hintStyle: TextStyle(color: Color(0xFFA3BDB4)),
                              isDense: true,
                              filled: true,
                            //  fillColor: Color(0xFFF7FCFA),
                              
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFD0E2DC)),
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
                            controller: tokenController,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please fill in Token Amount";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                             
                                hintText: 'Token Amount',
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
                                                 Padding(
                      padding: const EdgeInsets.only(bottom: 18, top: 9),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50),
                        ),
                        onPressed: (){
                        recieveGiftCard(context, tokenController.text, emailController.text, giftCard);
                        
                        }, 
                        child: const Text('TRANSFER')),
                    )
                    ],
                  ),
                ),
    );
  });
}

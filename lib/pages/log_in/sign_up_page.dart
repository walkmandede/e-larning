

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning/globals_methods.dart';
import 'package:e_learning/globals_variables.dart';
import 'package:e_learning/pages/home/home_main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_main_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController txtSignUpUsername = TextEditingController(text: '');
  TextEditingController txtSignUpPassword = TextEditingController(text: '');
  TextEditingController txtSignUpConfirm = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: getTextScaleFactor(context),
        child: registerPage()
    );
  }

  Widget registerPage(){
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios,color: color1,),
            onPressed: (){
              loginPageController.value.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeOutSine);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: screenWidth(context)*0.045),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                height: screenHeight(context)*0.12,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Image.asset('images/logo.png'),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight(context)*0.02),
                child: Text(localizedTexts('Sign up to create your new account'),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4,),
                padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.12)
                ),
                child: TextField(
                  style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: color2),
                  controller: txtSignUpUsername,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: localizedTexts('Email or Phone Number'),
                    hintStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),
                    // fillColor: Colors.grey.withOpacity(0.15),
                    // filled: true
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.12)
                ),
                child: TextField(
                  style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: color2),
                  controller: txtSignUpPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: localizedTexts('Password'),
                    hintStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),
                    // fillColor: Colors.grey.withOpacity(0.15),
                    // filled: true
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.12)
                ),
                child: TextField(
                  style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: color2),
                  controller: txtSignUpConfirm,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: localizedTexts('Confirm Password'),
                    hintStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),
                    // fillColor: Colors.grey.withOpacity(0.15),
                    // filled: true
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  decoration: BoxDecoration(
                    color: color2,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(localizedTexts('Register',),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
                ),
                onTap: (){
                  onClickRegister();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onClickRegister() {
    pushReplacement(context, const HomeMainPage());
  }
}

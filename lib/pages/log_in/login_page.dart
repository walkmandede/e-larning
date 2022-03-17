

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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Rx<bool> hasCheckedRememberMe = false.obs;
  TextEditingController txtLoginUsername = TextEditingController(text: '');
  TextEditingController txtLoginPassword = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: getTextScaleFactor(context),
        child: signInPage()
    );
  }

  Widget signInPage(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: screenWidth(context)*0.045),
      child: Column(
        children: [
          SizedBox(height: screenHeight(context)*0.075,),
          Container(
            height: screenHeight(context)*0.15,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Image.asset('images/logo.png'),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: screenHeight(context)*0.035),
            child: Text(localizedTexts('Sign in to your account'),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4,),
            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.12)
            ),
            child: TextField(
              style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: color2),
              controller: txtLoginUsername,
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
              controller: txtLoginPassword,
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
          Row(
            children: [
              Obx(
                ()=> Checkbox(
                    value: hasCheckedRememberMe.value,
                    fillColor: MaterialStateColor.resolveWith((states) => color1),
                    onChanged: (result){
                      hasCheckedRememberMe.value = result!;
                    }),
              ),
              Text(localizedTexts('Remember me'),style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 12),)
            ],
          ),
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
              child: Text(localizedTexts('Sign In',),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
            ),
            onTap: (){
              onClickSignIn();
            },
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Text(localizedTexts('Forgot the password?',),style: const TextStyle(fontWeight: FontWeight.w400,),)
          ),
          Container(
            padding: EdgeInsets.all(screenHeight(context)*0.035),
            child: Text(localizedTexts('Or continue with',),style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.withOpacity(0.3))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset('icons/fb_icon.svg',width: 20),
                        const Text('Facebook')
                      ],
                    ),
                  ),
                  onTap: () async{
                    final LoginResult result = await FacebookAuth.instance.login();
                    if(result.status == LoginStatus.success){
                      // Create a credential from the access token
                      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
                      // Once signed in, return the UserCredential
                      UserCredential _user = await FirebaseAuth.instance.signInWithCredential(credential);
                      _user.user;
                    }
                  },
                ),
              ),
              SizedBox(width: screenWidth(context)*0.045,),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.withOpacity(0.3))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset('icons/google_icon.svg',width: 20,),
                        const Text('Google')
                      ],
                    ),
                  ),
                  onTap: () async{
                    GoogleSignIn _googleSignIn = GoogleSignIn();
                    try {
                       GoogleSignInAccount? _user= await _googleSignIn.signIn();
                       if(_user!=null){
                         showDialog(context: context, builder: (BuildContext context){
                           GoogleSignInAccount user = _user;
                           return AlertDialog(
                             scrollable: true,
                             title: Column(
                               children: [
                                 CachedNetworkImage(
                                   imageUrl: user.photoUrl!,
                                   placeholder: (_,__){
                                     return const CircularProgressIndicator();
                                   },
                                 ),
                                 const SizedBox(height: 20,),
                                 Text(user.id),
                                 Text(user.email)
                               ],
                             ),
                           );
                         });
                       }

                      await _googleSignIn.disconnect();
                    } catch (error) {
                      error;
                    }
                    },
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(localizedTexts('Don\'t have an account?')),
                  TextButton(onPressed: () {
                    loginPageController.value.animateToPage(1, duration: const Duration(milliseconds: 400), curve: Curves.easeOutSine);
                  }, child: Text(localizedTexts('Sign Up')))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  void onClickSignIn() {
    pushReplacement(context, const HomeMainPage());
  }
}

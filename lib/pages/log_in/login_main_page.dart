

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning/globals_methods.dart';
import 'package:e_learning/globals_variables.dart';
import 'package:e_learning/pages/home/home_main_page.dart';
import 'package:e_learning/pages/log_in/login_page.dart';
import 'package:e_learning/pages/log_in/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

Rx<PageController> loginPageController = PageController().obs;

class LoginMainPage extends StatefulWidget {
  const LoginMainPage({Key? key}) : super(key: key);

  @override
  _LoginMainPageState createState() => _LoginMainPageState();
}

class _LoginMainPageState extends State<LoginMainPage> {


  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: getTextScaleFactor(context),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            color: Colors.white,
            child: Column(
              children: [
                topPadding(context),
                Expanded(
                  child: PageView(
                    controller: loginPageController.value,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      LoginPage(),
                      SignUpPage()
                    ],
                  ),
                ),
                botPadding(context),
              ],
            ),
          ),
        )
    );
  }
}

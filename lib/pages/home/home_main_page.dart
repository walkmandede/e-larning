

import 'dart:ui';
import 'package:e_learning/globals_variables.dart';
import 'package:e_learning/pages/home/home_certificate_page.dart';
import 'package:e_learning/pages/home/home_course_page.dart';
import 'package:e_learning/pages/home/home_home_page.dart';
import 'package:e_learning/pages/home/home_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

enum HomePages {
  home,courses,certificate,profile
}

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({Key? key}) : super(key: key);

  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {

  Rx<HomePages> currentHomePage = HomePages.home.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: getTextScaleFactor(context),
      child: Scaffold(
        body: Column(
          children: [
            topPadding(context),
            Obx(
                ()=> Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    showPage(),
                    bottomNaviBar(),
                  ],
                ),
              ),
            ),
            botPadding(context)
          ],
        ),
      ),
    );
  }

  Widget bottomNaviBar(){
    return Container(
      height: screenHeight(context)*0.07,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.3)))
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect( // Clip it cleanly.
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: const Color(0xfffafafa).withOpacity(0.8),
                alignment: Alignment.center,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                eachNaviItemWidget('icons/home_icon.svg', HomePages.home, 'Home'),
                eachNaviItemWidget('icons/course_icon.svg', HomePages.courses, 'Courses'),
                eachNaviItemWidget('icons/certificate_icon.svg', HomePages.certificate, 'Certificate'),
                eachNaviItemWidget('icons/profile_icon.svg', HomePages.profile, 'Profile'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showPage(){
    if(currentHomePage.value == HomePages.home){
      return const HomeHomePage();
    }
    else if(currentHomePage.value == HomePages.courses){
      return const HomeCoursePage();
    }
    else if(currentHomePage.value == HomePages.certificate){
      return const HomeCertificatePage();
    }
    else if(currentHomePage.value == HomePages.profile){
      return const HomeProfilePage();
    }
    else{
      return const HomeHomePage();
    }
  }

  Widget eachNaviItemWidget(String iconPath,HomePages homePageType,String text){
    return GestureDetector(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: const Color(0xff003972).withOpacity(0.05),
              borderRadius: BorderRadius.circular(8)
          ),
          child:
          currentHomePage.value==homePageType?
          Row(
            children: [
              SvgPicture.asset(iconPath),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(text,style: const TextStyle(color: Color(0xff003972),fontWeight: FontWeight.w500),)
              ),
            ],
          ):
          SvgPicture.asset(iconPath)
      ),
      onTap: (){
        currentHomePage.value = homePageType;
      },
    );
  }

}




import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_learning/globals_methods.dart';
import 'package:e_learning/globals_variables.dart';
import 'package:e_learning/pages/others/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeProfilePage extends StatefulWidget {
  const HomeProfilePage({Key? key}) : super(key: key);

  @override
  _HomeProfilePageState createState() => _HomeProfilePageState();
}

class _HomeProfilePageState extends State<HomeProfilePage> {

  Rx<String> selectedCourse = 'All Course'.obs;
  TextEditingController txtFullName = TextEditingController(text: 'Daniel Sebastian');
  TextEditingController txtEmail = TextEditingController(text: 'danielsebastian@gmail.com');
  TextEditingController txtDoB = TextEditingController(text: 'December 27, 1992');
  TextEditingController txtGender = TextEditingController(text: 'Male');
  TextEditingController txtAddress = TextEditingController(text: 'Thingangyun, Yangon.');

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

  List<Widget> appBarWidgets(){
    return [
      GestureDetector(
        onTap: () {
          push(context, const SettingPage());
        },
        child: SvgPicture.asset('icons/setting_icon.svg'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: getTextScaleFactor(context),
      child: Scaffold(
        body: Column(
          children: [
            eLearningAppBar(context,'My Profile',appBarWidgets()),
            profileHeaderPanel(),
            profileBodyPanel()
          ],
        )
      ),
    );
  }


  Widget profileHeaderPanel(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: screenWidth(context)*0.085,
            backgroundImage: Image.asset('images/profile1.png').image,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Daniel Sebastian',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Text('danielsebastian@gmail.com',style: TextStyle(color: Colors.grey.withOpacity(0.8),fontSize: 14),),
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Widget profileBodyPanel(){
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        width: double.infinity,
        child: ListView(
          children: [
            eachTextFiledWidget('Full Name', txtFullName),
            eachTextFiledWidget('Email', txtEmail),
            eachTextFiledWidget('Date of Birth', txtDoB),
            eachTextFiledWidget('Gender', txtGender),
            eachTextFiledWidget('Address', txtAddress),
          ],
        )
      ),
    );
  }

  Widget eachTextFiledWidget(String labelText,TextEditingController txtController){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText,style: TextStyle(color: Colors.grey.withOpacity(0.8),fontWeight: FontWeight.w500),),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2,vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.withOpacity(0.2))
            ),
            child: TextField(
              controller: txtController,
              decoration: const InputDecoration(
                  enabled: false,
                  border: InputBorder.none
              ),
            ),
          )
        ],
      ),
    );
  }

}


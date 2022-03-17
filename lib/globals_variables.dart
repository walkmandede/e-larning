library my_prj.globalsvariables;

import 'package:e_learning/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'globals_methods.dart';
import 'package:http/http.dart' as http;


var client = http.Client();
String baserUrl = 'https://xbots.chat/api/';


Rx<Language> appLanguage = Rx<Language>(Language.en);


const Color color1 = Color(0xff02ace0);
const Color colorBg = Color(0xfffafafa);
const Color color2 = Color(0xff003249);
const Color color3 = Color(0xff2b7bfa);
// Rx<double> defaultTextScaleFactor = Rx<double>(1);
double defaultTextScaleFactor = 1;

Widget topPadding(BuildContext context){
  return Container(
    color: Colors.white,
    height: MediaQuery.of(context).viewPadding.top,);
}

Widget botPadding(BuildContext context){
  return SizedBox(height: MediaQuery.of(context).viewPadding.bottom,);
}

MediaQueryData getTextScaleFactor(BuildContext context){
  return MediaQuery.of(context).copyWith(textScaleFactor: defaultTextScaleFactor);
}


String localizedTexts(String string){
  if(appTexts[string]==null){
    return string;
  }
  else{
    return appTexts[string]![appLanguage]!;
  }
}


double screenHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

BorderRadius defaultBorderRadius(double radius){
  return BorderRadius.all(Radius.circular(radius));
}

Widget eLearningAppBar(BuildContext context,String labelText,List<Widget> actionWidgets){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
    decoration: const BoxDecoration(
      color: Colors.white
    ),
    height: screenHeight(context)*0.075,
    child: Row(
      children: [
        Image.asset('images/logo.png',height: screenHeight(context)*0.075,),
        const SizedBox(width: 10,),
        Expanded(
            child: Text(labelText,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),)
        ),
        Row(
          children: actionWidgets
        )
      ],
    ),
  );
}

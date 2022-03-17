

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_learning/globals_methods.dart';
import 'package:e_learning/globals_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeCertificatePage extends StatefulWidget {
  const HomeCertificatePage({Key? key}) : super(key: key);

  @override
  _HomeCertificatePageState createState() => _HomeCertificatePageState();
}

class _HomeCertificatePageState extends State<HomeCertificatePage> {

  Rx<String> selectedCourse = 'All Course'.obs;

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
            eLearningAppBar(context,'My Certificate',[]),
            certificatePanel()
          ],
        )
      ),
    );
  }



  Widget certificatePanel(){
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        width: double.infinity,
        child: ListView(
          // physics: const NeverScrollableScrollPhysics(),
          children: [1,2].map((e) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  Container(
                    width: screenWidth(context)*0.2,
                    height: screenWidth(context)*0.2,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: Image.asset('images/certificate$e.png').image,
                          fit: BoxFit.cover
                      )
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(e==5?'3D Design Basic':'Graphic Design Basic',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
                        const SizedBox(height: 10,),
                        Text('20 Lessons',style: TextStyle(color: Colors.grey.withOpacity(0.5)),)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.scale(
                          scale: 1.3,
                          child: CircularProgressIndicator(
                            color: color1,
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            value: 0.2,
                          ),
                        ),
                        Text('20%',style: TextStyle(color: color1),)
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        )
      ),
    );
  }
}


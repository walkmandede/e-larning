

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_learning/globals_methods.dart';
import 'package:e_learning/globals_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeHomePage extends StatefulWidget {
  const HomeHomePage({Key? key}) : super(key: key);

  @override
  _HomeHomePageState createState() => _HomeHomePageState();
}

class _HomeHomePageState extends State<HomeHomePage> {

  Rx<String> selectedCourse = 'All Course'.obs;
  Rx<ScrollController> pageScrollController = ScrollController().obs;

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

            },
            child: SvgPicture.asset('icons/noti_icon.svg'),
          ),
          const SizedBox(width: 5,),
          GestureDetector(
            onTap: () {

            },
            child: SvgPicture.asset('icons/heart_icon.svg'),
          )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: getTextScaleFactor(context),
      child: Scaffold(
        body: Column(
          children: [
            eLearningAppBar(context,'Hello,Daniel',appBarWidgets()),
            filterPanel(),
            adsPanel(),
            courseCategoryPanel(),
            coursesPanel()
          ],
        )
      ),
    );
  }


  Widget filterPanel(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))
      ),
      height: screenHeight(context)*0.1,
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: screenHeight(context)*0.06,
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withOpacity(0.12)
              ),
              child: TextField(
                style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: color2),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: localizedTexts('Password'),
                  hintStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),
                  // fillColor: Colors.grey.withOpacity(0.15),
                  // filled: true
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Container(
            height: screenHeight(context)*0.06,
            width: screenHeight(context)*0.06,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.withOpacity(0.12)
            ),
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset('icons/filter_icon.svg'),
          )
        ],
      )
    );
  }

  Widget adsPanel(){
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 350/142,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayAnimationDuration: const Duration(seconds: 2)
      ),
      items: [1,2,3].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Card(
              elevation: 8,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: Image.asset('images/ads$i.png',fit: BoxFit.fill,).image
                    ),
                  borderRadius: BorderRadius.circular(12)
                  ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget courseCategoryPanel(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(localizedTexts('Awesome Coursers'),style: const TextStyle(fontWeight: FontWeight.bold,),),
              TextButton(onPressed: () {

              }, child: Text(localizedTexts('See all'),style: const TextStyle(fontWeight: FontWeight.w500),))
            ],
          ),
          Obx(
                ()=> Row(
                children: ['All Course','Popular','Newest'].map((courseType) {
                  return GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                      decoration: BoxDecoration(
                          color: selectedCourse.value==courseType?color2:color1.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text(localizedTexts(courseType),style: TextStyle(color: selectedCourse.value==courseType?Colors.white:Colors.black,fontSize: 12),),
                    ),
                    onTap: (){
                      selectedCourse.value = courseType;
                    },
                  );
                }).toList()
            ),
          ),
        ],
      ),
    );
  }

  Widget coursesPanel(){
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        width: double.infinity,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1,
          // physics: const NeverScrollableScrollPhysics(),
          children: [1,2,3,4,1,2,3,4].map((e) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.2))
              ),
              child: Column(
                children: [
                  Container(
                    height: screenWidth(context)*0.3,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: Image.asset('images/course$e.png').image
                      )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text('LOGO Design',style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(numberNormalizer('50000') + ' KS',style: const TextStyle(color: color2,fontWeight: FontWeight.w600),)
                            ],
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: SvgPicture.asset('icons/heart_icon.svg'),)
                        ],
                      ),
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


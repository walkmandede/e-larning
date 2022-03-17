library my_prj.globals;

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'app_localization.dart';
import 'globals_variables.dart';

Color stringToColorConverter(String colorString){
  int colorCode = colorString.contains('MaterialColor') ?
  int.parse(colorString.split('Color(')[2].substring(0,10))
      :int.parse(colorString.split('Color(')[1].substring(0,10));
  return Color(colorCode);
}


String numberNormalizer(String number,{bool comma=true}){
  String _result = '';
  for (var element in number.characters) {
    _result = _result+appNumbers[element]![appLanguage]!;
  }

  if(comma){
    String _temp = '';
    int digitCount = 0;

    //make String Reverse adding comma
    for(int i=0;i<=_result.characters.length-1;i++){
      if(digitCount==3){
        digitCount=0;
        _temp = _temp+','+_result.characters.toList()[_result.characters.length-i-1];
      }
      else{
        digitCount++;
        _temp = _temp+_result.characters.toList()[_result.characters.length-i-1];
      }
    }

    _result = '';
    //normalize the reversed String
    for(int i=0;i<=_temp.characters.length-1;i++){
      _result = _result+_temp.characters.toList()[_temp.characters.length-i-1];
    }
  }

  return _result;
}

void showCustomizedDialog(BuildContext context,String title){
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                ),
                //Todo
                child: Image.asset('images',width: screenWidth(context)/4,),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: color1.withOpacity(0.1))),
                    color: Colors.white
                ),
                child: Text(title,style: const TextStyle(color: color1,fontSize: 16,fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
      );
    },
  );
}

sortMap(Map map){
  Map newMap = {};
  List oldMapAsList = map.keys.toList();
  for(int i =0 ; i< map.length; i++){
    newMap.addEntries([
      MapEntry(oldMapAsList[map.length-i-1], map[oldMapAsList[map.length-i-1]])
    ]);
  }
  return newMap;
}

bool isKeyboardOpen(BuildContext context){
  return MediaQuery.of(context).viewInsets.bottom==0.0;
}

void showFullScreenKeyboard(BuildContext context,TextEditingController txtCtrl,{bool pwdText = false}){
  showDialog(context: context, builder:(context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder()
                        ),
                        maxLines: null,
                        obscureText: pwdText,
                        autofocus: true,
                        controller: txtCtrl,
                      )
                    ],
                  ),
                ),
              )
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () {
                  txtCtrl.clear();
                }, child: const Text('Clear'),style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),),),
                ElevatedButton(onPressed: () {
                  pop(context);
                }, child: const Text('Done')),
              ],
            ),
          ),
        ],
      ),
    );
  },);
}

bool isSameWeek(DateTime date1, DateTime date2)
{
  var d1 =  date1.subtract(Duration(days: date1.weekday));
  var d2 =  date2.subtract(Duration(days: date2.weekday));
  return d1==d2;
}

Map<int,String> intMonth = {1:'JAN',2:'FEB',3:'MAR',4:'APR',5:'MAY',6:'JUN',7:'JUL',8:'AUG',9:'SEP',10:'OCT',11:'NOV',12:'DEC',};

Map<int, Color> color =
{
  50:const Color.fromRGBO(29, 44, 77, .1),
  100:const Color.fromRGBO(29, 44, 77, .2),
  200:const Color.fromRGBO(29, 44, 77, .3),
  300:const Color.fromRGBO(29, 44, 77, .4),
  400:const Color.fromRGBO(29, 44, 77, .5),
  500:const Color.fromRGBO(29, 44, 77, .6),
  600:const Color.fromRGBO(29, 44, 77, .7),
  700:const Color.fromRGBO(29, 44, 77, .8),
  800:const Color.fromRGBO(29, 44, 77, .9),
  900:const Color.fromRGBO(29, 44, 77, 1),
};

Widget chipDesign(String label, Color color,Color textColor) => Container(
  child: Chip(
    label: Text(
      label,style: TextStyle(color: textColor),
    ),
    backgroundColor: color,
    elevation: 4,
    shadowColor: Colors.grey[50],
    padding: const EdgeInsets.all(4),
  ),
  margin: const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),

);

void push(BuildContext context,var to)
{
  Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (context) => to,));
}

void pushReplacement(BuildContext context,var to)
{
  Navigator.of(context,rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => to,));
}

void pop(BuildContext context)
{
  Navigator.of(context,rootNavigator: true).pop();
}

void showSnack(BuildContext context,String text)
{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text),duration: const Duration(seconds: 2),));
}

void testDialog(BuildContext context,String text)
{
  showDialog(context: context, builder: (context) => AlertDialog(title: Text(text),),);
}

void languageModalSheet(BuildContext context) {

  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(),
      isScrollControlled: false,
      builder: (context){
        return Obx(
              () {
            return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(localizedTexts('Choose One Option'),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const CircleAvatar(
                              backgroundColor: color1,
                              radius: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: appLanguage.value==Language.en?4:7,
                            ),
                          ],
                        ),
                        const SizedBox(width: 10,),
                        TextButton(onPressed: () {
                          appLanguage.value=Language.en;
                        }, child: const Text('English',style: TextStyle(fontSize: 14,color: Colors.black),))
                      ],
                    ),
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const CircleAvatar(
                              backgroundColor: color1,
                              radius: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: appLanguage.value==Language.my?4:7,
                            ),
                          ],
                        ),
                        const SizedBox(width: 10,),
                        TextButton(onPressed: () {
                          appLanguage.value=Language.my;
                        }, child: const Text('မြန်မာ',style: TextStyle(fontSize: 14,color: Colors.black),))
                      ],
                    ),
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                        decoration: BoxDecoration(
                            color: color1,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(localizedTexts('Continue'),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                      ),
                    ),
                  ],
                )
            );
          },
        );
      }
  );
}


void hideKeyboards(BuildContext context){
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

// Future<bool> networkTest() async {
//   var result = await Connectivity().checkConnectivity();
//   if(result.name == 'none'){
//     return false;
//   }
//   else{
//     return true;
//   }
// }




void showLoadingScreen(BuildContext context,{String textToShow = ''}){
  showDialog(context: context, builder: (context){
    return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(20))
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 30,),
            Text(textToShow,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),),
          ],
        )
    );
  });
}

Widget loadingWidget(){
  return AnimatedOpacity(
    duration: const Duration(milliseconds: 500),
    opacity: 0.4,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: Image.asset('images/loading.gif',fit: BoxFit.fitHeight,),
      ),
    ),
  );
}


// Future<String> translateTextToBurmese(String text) async{
//   final translator = GoogleTranslator();
//   var translation = await translator.translate(text, to: 'my');
//   return translation.text;
// }
//
// Future<String> translateTextToChinese(String text) async{
//   final translator = GoogleTranslator();
//   var translation = await translator.translate(text, to: 'zh-cn');
//   return translation.text;
// }


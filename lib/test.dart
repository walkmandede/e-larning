//
// import 'dart:async';
// import 'package:concentric_transition/page_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:getbakapp/models/record.dart';
// import 'package:getbakapp/services/recordServices.dart';
// import '../../globalsVariables.dart';
//
// Rx<PageController> adsPageController = PageController(initialPage: 0).obs;
// Rx<int> adsIndex = Rx<int>(0);
// late Timer _timer;
// Rx<List<Record>> allRecords = Rx<List<Record>>([]);
// Rx<ScrollController> pageScrollController = ScrollController().obs;
// Rx<bool> isPageBottom = Rx<bool>(false);
//
// class HomeScreenHomePage extends StatefulWidget {
//   const HomeScreenHomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenHomePageState createState() => _HomeScreenHomePageState();
// }
//
// class _HomeScreenHomePageState extends State<HomeScreenHomePage> with SingleTickerProviderStateMixin{
//
//   @override
//   void initState() {
//
//     _timer = Timer.periodic(const Duration(seconds: 3), (Timer t){
//       if(adsIndex.value==4){
//         adsPageController.value.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
//       }
//       else{
//         adsPageController.value.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
//       }
//     });
//
//     pageScrollController.value.addListener(() {
//       if (pageScrollController.value.position.atEdge) {
//         bool isTop = pageScrollController.value.position.pixels == 0;
//         if (isTop) {
//           isPageBottom.value = false;
//         } else {
//           isPageBottom.value = true;
//         }
//       }
//     });
//     getData();
//     super.initState();
//   }
//
//   Future<void> getData()async{
//     var _allRecords = await getAllRecords();
//     for(int i=0;i<10;i++){
//       allRecords.value.add(_allRecords[i]);
//     }
//
//     allRecords.refresh();
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     return MediaQuery(
//         data: MediaQuery.of(context).copyWith(textScaleFactor: defaultFontScaleFactor.value),
//         child: Scaffold(
//           backgroundColor: const Color(0xfffafafa),
//           resizeToAvoidBottomInset: false,
//           body: Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               CustomScrollView(
//                 controller: pageScrollController.value,
//                 slivers: [
//                   const SliverAppBar(
//                     flexibleSpace: InviteWidget(),
//                     backgroundColor: Colors.white,
//                     elevation: 0,
//                   ),
//                   SliverAppBar(
//                     backgroundColor: const Color(0xfffafafa),
//                     flexibleSpace: const ActionWidget(),
//                     floating: true,
//                     pinned: true,
//                     expandedHeight: screenHeight(context)*0.15,
//                     collapsedHeight: screenHeight(context)*0.12,
//                     elevation: 0,
//                   ),
//                   SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                           (context, index) {
//                         if(index==0){
//                           return const AdsImagesWidget();
//                         }
//                         else if(index==1){
//                           return CurrentRecords(context: context);
//                         }
//                         return null;
//                       },
//                       childCount: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               Obx(
//                     () =>  !isPageBottom.value?Container():Container(
//                   margin: EdgeInsets.symmetric(vertical: screenHeight(context)*0.025),
//                   child: Card(
//                     elevation: 4,
//                     shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20))
//                     ),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 24),
//                       decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(20))
//                       ),
//                       child: Text(localizedTexts('See Detail'),style: const TextStyle(color: color1),),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//     );
//   }
//
// }
//
// class InviteWidget extends StatelessWidget {
//   const InviteWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//           border: Border.symmetric(horizontal: BorderSide(
//               color: Colors.grey.withOpacity(0.1)
//           )),
//           color: Colors.white
//       ),
//       child: Obx(
//             ()=> Row(
//           children: [
//             Container(
//                 padding: const EdgeInsets.only(left: 22),
//                 width: screenWidth(context)*0.3,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(localizedTexts('Point'),style: const TextStyle(fontSize: 14,color: Colors.grey),),
//                     const Text('30,400 Ks',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),
//                   ],
//                 )
//             ),
//             Container(
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   border: Border(left: BorderSide(color: Colors.grey.withOpacity(0.1))),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(localizedTexts('Invite Your Friends'),style: const TextStyle(color: color3,fontSize: 13,fontWeight: FontWeight.bold),),
//                     Text(localizedTexts('Then Claim 200 MMKs'),style: const TextStyle(color: color1,fontSize: 16,fontWeight: FontWeight.bold),),
//                   ],
//                 )
//             ),
//             Expanded(
//               child: Container(
//                   padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 8),
//                   decoration: const BoxDecoration(),
//                   alignment: Alignment.center,
//                   child: GestureDetector(
//                     onTap: () {
//
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       height: double.infinity,
//                       alignment: Alignment.center,
//                       decoration: const BoxDecoration(
//                           color: color1,
//                           borderRadius: BorderRadius.all(Radius.circular(8))
//                       ),
//                       child: Text(localizedTexts('Invite'),style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
//                     ),
//                   )
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ActionWidget extends StatelessWidget {
//   const ActionWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//             ()=> Container(
//           margin: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
//           height: screenHeight(context)*0.15,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//               border: Border.all(color: Colors.grey.withOpacity(0.1))),
//           child: Center(
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           child: SvgPicture.asset(scanPageIcon,color: color1),
//                           backgroundColor: color1.withOpacity(0.12),
//                         ),
//                         const SizedBox(height: 8,),
//                         Text(localizedTexts('Scan Coupon'),style: const TextStyle(fontSize: 12),)
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           child: SvgPicture.asset(couponIcon,color: color1),
//                           backgroundColor: color1.withOpacity(0.12),
//                         ),
//                         const SizedBox(height: 8,),
//                         Text(localizedTexts('Coupon List'),style: const TextStyle(fontSize: 12),)
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           child: SvgPicture.asset(shopIcon,color: color1),
//                           backgroundColor: color1.withOpacity(0.12),
//                         ),
//                         const SizedBox(height: 8,),
//                         Text(localizedTexts('Find Shop'),style: const TextStyle(fontSize: 12),)
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           child: SvgPicture.asset(dollarSignIcon,color: color1),
//                           backgroundColor: color1.withOpacity(0.12),
//                         ),
//                         const SizedBox(height: 8,),
//                         Text(localizedTexts('Phone Bill'),style: const TextStyle(fontSize: 12),)
//                       ],
//                     ),
//                   ),
//                 ]
//             ),
//           ),
//         )
//     );
//   }
// }
//
// class AdsImagesWidget extends StatelessWidget {
//   const AdsImagesWidget({Key? key,}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//           () {
//         return Container(
//           height: (screenWidth(context)-20)/2.415,
//           margin: const EdgeInsets.symmetric(horizontal: 10,),
//           child: Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)
//                 ),
//                 child: ConcentricPageView(
//                     pageSnapping: true,
//                     pageController: adsPageController.value,
//                     radius: 0,
//                     itemCount: 5,
//                     onChange: (index){
//                       adsIndex.value = index;
//                     },
//                     itemBuilder: (int i,double d){
//                       return Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: Image.asset(dummyImage).image
//                             )
//                         ),
//                       );
//                     }, colors: const [Colors.transparent,Colors.transparent]),
//               ),
//               Container(
//                 margin: const EdgeInsets.all(10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [0,1,2,3,4].map((e) {
//                     return Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 1),
//                       padding: const EdgeInsets.all(0),
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           CircleAvatar(
//                             radius: 5,
//                             backgroundColor: e==adsIndex.value?Colors.white:Colors.transparent,
//                           ),
//                           CircleAvatar(
//                             radius: 3,
//                             backgroundColor: e==adsIndex.value?color1:Colors.grey,
//                           ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class CurrentRecords extends StatelessWidget {
//   final BuildContext context;
//   const CurrentRecords({
//     Key? key,
//     required this.context
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//           ()=> Container(
//         margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.withOpacity(0.2)),
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(localizedTexts('Current Records'),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,)),
//                   Text(localizedTexts('View Details'),style: const TextStyle(fontSize: 14,color: color1,fontWeight: FontWeight.bold),),
//                 ],
//               ),
//             ),
//             Column(
//               children: allRecords.value.map((eachRecord) {
//                 return eachRecordWidget(eachRecord);
//               }).toList(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget eachRecordWidget(Record record){
//     String firstInitial = record.name.split(' ')[0].characters.first;
//     String secondInitial = record.name.split(' ')[0].characters.last;
//
//     if(record.name.split(' ').length>1){
//       secondInitial = record.name.split(' ')[1].characters.first;
//     }
//
//     return GestureDetector(
//       onTap: () {
//
//       },
//       child: Container(
//           width: double.infinity,
//           margin: EdgeInsets.symmetric(horizontal: screenWidth(context)*0.03,vertical: screenWidth(context)*0.015),
//           padding: EdgeInsets.symmetric(horizontal: screenWidth(context)*0.03,vertical: screenWidth(context)*0.03),
//           decoration: BoxDecoration(
//             border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
//           ),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 child: Text(firstInitial+secondInitial,style: const TextStyle(color: Colors.white),),
//                 backgroundColor: color1,
//               ),
//               const SizedBox(width: 15,),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(record.name,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
//                   Text(record.dateTime.toString().substring(0,16),style: TextStyle(fontSize: 12,color: Colors.grey.withOpacity(0.5)),),
//                 ],
//               ),
//               const Spacer(),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(record.message,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: color1),),
//                   Text(record.status,style: const TextStyle(fontSize: 12,color: Colors.black),),
//                 ],
//               ),
//             ],
//           )
//       ),
//     );
//   }
// }

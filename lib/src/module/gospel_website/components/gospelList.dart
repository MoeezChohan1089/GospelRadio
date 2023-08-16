import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../logic.dart';

class UModel3 {
  String? title;
  String? album;
  String? artist;
  String? img;

  UModel3({this.title, this.album, this.artist, this.img});

  factory UModel3.fromJson(Map<String, dynamic> json) {
    return UModel3(
      title: json['title'],
      album: json['album'],
      artist: json['artist'],
      img: json['image'],
    );
  }
}

class Gospelwebsitemodel {
  String? title;
  String? body;

  Gospelwebsitemodel({
    this.title,
    this.body,
  });
}

class GospelWebsiteSection extends StatefulWidget {
  GospelWebsiteSection({Key? key}) : super(key: key);

  @override
  State<GospelWebsiteSection> createState() => _GospelWebsiteSectionState();
}

class _GospelWebsiteSectionState extends State<GospelWebsiteSection> {
  final logic = Get.find<GospelWebsiteLogic>();
  String artistname = '';
  // List<UModel3> glist = [];
  // Future<List<UModel3>> userApi() async {
  //   final dio = Dio();
  //   final response = await dio.get('https://hgcradio.org/api/gospelwebsite');

  //   if (response.statusCode == 200) {
  //     List<UModel3> glist = (response.data['data'] as List)
  //         .map((item) => UModel3.fromJson(item))
  //         .toList();
  //     artistname = response.data['data'][0]['artist'];
  //     print(response.data['data'][0]['artist']);
  //     return glist;
  //   } else {
  //     // Handle the error here, if needed.
  //     // For now, we'll just return an empty list.
  //     return [];
  //   }
  // }

  List<Gospelwebsitemodel> gospelwebsitelist = [
    Gospelwebsitemodel(
        title: 'Halelujah Glospel Globally',
        body:
            'This will lets you explore seamlessly the exciting array of Gospel music, events, news. Biblical truths, people, interactions, projects, concepts, and efforts whiel giving you a glipse of what Hallelujah Gospel is behind the name.'),
    Gospelwebsitemodel(
        title: 'Gospel Pipeline',
        body:
            'Are you in search of better-quality faith-building videos? This is the venue to stram family-friendly videos or make one youself. Watch and share top videos and inspiring movies or upload your own Christian-themed content.'),
    Gospelwebsitemodel(
        title: 'Gospel Store',
        body:
            'Shop smarter at Hallelujah Gospel Online. Enjoy irresistible prices and exclusive deals. Discover a wider selection of top-grade goods. Take delight n terrific gift ideas for a variety of occasions. Save more on bundled products. Browse personalized promotional merchandise.'),
    Gospelwebsitemodel(
        title: 'Gospel Scroll Pages(Social Media)',
        body:
            "If you're ready for something different, what are offering is the best new alternative to social media as we know it. We've made Scroll Pages like a breath of fresh air - with less ad targeting and more secure sharing so that you can communicate with the people in your life in every sense of the word."),
    Gospelwebsitemodel(
        title: 'Gospel Classified',
        body:
            "Hallelujah Classifieds promise to find the perfect match for the ad you are looking for and to house your next cost-free campaign with only a few clicks of the mouse. This is the ultimate marketplace to advertise or check out location-based listings for practically everything you need. If you want to connect with prospective your company, you can't go wrong with Hallelujah Classifieds"),
    Gospelwebsitemodel(
        title: 'Gospel Forum',
        body:
            "Our Gospel Forum is a wonderful avenue for you to connect and find fellowship with like-minded individuals. We have numerous forums, sub forums and several topics that will encourage you and meet your need for a supportive community no matter where you are in your Christian walk."),
    Gospelwebsitemodel(
        title: 'Gospel Shopping & Coaching Tips',
        body:
            "This is another knowledge-sharing tool on Hallelujah Gospel featuring a user-friendly interface, broad topical throughout. Our community-powered Q&A lets you ask questions and get quality answers, or answer other users questions posted here based on either facts or your opinion."),
    Gospelwebsitemodel(
        title: 'Gospel Printing',
        body:
            "Gospel Printing has all your custom printing needs in one convenient location, plus we've got your CD duplication and replication covered with the fastest turnaround time. We are focused on your image and able to serve as a true partner in producing highly satisfactory work."),
    Gospelwebsitemodel(
        title: 'Gospel Templates',
        body:
            'Create a professional website for your business or church without paying anything. Hallelujah Gospel has hunderds (and counting) of stunning templates you can customize to your heart content. Domain name, web hosting and e-commerce solutions are also available for next to nothing with our premium plans'),
    Gospelwebsitemodel(
        title: 'Gospel Sing Along',
        body:
            "This Web conferencing platform makes your online meetings as good as face-to-face communications. We've redefined the process of hosting and joining so that everything is simple and straightforward. Connect seamlessly with anybody in the world in the comfort of your preferred location to launch your conference or group discussion, or just catch up with family and firends blissfully."),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(gospelwebsitelist.length, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal / 2),
            child: Column(
              children: [
                Obx(
                  () => Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors
                          .transparent, // Set the dividerColor to transparent
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.customWebsiteListColor,
                      ),
                      child: ExpansionTile(
                        leading: Image.asset(
                          Assets.images.playImage,
                          width: 64,
                          height: 55,
                        ),
                        onExpansionChanged: (value) {
                          logic.expandedContainer.value = index;
                        },
                        title: Text(
                          gospelwebsitelist[index].title.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: logic.expandedContainer.value == index
                            ? Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.white,
                                size: 30.sp,
                              )
                            : Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                        children: [
                          Container(
                            width: double.maxFinite,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                gospelwebsitelist[index].body.toString(),
                                textAlign: TextAlign.left,
                                style: context.text.bodyMedium?.copyWith(
                                    fontSize: 13.sp, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )

                // Obx(
                //   () => GestureDetector(
                //     onTap: () {
                //       logic.expandedContainer.value = index;
                //       print(index);
                //     },
                //     child: Container(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: pageMarginHorizontal / 2,
                //       ),
                //       // color: Colors.transparent,
                //       decoration: BoxDecoration(
                //           color: AppColors.customWebsiteListColor,
                //           borderRadius: BorderRadius.circular(8)),
                //       // padding: EdgeInsets.symmetric(vertical: pageMarginVertical / 3),
                //       child: Column(
                //         children: [
                //           4.heightBox,
                //           SizedBox(
                //             width: double.infinity,
                //             child: Row(
                //               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Image.asset(
                //                   Assets.images.playImage,
                //                   width: 64,
                //                   height: 55,
                //                 ),
                //                 10.widthBox,
                //                 Text(
                //                   gospelwebsitelist[index].title.toString(),
                //                   style: context.text.bodyLarge
                //                       ?.copyWith(color: Colors.white
                //                           // height: 0.1
                //                           ),
                //                 ),
                //                 const Spacer(),
                //                 logic.expandedContainer.value == index
                //                     ? Icon(
                //                         Icons.keyboard_arrow_down_outlined,
                //                         color: Colors.white,
                //                         size: 30.sp,
                //                       )
                //                     : Icon(
                //                         Icons.arrow_forward_ios,
                //                         color: Colors.white,
                //                         size: 20.sp,
                //                       ),
                //               ],
                //             ),
                //           ),
                //           SizedBox(
                //               height: logic.expandedContainer.value == index
                //                   ? 10
                //                   : 0),
                //           AnimatedContainer(
                //             duration: const Duration(milliseconds: 800),
                //             child: logic.expandedContainer.value == index
                //                 ? Builder(builder: (context) {
                //                     return Container(
                //                       width: double.maxFinite,
                //                       child: Text(
                //                         gospelwebsitelist[index]
                //                             .body
                //                             .toString(),
                //                         textAlign: TextAlign.left,
                //                         style: context.text.bodyMedium
                //                             ?.copyWith(
                //                                 fontSize: 13.sp,
                //                                 color: Colors.white),
                //                       ),
                //                     );
                //                   })
                //                 : Container(
                //                     height: 0,
                //                   ),
                //           ),
                //           4.heightBox,
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                ,
                Divider(
                  color: Colors.black,
                  thickness: .2,
                ),
              ],
            ),
          );
        }),
      ),
    );

    // Container(
    //     child: const Center(
    //   child: Text(
    //     'No Data Found',
    //     style: TextStyle(color: Colors.white, fontSize: 16),
    //   ),
    // )

    //     //     FutureBuilder<List<UModel3>>(
    //     //   future: userApi(),
    //     //   builder: (context, snapshot) {
    //     //     if (snapshot.connectionState == ConnectionState.waiting) {
    //     //       return Text('loading');
    //     //     } else if (snapshot.hasError) {
    //     //       return Text('Error: ${snapshot.error}');
    //     //     } else {
    //     //       return ListView.builder(
    //     //         itemCount: snapshot.data!.length,
    //     //         itemBuilder: (context, index) {
    //     //           // Access the 'data' list inside the historymodel instance
    //     //           var item = snapshot.data![index];
    //     //           return GestureDetector(
    //     //             onTap: () {
    //     //               logic.expandedContainer.value = index;
    //     //             },
    //     //             child: Container(
    //     //               padding: EdgeInsets.symmetric(
    //     //                 horizontal: pageMarginHorizontal / 2,
    //     //               ),
    //     //               // color: Colors.transparent,
    //     //               decoration: BoxDecoration(
    //     //                   color: AppColors.customWebsiteListColor,
    //     //                   borderRadius: BorderRadius.circular(8)),
    //     //               // padding: EdgeInsets.symmetric(vertical: pageMarginVertical / 3),
    //     //               child: Column(
    //     //                 children: [
    //     //                   4.heightBox,
    //     //                   SizedBox(
    //     //                     width: double.infinity,
    //     //                     child: Row(
    //     //                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     //                       children: [
    //     //                         Image.asset(
    //     //                           Assets.images.playImage,
    //     //                           width: 64,
    //     //                           height: 55,
    //     //                         ),
    //     //                         10.widthBox,
    //     //                         Text(
    //     //                           "Hallelujah Gospel Globally",
    //     //                           style: context.text.bodyLarge
    //     //                               ?.copyWith(color: Colors.white
    //     //                                   // height: 0.1
    //     //                                   ),
    //     //                         ),
    //     //                         const Spacer(),
    //     //                         logic.expandedContainer.value == index
    //     //                             ? Icon(
    //     //                                 Icons.keyboard_arrow_down_outlined,
    //     //                                 color: Colors.white,
    //     //                                 size: 30.sp,
    //     //                               )
    //     //                             : Icon(
    //     //                                 Icons.arrow_forward_ios,
    //     //                                 color: Colors.white,
    //     //                                 size: 20.sp,
    //     //                               ),
    //     //                       ],
    //     //                     ),
    //     //                   ),
    //     //                   SizedBox(
    //     //                       height:
    //     //                           logic.expandedContainer.value == index ? 10 : 0),
    //     //                   AnimatedContainer(
    //     //                     duration: const Duration(milliseconds: 800),
    //     //                     child: logic.expandedContainer.value == index
    //     //                         ? Builder(builder: (context) {
    //     //                             return Container(
    //     //                               width: double.maxFinite,
    //     //                               child: Text(
    //     //                                 "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
    //     //                                 textAlign: TextAlign.left,
    //     //                                 style: context.text.bodyMedium?.copyWith(
    //     //                                     fontSize: 13.sp, color: Colors.white),
    //     //                               ),
    //     //                             );
    //     //                           })
    //     //                         : Container(
    //     //                             height: 0,
    //     //                           ),
    //     //                   ),
    //     //                   4.heightBox,
    //     //                 ],
    //     //               ),
    //     //             ),
    //     //           );
    //     //         },
    //     //       );
    //     //     }
    //     //   },
    //     // )

    //     );
  }
}

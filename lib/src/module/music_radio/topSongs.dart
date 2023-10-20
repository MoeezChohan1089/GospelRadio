
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/module/music_play/logic.dart';
import 'package:gosperadioapp/src/utils/constants/colors.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../custom_widgets/webview_custom.dart';
import 'logic.dart';

class TopSongsScreen extends StatefulWidget {
  TopSongsScreen({super.key});

  @override
  State<TopSongsScreen> createState() => _TopSongsScreenState();
}

class _TopSongsScreenState extends State<TopSongsScreen> {
  final logic = Get.put(Music_radioLogic());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Calculate the current date index
      logic.navigateButtons1();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Top Songs",
          style: context.text.bodySmall?.copyWith(
              color: AppColors.customWhiteTextColor, fontSize: 14.sp),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
              // if(bottomNav.isFancyDrawer.isTrue){
              //   bottomNav.advancedDrawerController.showDrawer();
              // } else {
              //   bottomNav.navScaffoldKey.currentState?.openDrawer();
              // }
            },
            icon: Icon(Icons.arrow_back, color: AppColors.customBlackTextColor,)
        ),
      ),
      body: Obx((){
        return logic.isLoadingAlbums.value == true? Center(child: CircularProgressIndicator(color: Colors.white,),): SingleChildScrollView(
          child: Column(
            children: List.generate(logic.topSongs.value.length, (index){
              return
                GestureDetector(
                  onTap: (){
                    Get.to(WebViewCustom(
                      productUrl: '${logic.topSongs.value[index]['view_url']}',
                      title: logic.topSongs.value[index]['album_title'],
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 100.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        // backgroundBlendMode: BlendMode.darken,
                        // color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10.r),
                        image: DecorationImage(
                          image: NetworkImage(logic.topSongs.value[index]['album_image']),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.6),
                            BlendMode.dstATop,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${logic.topSongs.value[index]['album_title']}",
                            textAlign: TextAlign.center,
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 24.sp),
                          ),
                          Text(
                            "${logic.topSongs.value[index]['music_title']}",
                            textAlign: TextAlign.center,
                            style: context.text.titleMedium?.copyWith(
                                color: AppColors.customWhiteTextColor,
                                fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
            }),
          ),
        );
      }),
    );
  }
}

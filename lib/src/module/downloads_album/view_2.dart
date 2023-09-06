import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/constants/margins_spacnings.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/constants/colors.dart';
import 'logic.dart';

class DownloadSongs extends StatefulWidget {
  final int id;

  const DownloadSongs({super.key, required this.id});

  @override
  State<DownloadSongs> createState() => _DownloadSongsState();
}

class _DownloadSongsState extends State<DownloadSongs> {

  final logic = Get.put(DownloadsAlbumLogic());

  final state = Get
      .find<DownloadsAlbumLogic>()
      .state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.downloadShowSongMusicAlbum(context, widget.id);
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
          "Download Songs",
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
            icon: Icon(
              Icons.arrow_back, color: AppColors.customBlackTextColor,)
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
            child: Column(
            children: List.generate(
                logic.downloadSongsAlbum.value.length, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical/1.5),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.customWebsiteListColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(logic.downloadSongsAlbum.value[index]['title'], style: context.text.bodyMedium?.copyWith(color: AppColors.customWhiteTextColor, fontSize: 18.sp),),
                          6.heightBox,
                          Text("${logic.downloadSongsAlbum.value[index]['duration']} mins", style: context.text.bodyMedium?.copyWith(color: AppColors.customWhiteTextColor, fontSize: 16.sp),),
                        ],
                      ),
                      IconButton(onPressed: () async{

                        final externalDir = await getExternalStorageDirectory();
                        final downloadDir = Directory('${externalDir!.path}/downloadedMusic.mp3');

                        print("path storage: ${downloadDir}");

                        if (!downloadDir.existsSync()) {
                          downloadDir.createSync(recursive: true);
                        }


                        final taskId = await FlutterDownloader.enqueue(
                          url: logic.downloadSongsAlbum.value[index]['download_link'],
                          headers: {},
                          savedDir: downloadDir.path, // Use the path to the created directory
                          showNotification: true,
                          openFileFromNotification: true,
                          saveInPublicStorage: true
                        );
                        final snackBar = SnackBar(
                          content: Text('Your song has been downloaded..'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      }, icon: Icon(Icons.download, color: AppColors.customWhiteTextColor, size: 22,))
                    ],
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

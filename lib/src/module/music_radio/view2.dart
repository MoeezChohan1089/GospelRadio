
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';

import '../../utils/constants/colors.dart';
import '../drawer.dart';

class View2ListButton extends StatelessWidget {
  View2ListButton({super.key});

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.custombackgroundColor,
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.custombackgroundColor,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "",
          style: context.text.bodySmall?.copyWith(
              color: AppColors.customWhiteTextColor, fontSize: 14.sp),
        ),
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
              // if(bottomNav.isFancyDrawer.isTrue){
              //   bottomNav.advancedDrawerController.showDrawer();
              // } else {
              //   bottomNav.navScaffoldKey.currentState?.openDrawer();
              // }

            },
            icon: Icon(
              Icons.menu,
              color: AppColors.customBlackTextColor,
            )),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         // Get.to(() => CartPage());
        //       },
        //       icon: Icon(Icons.search, color: AppColors.customBlackTextColor,)
        //   ),
        // ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(4),
              ),
              width: MediaQuery.of(context).size.width*0.6,
              child: Text("Breaking Gospel Music News", textAlign: TextAlign.center, maxLines: 2, style: TextStyle(color: Colors.white)),
            ),
            20.heightBox,
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(4),
              ),
              width: MediaQuery.of(context).size.width*0.6,
              child: Text("New Release Project", textAlign: TextAlign.center, maxLines: 2, style: TextStyle(color: Colors.white)),
            ),
            20.heightBox,
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
              width: MediaQuery.of(context).size.width*0.6,
              child: Text("Top Songs Listen And Viewed", textAlign: TextAlign.center, maxLines: 2, style: TextStyle(color: Colors.white)),
            ),
            20.heightBox,
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              width: MediaQuery.of(context).size.width*0.6,
              child: Text("Latest News and Updates", textAlign: TextAlign.center, maxLines: 2, style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

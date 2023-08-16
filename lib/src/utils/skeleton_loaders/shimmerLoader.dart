import 'package:flutter/material.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';
import '../constants/margins_spacnings.dart';


class LoadingListPage extends StatefulWidget {
  @override
  _LoadingListPageState createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: _enabled,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 200.0,
                    height: 200.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimerListviewPage extends StatefulWidget {
  @override
  _ShimerListviewPageState createState() => _ShimerListviewPageState();
}

class _ShimerListviewPageState extends State<ShimerListviewPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade100,
          enabled: _enabled,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 16,
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: AppColors.customGreyBorderColor,
                    borderRadius:
                    BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 0.8),
                      ),
                    ]),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 10,
                      color: AppColors.customWhiteTextColor,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 10,
                          color: AppColors.customWhiteTextColor,
                        ),
                        Spacer(),
                        Container(
                          width: 50,
                          height: 10,
                          color: AppColors.customWhiteTextColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 10,
                          color: AppColors.customWhiteTextColor,
                        ),
                        Spacer(),
                        Container(
                          width: 20,
                          height: 10,
                          color: AppColors.customWhiteTextColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// carosal Slider

class ShimerCarosalSliderPage extends StatefulWidget {
  @override
  _ShimerCarosalSliderPageState createState() => _ShimerCarosalSliderPageState();
}

class _ShimerCarosalSliderPageState extends State<ShimerCarosalSliderPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: _enabled,
        child: Container(
          width: double.maxFinite,
          height: context.deviceHeight / 2.1,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CachedBackgroundImagePage extends StatefulWidget {
  @override
  _CachedBackgroundImagePageState createState() => _CachedBackgroundImagePageState();
}

class _CachedBackgroundImagePageState extends State<CachedBackgroundImagePage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 169,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: _enabled,
        child: Container(
          width: double.maxFinite,
          height: 169,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ShimertitlePage extends StatefulWidget {
  @override
  _ShimertitlePageState createState() => _ShimertitlePageState();
}

class _ShimertitlePageState extends State<ShimertitlePage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: _enabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 10,
              color: AppColors.customWhiteTextColor,
            ),
            (pageMarginVertical / 2).heightBox,
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    height: 10,
                    color: AppColors.customWhiteTextColor,
                  ),
                ),
              ],
            ),
            (pageMarginVertical / 2).heightBox,

            Container(
              width: 30,
              height: 10,
              color: AppColors.customWhiteTextColor,
            ),

            (pageMarginVertical / 3).heightBox,

            Container(
              width: 100,
              height: 10,
              color: AppColors.customWhiteTextColor,
            ),
          ],
        )
      ),
    );
  }
}

class ShimerSizeAndColorDropwdownPage extends StatefulWidget {
  @override
  _ShimerSizeAndColorDropwdownPageState createState() => _ShimerSizeAndColorDropwdownPageState();
}

class _ShimerSizeAndColorDropwdownPageState extends State<ShimerSizeAndColorDropwdownPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: _enabled,
          child: Row(
            children: [
              Expanded(child: Container(
                height: 30,
                color: AppColors.customWhiteTextColor,
              )),
              (pageMarginHorizontal / 2).widthBox,
              Expanded(child: Container(
                color: AppColors.customWhiteTextColor,
                height: 30,
              )),
            ],
          )
      ),
    );
  }
}

class ShimerSizeAndColorPage extends StatefulWidget {
  @override
  _ShimerSizeAndColorPageState createState() => _ShimerSizeAndColorPageState();
}

class _ShimerSizeAndColorPageState extends State<ShimerSizeAndColorPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: _enabled,
          child: Row(
            children: [
              Container(
                width: 50,
                height: 30,
                color: AppColors.customWhiteTextColor,
              ),
              (pageMarginHorizontal / 2).widthBox,
              Container(
                width: 50,
                height: 30,
                color: AppColors.customWhiteTextColor,
              ),
              (pageMarginHorizontal / 2).widthBox,
              Container(
                width: 50,
                height: 30,
                color: AppColors.customWhiteTextColor,
              ),
            ],
          )
      ),
    );
  }
}

class ShimerQuantityPage extends StatefulWidget {
  @override
  _ShimerQuantityPageState createState() => _ShimerQuantityPageState();
}

class _ShimerQuantityPageState extends State<ShimerQuantityPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: _enabled,
          child: Container(
            width: double.maxFinite,
            height: 70,
            color: AppColors.customWhiteTextColor,
          )
      ),
    );
  }
}

class ShimerDividerPage extends StatefulWidget {
  @override
  _ShimerDividerPageState createState() => _ShimerDividerPageState();
}

class _ShimerDividerPageState extends State<ShimerDividerPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: _enabled,
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 50,
                color: AppColors.customWhiteTextColor,
              ),
              (pageMarginVertical/2).heightBox,
              Container(
                width: double.maxFinite,
                height: 50,
                color: AppColors.customWhiteTextColor,
              ),
              (pageMarginVertical/2).heightBox,
              Container(
                width: double.maxFinite,
                height: 50,
                color: AppColors.customWhiteTextColor,
              ),
              (pageMarginVertical/2).heightBox,
              Container(
                width: double.maxFinite,
                height: 50,
                color: AppColors.customWhiteTextColor,
              ),
              (pageMarginVertical/2).heightBox,
            ],
          )
      ),
    );
  }
}

class ShimerCircularProductPage extends StatefulWidget {
  @override
  _ShimerCircularProductPageState createState() => _ShimerCircularProductPageState();
}

class _ShimerCircularProductPageState extends State<ShimerCircularProductPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: _enabled,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(5, (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal/2, vertical: pageMarginVertical/2 ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.customWhiteTextColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    (pageMarginVertical/2).heightBox,
                    Container(
                      width: 30,
                      height: 10,
                      color: AppColors.customWhiteTextColor,
                    ),
                    (pageMarginVertical/2).heightBox,
                    Container(
                      width: 30,
                      height: 10,
                      color: AppColors.customWhiteTextColor,
                    ),
                  ],
                ),
              )),
            ),
          )
      ),
    );
  }
}

class ShimerRectProductPage extends StatefulWidget {
  @override
  _ShimerRectProductPageState createState() => _ShimerRectProductPageState();
}

class _ShimerRectProductPageState extends State<ShimerRectProductPage> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: _enabled,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(5, (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal/2, vertical: pageMarginVertical/2 ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.customWhiteTextColor,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    (pageMarginVertical/2).heightBox,
                    Container(
                      width: 30,
                      height: 10,
                      color: AppColors.customWhiteTextColor,
                    ),
                    (pageMarginVertical/2).heightBox,
                    Container(
                      width: 30,
                      height: 10,
                      color: AppColors.customWhiteTextColor,
                    ),
                    (pageMarginVertical/2).heightBox,
                    Container(
                      width: 30,
                      height: 10,
                      color: AppColors.customWhiteTextColor,
                    ),
                  ],
                ),
              )),
            ),
          )
      ),
    );
  }
}

class productShimmer extends StatefulWidget {
  @override
  _productShimmerState createState() => _productShimmerState();
}

class _productShimmerState extends State<productShimmer> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: _enabled,
          child:
          Container(
            color: AppColors.customWhiteTextColor,
          )
      ),
    );
  }
}
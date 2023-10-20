import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/constants/assets.dart';

class WebViewCustom extends StatefulWidget {
  final String productUrl;
  final String title;

  const WebViewCustom({Key? key, required this.productUrl, required this.title}) : super(key: key);

  @override
  State<WebViewCustom> createState() => _WebViewCustomState();
}

class _WebViewCustomState extends State<WebViewCustom> {
  bool isLoading = true;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // setState(() {
            //   _showProgressIndicator = (progress < 100);
            // });
            // log("==== current progress is $progress ====");

          },

          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
            //
            // log("==== page loading finished $url ====");
            //
            // CartLogic.to.resetCart();
            // Future.delayed(const Duration(seconds: 6)).then((_) {
            //   if (mounted) {
            //     // controller.goBack();
            //     // Navigator.of(context).popUntil((route) => route.isFirst);
            //   }
            // });
          },
          onWebResourceError: (WebResourceError error) {

          },
          onNavigationRequest: (NavigationRequest request) async {
            // if (request.url.endsWith('/thank_you')) {
            //   CartLogic.to.resetCart();
            //   log("====> User Successfully Done with installed <==== ");
            //
            //
            //   await Future.delayed(const Duration(seconds: 10));
            //   log("===== 10 seconds done ========");
            //   // if(mounted) Navigator.pop(context);
            //
            //
            //
            //   // return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.productUrl));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: (){
                HapticFeedback.lightImpact();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 22.sp,
              )),
          title: Text(
            widget.title,
            style: context.text.titleSmall?.copyWith(
                fontSize: 16.sp,
                color: Colors.black),
          )
      ),
      body: isLoading ? Center( child: CircularProgressIndicator(color: Colors.black,),)
          : WebViewWidget(controller: controller),
    );
  }
}
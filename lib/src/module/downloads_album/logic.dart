import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:gosperadioapp/src/globalVariable/database_controller.dart';

import '../../globalVariable/global_variable.dart';
import 'state.dart';

class DownloadsAlbumLogic extends GetxController {
  final DownloadsAlbumState state = DownloadsAlbumState();

  RxList downloadAlbumsShow = [].obs;
  RxList downloadSongsAlbum = [].obs;

  downloadShowSong(context) async{
    customLoaderGlobal.showLoader(context);
    var dio = Dio();
    var headers = {
      'Authorization': 'Bearer ${LocalDatabase.to.box.read('token')}',
      'Cookie': 'XSRF-TOKEN=eyJpdiI6IjZuLzJGSmZlVVVMZ3JWUm9iR1J1TEE9PSIsInZhbHVlIjoiWHJJZmppbGJpQ3NJTFhYcGJPNjlUQ0dKSTV1bHpPcXhGMjlTeDI2aytzVkt6czhUNmZhaXFnV0VoK05FN3lIOVN2eG9IWFg3YUhjNmxTTm9RdkViK25MQjUvMEtCZjFqMSsyd2F5d0IrNFFadlZuMnlMWWVtellwOXczVS9WR2MiLCJtYWMiOiJjNTA5MTk2YzZjODg0NjMzODY0NzNmNWY0ODM4YzkxMDMwOThmMjA3ZjY1MDlhYjhmMGI3NDZmNjUzMzE1NTU0IiwidGFnIjoiIn0%3D; hallelujah_choice_radio_session=eyJpdiI6IitPcWZKb0lwY2RNRUx1VTBaOFBEU3c9PSIsInZhbHVlIjoicGswVkt2L2Evc2hYUXIxZUxnQ1lzUGd5dkh1b1VwM3Z0b2h0S1RCOUsyNXR6cGh1S1JMTi81emdieVE1Qnk3Q2FJL3NMcVhxMHc1SU92SDBIR2JIRXR2K2lMdTZiZEV2UGk1d21aQWRqeG1NQlAyb2pxRmlyN1NFdE1nOFR1cDQiLCJtYWMiOiI3MjVjNjdiZjFkYTQ5MWM4ODcyMmQ4YjNhNjY0NmQ3YjAwYzdmYzc0OGY4ZTNlNDY4OTQ3YjQxNmZkNTYxYzI5IiwidGFnIjoiIn0%3D'
    };
    var response = await dio.request(
      'https://hgcradio.org/api/purhcased/music',
      options: Options(
        method: 'GET',
        headers: headers
      ),
    );

    if (response.statusCode == 200 && response.data['status'] == "Success") {
      print("dddffghhhhhh: ${json.encode(response.data)}");
      downloadAlbumsShow.value = response.data['data'];
      print("dddffghhhhhh1234: ${downloadAlbumsShow.value}");
      customLoaderGlobal.hideLoader();
    } else {
      customLoaderGlobal.hideLoader();
      print(response.statusMessage);
    }
  }

  downloadShowSongMusicAlbum(context, id) async{
    customLoaderGlobal.showLoader(context);
    var dio = Dio();
    var headers = {
      'Authorization': 'Bearer ${LocalDatabase.to.box.read('token')}',
    };
    var response = await dio.request(
      'https://hgcradio.org/api/purhcased/album/$id',
      options: Options(
          method: 'GET',
          headers: headers
      ),
    );

    if (response.statusCode == 200 && response.data['status'] == "Success") {
      print("dddffghhhhhh1113333333: ${json.encode(response.data)}");
      downloadSongsAlbum.value = response.data['data']['songs'];
      print("dddffghhhhhh123444344: ${downloadSongsAlbum.value}");
      customLoaderGlobal.hideLoader();
    } else {
      customLoaderGlobal.hideLoader();
      print(response.statusMessage);
    }
  }
}

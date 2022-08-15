// ignore_for_file: avoid_print, unused_local_variable, use_build_context_synchronously
import 'dart:convert';

import 'package:html/parser.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pod_player/pod_player.dart';
import 'package:vimeo_demo/p_video.dart';
import 'package:vimeo_demo/utils.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ABC extends StatefulWidget {
  const ABC({Key? key}) : super(key: key);

  @override
  State<ABC> createState() => _ABCState();
}

class _ABCState extends State<ABC> {
  late final PodPlayerController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String kCookie = "";
  String title = "";
  String videoUrl = "";
  dynamic ctrl;

  final cookieManager = WebviewCookieManager();

  // late WebViewController controller;

  getCookie(String uri) async {
    final gotCookies = await cookieManager.getCookies(uri);

    // Validate cookie
    if (gotCookies.isEmpty) {
      print("Cookie is empty");
      setState(() {
        videoUrl = "Cookie is empty";
      });
      // return;
    }

    // Set Cookie
    // kCookie = gotCookies[0].toString();

    Map<String, String> headers = {
      "Accept": "*/*",
      "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36",
      "Referer": "http://wearingo.in/",
      "auth_redirect":
          "https%3A%2F%2Fdeveloper.vimeo.com%2Fapps%2Fnew; vimeo_gdpr_optin=1; vimeo=OHLtD4ZeDtPMVHLXX4LP4e4PMxHNePNdtZtPPeeNcX%2C4cPPedccc3edLSPXXLdSDP3SMw3h_OI3uHLM5i_Ic9j3H9ubNwizNVi9wMIHXe4ZcSea4Bc%2CL4XLateZPeZdeNDXe4NNeDZDd%2CXPeteeDDacZXa%2C4da43LBtSP3e; language=en; has_uploaded=1; __cf_bm=4ejU_f.yygJIWD08kPXISjOFhWiDKGKI1IY80Yizbpw-1660322659-0-ARy0C6oH+jRkKZTYnXqkbVb8j4fd5fbVFOWgIAWviYNFmSXUzgD81yltpNhrtK3pBzXLP4C84ySuUXkGa3X6wUE=https%3A%2F%2Fdeveloper.vimeo.com%2Fapps%2Fnew; vimeo_gdpr_optin=1; vimeo=OHLtD4ZeDtPMVHLXX4LP4e4PMxHNePNdtZtPPeeNcX%2C4cPPedccc3edLSPXXLdSDP3SMw3h_OI3uHLM5i_Ic9j3H9ubNwizNVi9wMIHXe4ZcSea4Bc%2CL4XLateZPeZdeNDXe4NNeDZDd%2CXPeteeDDacZXa%2C4da43LBtSP3e; language=en; has_uploaded=1; __cf_bm=4ejU_f.yygJIWD08kPXISjOFhWiDKGKI1IY80Yizbpw-1660322659-0-ARy0C6oH+jRkKZTYnXqkbVb8j4fd5fbVFOWgIAWviYNFmSXUzgD81yltpNhrtK3pBzXLP4C84ySuUXkGa3X6wUE=",
      "Cookie": gotCookies[0].toString()
    };

    // GET video response
   try {
      http.Response response = await http.get(
        Uri.tryParse(
            "https://player.vimeo.com/video/730972653?h=eae2597c37&badge=0&autopause=0&player_id=0&app_id=58479")!,
        headers: headers,
      );

      print(response.body);

      if (response.statusCode != 200) {
        setState(() {
          videoUrl = "response statusCode ${response.statusCode}";
        });
        showSnackBar(context, "something went wrong, Please re-start the app");
        return;
      }

      // Get title of the video
      var document = parse(response.body);
      setState(() {
        // Getting video url

        var scripts = document.getElementsByTagName("script");

        var longestScript = '';
        for (var element in scripts) {
          if (element.innerHtml.length > longestScript.length) {
            longestScript = element.innerHtml;
          }
        }
        var startingIndex = longestScript.indexOf("var config = {") +
            "var config = {".length -
            1;
        var endingIndex = longestScript.indexOf("};") + "};".length - 1;
        var jsonConfig = longestScript.substring(startingIndex, endingIndex);
        var videoConfig = jsonDecode(jsonConfig);
        var videoToPlay = videoConfig['request']['files']['progressive'][0];
        for (var video in videoConfig['request']['files']['progressive']) {
          if (videoToPlay['width']! < video['width']) {
            videoToPlay = video;
          }
        }

        videoUrl = videoToPlay["url"];
        title = document.getElementsByTagName("title")[0].text;

        if (videoUrl.isNotEmpty || title.isNotEmpty) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return pVideo(appBarText: title, videoUrl: videoUrl);
          }));
        } else {
          showSnackBar(
              context, "something went wrong, Please re-start the app");
        }
      });
   } catch (e) {
      showSnackBar(context, "something went wrong, Please re-start the app");
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title.isNotEmpty ? Text(title) : const Text("Title"),
      ),
      body: WebView(
        initialUrl: "https://player.vimeo.com/video/730972653?h=eae2597c37",
        onWebViewCreated: (_) async {},
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        onPageFinished: (_) async {
          await getCookie(
              "https://player.vimeo.com/video/730972653?h=eae2597c37");
        },
        onPageStarted: (_) async {},
        onProgress: (_) {},
      ),
    );
  }
}

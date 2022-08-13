// ignore_for_file: avoid_print, unused_local_variable
import 'dart:convert';

import 'package:html/parser.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pod_player/pod_player.dart';
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
  void initState() {
    getCookie("https://player.vimeo.com/video/730972653?h=eae2597c37");
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(
        videoUrl.isEmpty ? "https://vod-progressive.akamaized.net/exp=1660416955~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F1194%2F29%2F730972653%2F3387012699.mp4~hmac=0415734004752e7d495dddf372b546922a90b5b52e8bfd7aa4da47bf6740032c/vimeo-prod-skyfire-std-us/01/1194/29/730972653/3387012699.mp4" : videoUrl
      ),
    )..initialise();
    super.initState();
  }

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
      "Cookie":
          "'language=en; vuid=pl959738990.911525533; vimeo_gdpr_optin=1; __ssid=30e26209-7ae9-4e51-b05e-b493252814f1; player="
              "; auth_redirect=%2Fupload; _abexps=%7B%221057%22%3A%22false%22%2C%222523%22%3A%22variant%22%2C%222540%22%3A%22variant%22%7D; OptanonConsent=isGpcEnabled=0&datestamp=Fri+Aug+12+2022+01%3A51%3A08+GMT%2B0530+(India+Standard+Time)&version=6.29.0&isIABGlobal=false&hosts=&landingPath=NotLandingPage&groups=C0001%3A1%2CC0002%3A1%2CC0003%3A1%2CC0004%3A1&AwaitingReconsent=false&geolocation=IN%3BKA; OptanonAlertBoxClosed=2022-08-11T20:21:08.758Z'"
    };

    // GET video response
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
      var startingIndex =
          longestScript.indexOf("var config = {") + "var config = {".length - 1;
      var endingIndex = longestScript.indexOf("};") + "};".length - 1;
      var jsonConfig = longestScript.substring(startingIndex, endingIndex);
      var videoConfig = jsonDecode(jsonConfig);
      var videoToPlay = videoConfig['request']['files']['progressive'][0];
      for (var video in videoConfig['request']['files']['progressive']) {
        if (videoToPlay['width']! < video['width']) {
          videoToPlay = video;
        }
      }
      print(videoToPlay['url']);

      setState(() {
        videoUrl = videoToPlay["url"];
      });

      print(videoUrl);

      ///
      ///
      title = document.getElementsByTagName("title")[0].text;
    });
  }
  //  Run command in the website Function
  // runJS(command) {
  //   return ctrl.runJavascript(command);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title.isNotEmpty ? Text(title) : const Text("Title"),
      ),
      body: Column(
        children: [
          Text("VideoUrl $videoUrl"),
          PodVideoPlayer(controller: controller),
        ],
      ),
    );
  }
}



// WebView(
//         initialUrl: "https://player.vimeo.com/video/730972653?h=eae2597c37",
//         onWebViewCreated: (WebViewController webViewController) async {
//           ctrl = webViewController;
//           var something = await webViewController.runJavascriptReturningResult(
//               '(function() { return JSON.stringify(config); })();');
//           print(something);
//         },
//         javascriptMode: JavascriptMode.unrestricted,
//         gestureNavigationEnabled: true,
//         onPageFinished: (_) async {},
//         onPageStarted: (_) async {},
//         onProgress: (_) {},
//       ),
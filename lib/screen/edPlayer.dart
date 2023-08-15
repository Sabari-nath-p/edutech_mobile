import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class edPlayer extends StatefulWidget {
  String url;
  edPlayer({super.key, required this.url});

  @override
  State<edPlayer> createState() => _edPlayerState();
}

class _edPlayerState extends State<edPlayer> {
  late var controller;

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    List option = widget.url.split("/");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.mathlabcochin.com')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse(
              'https://player.vimeo.com/video/${option[0]}?h=${option[1]}'),
          headers: {
            "Authorization": "Bearer c15bd5941857f4e8680986c11a94cf38"
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          child: WebViewWidget(
            controller: controller,
          ),
        ),
      ),
    );
  }
}

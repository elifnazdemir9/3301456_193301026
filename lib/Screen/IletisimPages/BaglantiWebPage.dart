
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class BaglantiWebPage extends StatefulWidget {
  @override
  BaglantiWebPageState createState() => BaglantiWebPageState();
}

class BaglantiWebPageState extends State<BaglantiWebPage> {
  double _progress=0;
  late String baslik;
  late String link;
  late InAppWebViewController webView;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.

    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    late List<dynamic> data1;
    data1 = ModalRoute.of(context)?.settings.arguments as List<dynamic>? ?? [];
    baslik=data1[0];
    link=data1[1];
    return Scaffold(
      appBar: AppBar(title: Text(baslik),),
      body:  Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(link)
              ),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                ),
              ),
              onWebViewCreated: (InAppWebViewController controller) {},
              // onLoadStart: (InAppWebViewController controller, Uri url) {},
              // onLoadStop: (InAppWebViewController controller, Uri url) {},

              onProgressChanged: (InAppWebViewController controller,int progress){
                setState(() {
                  _progress=progress/100;
                });
              },
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                print(challenge);
                return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
              },
            ),
            _progress<1?Center(child: CircularProgressIndicator()):SizedBox()
          ]
      ),
    );
  }
}
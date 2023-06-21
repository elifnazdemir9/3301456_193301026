import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SyncVisionPdfViewer extends StatefulWidget {
 

  const SyncVisionPdfViewer({Key? key,}) : super(key: key);

  @override
  _SyncVisionPdfViewerState createState() => _SyncVisionPdfViewerState();
}

class _SyncVisionPdfViewerState extends State<SyncVisionPdfViewer> {
  bool _downloading = false;
  late String _downloadPath = '';

  @override
  void initState() {
    super.initState();
    // _initDownloadPath();
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('PDF Viewer'),
      //   actions: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: IconButton(
      //         color: MainColor,
      //         icon: Icon(Icons.download),
      //         onPressed: () {
      //           print('clicked');
      //           FileStorage.writeCounter(
      //               myList.toString(), "geeksforgeeks.txt");
      //         },
      //         // onPressed: _downloading ? null : _downloadPDF,
      //       ),
      //     ),
      //   ],
      // ),
      body: SfPdfViewer.asset('assets/ELİFNAZDEMİRCV (1).pdf'),

    );
  }
}
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../Constants/sizer.dart';

class noteScreen extends StatefulWidget {
  String notelink;
  noteScreen({super.key, required this.notelink});

  @override
  State<noteScreen> createState() => _noteScreenState();
}

class _noteScreenState extends State<noteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            height: 55,
            color: Colors.white,
            child: Row(
              children: [
                width(20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(.1),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      )),
                ),
                width(5),
                SizedBox(
                    height: 45,
                    child: Image.asset("assets/icons/mathlablogo.png")),
              ],
            ),
          ),
          Expanded(
              child: SfPdfViewer.network(
            widget.notelink,
            scrollDirection: PdfScrollDirection.vertical,
          ))
        ],
      ),
    ));
  }
}

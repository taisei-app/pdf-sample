import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_sample/pdf_screen.dart';
// import 'package:pdfx/pdfx.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PDFScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String pdfPath = '';
  // late final PdfController controller;

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    // controller = PdfController(
    // viewportFraction: 1.0,
    //   document: PdfDocument.openAsset('assets/pdf/pdf-sample.pdf'),
    // );

    // _downloadAndSavePdf();
  }

  // Future<void> _downloadAndSavePdf() async {
  //   final response = await http.get(Uri.parse(
  //       'https://www.mhlw.go.jp/seisakunitsuite/bunya/koyou_roudou/roudoukijun/keiyaku/kaisei/dl/youshiki_01a.pdf'));
  //   final pdfData = response.bodyBytes;
  //   final directory = await getApplicationDocumentsDirectory();
  //   final pdfFile = File('${directory.path}/sample.pdf');
  //   await pdfFile.writeAsBytes(pdfData);
  //   setState(() {
  //     pdfPath = pdfFile.path;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.clear),
                                ),
                                const Spacer(flex: 2),
                                const Text(
                                  "労働通知書",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(flex: 3),
                              ],
                            ),
                          ),

                          PDFView(
                            filePath: 'assets/pdf/pdf-sample.pdf',
                            enableSwipe: true,
                            swipeHorizontal: true,
                            autoSpacing: false,
                            pageFling: false,
                            onRender: (_pages) {
                              // setState(() {
                              //   pages = _pages;
                              //   isReady = true;
                              // });
                            },
                            onError: (error) {
                              debugPrint(error.toString());
                            },
                            onPageError: (page, error) {
                              debugPrint('$page: ${error.toString()}');
                            },
                            onViewCreated:
                                (PDFViewController pdfViewController) {
                              _controller.complete(pdfViewController);
                            },
                            onPageChanged: (int? page, int? total) {
                              debugPrint('page change: $page/$total');
                            },
                          ),
                          // Expanded(
                          //   child: PdfView(
                          //     controller: controller,
                          //     scrollDirection: Axis.vertical,
                          //     renderer: (PdfPage page) => page.render(
                          //       width: page.width,
                          //       height: page.height,
                          //       format: PdfPageImageFormat.jpeg,
                          //       backgroundColor: '#FFFFFF',
                          //       forPrint: true,
                          //       cropRect: Rect.fromLTWH(
                          //         0,
                          //         0,
                          //         page.width,
                          //         page.height,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text("労働条件通知書表示"),
            ),
          ],
        ),
      ),
    );
  }
}

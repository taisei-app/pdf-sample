import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfxPage extends StatefulWidget {
  const PdfxPage({super.key});

  @override
  PdfxPageState createState() => PdfxPageState();
}

class PdfxPageState extends State<PdfxPage> {
  String pdfPath = '';
  late final PdfController controller;

  @override
  void initState() {
    super.initState();
    controller = PdfController(
      viewportFraction: 1.0,
      document: PdfDocument.openAsset('assets/pdf/pdf-sample.pdf'),
    );
  }

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
                          Expanded(
                            child: PdfView(
                              controller: controller,
                              scrollDirection: Axis.vertical,
                              renderer: (PdfPage page) => page.render(
                                width: page.width,
                                height: page.height,
                                format: PdfPageImageFormat.jpeg,
                                backgroundColor: '#FFFFFF',
                                forPrint: true,
                                cropRect: Rect.fromLTWH(
                                  0,
                                  0,
                                  page.width,
                                  page.height,
                                ),
                              ),
                            ),
                          ),
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

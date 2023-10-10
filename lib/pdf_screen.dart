import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pdfProvider = FutureProvider<Uint8List>((ref) async {
  ByteData data = await rootBundle.load("assets/pdf/pdf-sample.pdf");
  return data.buffer.asUint8List();
});

class PDFScreen extends ConsumerWidget {
  PDFScreen({super.key});
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(pdfProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            asyncValue.when(
              data: (data) {
                return ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      backgroundColor: Colors.white,
                      context: context,
                      isScrollControlled: true,
                      enableDrag: false,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                child: PDFView(
                                  pdfData: data,
                                  enableSwipe: true,
                                  swipeHorizontal: false,
                                  autoSpacing: true,
                                  pageFling: false,
                                  pageSnap: true,
                                  defaultPage: currentPage,
                                  fitPolicy: FitPolicy.BOTH,
                                  preventLinkNavigation: false,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text("労働条件通知書を表示"),
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

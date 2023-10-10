import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlutterCachePdfview extends ConsumerWidget {
  const FlutterCachePdfview({super.key});
  static const currentPage = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            ElevatedButton(
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
                            child: const PDF(
                              pageFling: false,
                              fitPolicy: FitPolicy.BOTH,
                            ).cachedFromUrl(
                              'https://www.mhlw.go.jp/seisakunitsuite/bunya/koyou_roudou/roudoukijun/keiyaku/kaisei/dl/youshiki_01a.pdf',
                              placeholder: (progress) =>
                                  Center(child: Text('$progress %')),
                              errorWidget: (error) =>
                                  Center(child: Text(error.toString())),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text("労働条件通知書を表示"),
            ),
          ],
        ),
      ),
    );
  }
}

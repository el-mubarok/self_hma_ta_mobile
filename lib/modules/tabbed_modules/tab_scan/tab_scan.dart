import 'package:flutter/material.dart';

import '../../../shared/ui/widgets/widget_tabbed_page_wrapper.dart';

class PageTabScan extends StatefulWidget {
  const PageTabScan({super.key});

  @override
  State<StatefulWidget> createState() => _PageTabScan();
}

class _PageTabScan extends State<PageTabScan> {
  @override
  Widget build(BuildContext context) {
    return WidgetTabbedPageWrapper(
      child: Column(
        children: const <Widget>[
          Text("Scan"),
        ],
      ),
    );
  }
}

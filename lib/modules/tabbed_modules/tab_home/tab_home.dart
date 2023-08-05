import 'package:flutter/material.dart';

import '../../../shared/ui/widgets/widget_tabbed_page_wrapper.dart';

class PageTabHome extends StatefulWidget {
  const PageTabHome({super.key});

  @override
  State<StatefulWidget> createState() => _PageTabHome();
}

class _PageTabHome extends State<PageTabHome> {
  @override
  Widget build(BuildContext context) {
    return WidgetTabbedPageWrapper(
      child: Container(),
    );
  }
}

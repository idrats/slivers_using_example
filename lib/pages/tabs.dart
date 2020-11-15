import 'package:flutter/material.dart';
import 'package:slivers/pages/slivers.dart';

class TabsPage extends StatefulWidget {
  TabsPage({Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              // This widget takes the overlapping behavior of the SliverAppBar,
              // and redirects it to the SliverOverlapInjector below. If it is
              // missing, then it is possible for the nested "inner" scroll view
              // below to end up under the SliverAppBar even when the inner
              // scroll view thinks it has not been scrolled.
              // This is not necessary if the "headerSliverBuilder" only builds
              // widgets that do not overlap the next sliver.
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                floating: true,
                pinned: true,
                title: Text('Заголовок'),
                forceElevated: boxIsScrolled,
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: '1', icon: Icon(Icons.access_alarms_rounded)),
                    Tab(text: '2', icon: Icon(Icons.label_outline_rounded)),
                    Tab(text: '3', icon: Icon(Icons.dynamic_feed_rounded)),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(color: Colors.brown),
            Padding(padding: EdgeInsets.only(top: 120), child: SliversPage()),
            Container(color: Colors.red),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:russian_words/russian_words.dart';

class SliversPage extends StatefulWidget {
  SliversPage({Key key}) : super(key: key);

  @override
  _SliversPageState createState() => _SliversPageState();
}

final colorsRandomizer = RandomColor();
final texts = generateWordPairs().take(100).toList();

List<Widget> generateRandomList({int count = 10}) {
  final result = <Widget>[];
  final wordPairs = generateWordPairs().take(count).toList();
  for (int i = 0; i < count; i++) {
    final color = colorsRandomizer.randomColor();
    result.add(Container(
      padding: EdgeInsets.all(8),
      color: color,
      child: Center(
        child: Text(
          wordPairs[i].asPascalCase,
          style: TextStyle(
              fontSize: 18,
              color:
                  color.computeLuminance() > 0.5 ? Colors.black : Colors.white),
        ),
      ),
    ));
  }
  return result;
}

class _SliversPageState extends State<SliversPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Планета Земля'),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/0/0d/Africa_and_Europe_from_a_Million_Miles_Away.png'),
            ),
            backgroundColor: Colors.black,
            pinned: true,
            floating: true,
            snap: false,
            stretch: false,
          ),
          SliverPersistentHeader(
            delegate: HeaderDelegate(title: 'Header 1', color: Colors.brown),
            pinned: true,
            floating: true,
          ),
          SliverPersistentHeader(
            delegate: HeaderDelegate(
                title: 'Header 2',
                color: Colors.brown[800],
                maxExtentValue: 100),
            pinned: true,
          ),
          SliverFixedExtentList(
            delegate: SliverChildListDelegate(generateRandomList(count: 20)),
            itemExtent: 50,
          ),
          SliverToBoxAdapter(
            child: Container(
              width: 30,
              height: 60,
              color: Colors.black,
              child: Center(
                child: Text(
                  'SliverToBoxAdapter',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              width: 30,
              height: 60,
              color: Colors.white,
              child: Center(
                child: Text(
                  'SliverFillRemaining',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              final color = colorsRandomizer.randomColor();
              return Container(
                padding: EdgeInsets.all(8),
                color: color,
                child: Center(
                  child: Text(
                    texts[index].asPascalCase,
                    style: TextStyle(
                        fontSize: 18,
                        color: color.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white),
                  ),
                ),
              );
            }, childCount: 100),
            //  SliverChildListDelegate(generateRandomList(count: 20)),
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8)
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8),
          )
        ],
      ),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Color color;
  final String title;
  final double minExtentValue;
  final double maxExtentValue;

  HeaderDelegate(
      {this.color = Colors.black,
      this.title = '',
      this.minExtentValue = 50,
      this.maxExtentValue = 150});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              fontSize: 18,
              color:
                  color.computeLuminance() > 0.5 ? Colors.black : Colors.white),
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxExtentValue;

  @override
  double get minExtent => minExtentValue;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

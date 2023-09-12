import 'package:flutter/material.dart';



class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0, // The height of the app bar when it's expanded
          floating: false, // The app bar won't float as you scroll
          pinned: true, // The app bar stays pinned at the top
          flexibleSpace: FlexibleSpaceBar(
            title: Text('My App Bar'),
          ),
        ),
        SliverPersistentHeader(
          delegate: _SliverAppBarDelegate(
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FilterButton(text: 'Filter 1'),
                  FilterButton(text: 'Filter 2'),
                  FilterButton(text: 'Filter 3'),
                ],
              ),
            ),
          ),
          pinned: true, // This header will be pinned to the top
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
            childCount: 50, // Number of list items
          ),
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;

  FilterButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(text),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => 0.0;

  @override
  double get maxExtent => 60.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

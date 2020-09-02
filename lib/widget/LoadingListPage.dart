import 'package:cloudmed_app/item/shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingListPage extends StatefulWidget {
  final bool isDark;

  LoadingListPage({this.isDark});

  @override
  _LoadingListPageState createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Shimmer.fromColors(
                baseColor: widget.isDark ? Colors.grey[300] : Colors.grey[700],
                highlightColor:
                    widget.isDark ? Colors.grey[100] : Colors.grey[600],
                enabled: true,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    itemBuilder: (_, __) => ShimmerItem(),
                    itemCount: 6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

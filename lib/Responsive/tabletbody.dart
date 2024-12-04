import 'package:flutter/material.dart';
import 'package:portfolio_app/config/colors.dart';

class Tabletbody extends StatefulWidget {
  const Tabletbody({super.key});

  @override
  State<Tabletbody> createState() => _TabletbodyState();
}

class _TabletbodyState extends State<Tabletbody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffold,
      appBar: AppBar(
        backgroundColor: appbar,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Container(
                  color: Colors.grey,
                  height: 260,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: EdgeInsets.all(11.0),
                  child: Container(
                    color: Colors.amber,
                    height: 120,
                  ),
                );
              },
              childCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
